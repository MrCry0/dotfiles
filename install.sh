#!/bin/bash

DOTFILES=${PWD}/dotfiles
VIMPLUGIN_SRC=${PWD}/vim-plugins
VIMPLUGIN_DST=~/.vim/plugin
VIMFTPLUGIN_SRC=${PWD}/vim-ftplugin
VIMFTPLUGIN_DST=~/.vim/ftplugin

BACKUP_DF=~/.backup-dotfiles
BACKUP_VIMPLUGIN=~/.vim/backup/plugin
BACKUP_VIMFTPLUGIN=~/.vim/backup/ftplugin

echo Installing dot-files and vim plugins:

echo -n Creating backup directory for dotfiles...
mkdir -p ${BACKUP_DF} || { echo "Can't make backup directory \"${BACKUP_DF}\" for dotfiles"; exit; }
echo Done

# Optional step, vimrc includes making this directory if not exist.
echo -n Creating directory for vim backup files...
mkdir -p ~/.vim/tmp || { echo "Can't make a directory \"~/.vim/tmp\" for vim backup files"; exit; }
echo Done

echo -n Creating directory for vim plugins...
mkdir -p ${VIMPLUGIN_DST} || { echo "Can't make directory \"${VIMPLUGIN_DST}\" for vim plugins"; exit; }
echo Done

echo -n Creating directory for vim ftplugins...
mkdir -p ${VIMFTPLUGIN_DST} || { echo "Can't make directory \"${VIMFTPLUGIN_DST}\" for vim plugins"; exit; }
echo Done

echo -n Creating backup directory for vim plugins...
mkdir -p ${BACKUP_VIMPLUGIN} || { echo "Can't make backup directory \"${BACKUP_VIMPLUGIN}\" for vim plugins"; exit; }
echo Done

echo -n Creating backup directory for vim plugins...
mkdir -p ${BACKUP_VIMFTPLUGIN} || { echo "Can't make backup directory \"${BACKUP_VIMFTPLUGIN}\" for vim plugins"; exit; }
echo Done

for file in $(ls ${DOTFILES}/[^.]* | xargs -n 1 basename); do
	echo -n Installing ${file}...
    F=~/.${file}
	if [ -e ${F} ]; then
        if [ -f ${F} ]; then
            mv -f ${F} ${BACKUP_DF}/ || { echo "Can't backup ${F} into ${BACKUP_DF}"; exit; }
        else
            rm -f ${F} || { echo "${F} is not a file and can't be deleted"; exit; }
        fi
    fi
	ln -s ${DOTFILES}/${file} ${F};
	echo Done
done

for file in $(ls ${VIMPLUGIN_SRC}/[^.]*.vim | xargs -n 1 basename); do
	echo -n Installing vim-plugin ${file}...
    F=${VIMPLUGIN_DST}/${file}
	if [ -e ${F} ]; then
        if [ -f ${F} ]; then
            mv -f ${F} ${BACKUP_VIMPLUGIN}/ || { echo "Can't backup ${F} into ${BACKUP_VIMPLUGIN}"; exit; }
        else
            rm -f ${F} || { echo "${F} is not a file and can't be deleted"; exit; }
        fi
    fi
	ln -s ${VIMPLUGIN_SRC}/$file ${VIMPLUGIN_DST}/${file};
	echo Done
done

for file in $(ls ${VIMFTPLUGIN_SRC}/[^.]*.vim | xargs -n 1 basename); do
	echo -n Installing vim-ftplugin ${file}...
    F=${VIMFTPLUGIN_DST}/${file}
	if [ -e ${F} ]; then
        if [ -f ${F} ]; then
            mv -f ${F} ${BACKUP_VIMFTPLUGIN}/ || { echo "Can't backup ${F} into ${BACKUP_VIMFTPLUGIN}"; exit; }
        else
            rm -f ${F} || { echo "${F} is not a file and can't be deleted"; exit; }
        fi
    fi
	ln -s ${VIMFTPLUGIN_SRC}/$file ${VIMFTPLUGIN_DST}/${file};
	echo Done
done

touch ~/.bash_history

echo Finish.

echo Installing git-aware-prompt bash plugin
git submodule init git-aware-prompt
git submodule update git-aware-prompt
mkdir -p ~/.bash
rm -rf ~/.bash/git-aware-prompt
ln -s ${PWD}/git-aware-prompt ~/.bash/
