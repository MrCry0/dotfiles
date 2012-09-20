#!/bin/sh -x

for file in vimrc bashrc gitconfig gitexcludes muttrc; do
    rm -f ~/.$file
    ln -s $PWD/$file ~/.$file;
done

mkdir -p ~/.vim/tmp/

touch ~/.bash_history

