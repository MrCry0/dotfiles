# dotfiles

Personal configuration files for bash, vim, and git, plus an install
script that symlinks everything into place.

## Layout

- `dotfiles/` - files linked into `~` (bashrc, bash_aliases, gitconfig,
  gitexcludes, gitmessage.txt, inputrc, lesskey, lsan.suppressions,
  offlineimaprc, vimrc, bcrc)
- `bash-local/` - extra bash snippets linked into `~/.bash/`
- `vim-conf/` - core vim config linked into `~/.vim`
- `vim-plugins/` - vim plugins linked into `~/.vim/plugin`
- `vim-ftplugin/` - filetype plugins linked into `~/.vim/ftplugin`
- `git-aware-prompt/` - git-aware bash prompt (submodule)

## Install

```
git clone --recurse-submodules git@github.com:MrCry0/dotfiles.git
cd dotfiles
./install.sh
```

The script creates the required directories, backs up any existing
files it would overwrite into `~/.backup-dotfiles` (and the matching
vim/bash-local backup directories), and symlinks the files from this
repo into place.
