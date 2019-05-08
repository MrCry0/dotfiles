#!/bin/bash

DOTFILES=${PWD}/dotfiles
VIMPLUGINS_SRC=${PWD}/vim-plugins
VIMPLUGINS_DST=~/.vim/plugin

BACKUP_DF=~/.backup-dotfiles
BACKUP_VP=~/.vim/backup-plugins

echo Installing dot-files and vim plugins:

echo -n Creating backup directory for dotfiles...
mkdir -p ${BACKUP_DF} || { echo "Can't make backup directory \"${BACKUP_DF}\" for dotfiles"; exit; }
echo Done

# Optional step, vimrc includes making this directory if not exist.
echo -n Creating directory for vim backup files...
mkdir -p ~/.vim/tmp || { echo "Can't make a directory \"~/.vim/tmp\" for vim backup files"; exit; }
echo Done

echo -n Creating directory for vim plugins...
mkdir -p ${VIMPLUGINS_DST} || { echo "Can't make directory \"${VIMPLUGINS_DST}\" for vim plugins"; exit; }
echo Done

echo -n Creating backup directory for vim plugins...
mkdir -p ${BACKUP_VP} || { echo "Can't make backup directory \"${BACKUP_VP}\" for vim plugins"; exit; }
echo Done

for local file in $(ls ${DOTFILES}/[^.]* | xargs -n 1 basename); do
	echo -n Installing ${file}...
	mv ~/.${file} ${BACKUP_DF}/ || { echo "Can't backup ${file} into ${BACKUP_DF}"; exit; }
	ln -s ${DOTFILES}/${file} ~/.${file};
	echo Done
done

for local file in $(ls ${VIMPLUGINS_SRC}/[^.]*.vim | xargs -n 1 basename); do
	echo -n Installing vim-plugin ${file}...
	mv ~/.vim/plugin/$file ${BACKUP_VP}/;
	ln -s ${VIMPLUGINS_SRC}/$file ${VIMPLUGINS_DST}/$file;
	echo Done
done

touch ~/.bash_history

echo Finish.

echo Installing git-aware-prompt bash plugin
git submodule init git-aware-prompt
git submodule update git-aware-prompt
rm -rf ~/.bash/git-aware-prompt
ln -s ${PWD}/git-aware-prompt ~/.bash/

