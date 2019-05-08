#!/bin/sh -xe

for file in vimrc bashrc bash_aliases gitconfig gitexcludes muttrc bcrc lsan.suppressions offlineimaprc lesskey inputrc; do
    rm -f ~/.$file
    ln -s $PWD/$file ~/.$file;
done

mkdir -p ~/.vim/tmp/
for file in linuxsty.vim qml.vim; do
    rm -f ~/.vim/plugin/$file;
    ln -s $PWD/$file ~/.vim/plugin/$file;
done

touch ~/.bash_history

