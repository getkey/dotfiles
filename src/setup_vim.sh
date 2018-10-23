#!/bin/sh

SHELL=/bin/sh # See https://github.com/VundleVim/Vundle.vim/wiki#faq4

. utility.sh

if type vim > /dev/null 2>&1 && type git > /dev/null 2>&1; then
	if [ ! -d $HOME/.vim/bundle/Vundle.vim ]; then
		git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
	else
		cd $HOME/.vim/bundle/Vundle.vim
		printf "Updating Vundle: $(git pull)\n"
	fi
	vim +PluginInstall +qall -u $HOME/.vim/vundle-loader.vim # Install Vundle plugins

	cd ~/.vim/bundle/tomorrow-theme
	git checkout origin/vim-javascript

	options=""
	if type clang > /dev/null 2>&1; then
		options="$options --system-libclang --clang-completer"
	fi
	if [ -e /usr/include/boost ]; then
		options="$options --system-boost"
	fi
	if type node > /dev/null 2>&1 && type npm > /dev/null 2>&1; then
		options="$options --tern-completer"
	fi
	if type rustc > /dev/null 2>&1 && type cargo > /dev/null 2>&1; then
		options="$options --racer-completer"
	fi

	python2 $HOME/.vim/bundle/YouCompleteMe/install.py $options
fi
