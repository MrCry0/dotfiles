#!/bin/bash

DOTFILES=${PWD}/dotfiles

BASHLOCAL=${PWD}/bash-local

VIMCONF_SRC=${PWD}/vim
VIMCONF_DST=~/.vim
VIMPLUGINS_SRC=${PWD}/vim-plugins
VIMPLUGINS_DST=~/.vim/plugin
VIMFTPLUGIN_SRC=${PWD}/vim-ftplugin
VIMFTPLUGIN_DST=${VIMCONF_DST}/ftplugin

BACKUP_DF=~/.backup-dotfiles
BACKUP_BL=~/.bash/backup-files
BACKUP_VIMCONF=${VIMCONF_DST}/backup
BACKUP_VIMPLUGIN=~/.vim/backup/plugin
BACKUP_VIMFTPLUGIN=~/.vim/backup/ftplugin

create_dir() {
    local DIR=$1
    local DESCR=$2

    echo -n "Creating directory for $DESCR..."
    if mkdir -p ${DIR}; then
        echo Done
        return 0
    else
        return -1
    fi
}

make_links() {
    local FILESPATH=$1
    local PREFIX=$2
    local BACKUP=$3

    for file in $(ls ${FILESPATH}/[^.]* | xargs -n 1 basename); do
        echo -n Installing ${file}...
        local F=${PREFIX}${file}
	    if [ -e ${F} ]; then
            if [ -f ${F} ]; then
                mv -f ${F} ${BACKUP}/ || { echo "Can't backup ${F} into ${BACKUP}"; exit; }
            else
                rm -f ${F} || { echo "${F} is not a file and can't be deleted"; exit; }
            fi
        fi
	    ln -s ${FILESPATH}/${file} ${F};
	    echo Done
    done
}

echo Installing dot-files and vim plugins:

create_dir ${BACKUP_DF} "backup dotfiles" || exit
create_dir ${BACKUP_BL} "bash local backup files" || exit

# Optional step, vimrc includes making this directory if not exist.
create_dir ~/.vim/tmp "vim backup files"

create_dir ${VIMCONF_DST} "vim config" || exit
create_dir ${VIMPLUGINS_DST} "vim plugins" || exit
create_dir ${BACKUP_VIMPLUGIN} "vim plugins backup" || exit
create_dir ${BACKUP_VIMFTPLUGIN} "vim FT plugins backup" || exit

make_links ${DOTFILES} ~/. ${BACKUP_DF}

make_links ${VIMCONF_SRC} ${VIMCONF_DST}/ ${BACKUP_VIMCONF}
make_links ${VIMPLUGINS_SRC} ${VIMPLUGINS_DST}/ ${BACKUP_VIMPLUGIN}
make_links ${VIMFTPLUGINS_SRC} ${VIMFTPLUGINS_DST}/ ${BACKUP_VIMFTPLUGIN}

touch ~/.bash_history

echo Finish.

echo Installing git-aware-prompt bash plugin
git submodule init git-aware-prompt
git submodule update git-aware-prompt
mkdir -p ~/.bash
rm -rf ~/.bash/git-aware-prompt
mkdir -p ~/.bash
ln -s ${PWD}/git-aware-prompt ~/.bash/

make_links ${BASHLOCAL} ~/.bash/ ${BACKUP_BL}
