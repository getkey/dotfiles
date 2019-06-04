#!/bin/sh

if type nvim > /dev/null 2>&1 && type git > /dev/null 2>&1; then
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	nvim +PlugInstall +qall # Install Vundle plugins
fi
