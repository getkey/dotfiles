#!/bin/sh
SHELL=/bin/sh # See https://github.com/VundleVim/Vundle.vim/wiki#faq4

link_dir() {
	dir_path=$dot_path/$1

	for file in $(find $dir_path ! -path $dir_path); do

		base_file=${file#$dir_path}
		home_twin=$HOME$base_file


		if [ -d $file ] && [ ! -d $home_twin ]; then
			if [ -e $home_twin ]; then
				printf "Error: can't create directory $home_twin; a file is present already. Aborting\n"
				exit 1
			else
				mkdir $home_twin
			fi
		elif [ -h $home_twin ] && type readlink > /dev/null 2>&1 && [ $(readlink $home_twin) != $file ]; then
			ln -sf $file $home_twin #overwrite incorrect links
		elif [ -f $file ] && [ ! -h $home_twin ]; then
			if [ -f $home_twin ]; then
				printf "The file $file already exists. Overwrite it? (y=yes n=no a=archive) "
				while true; do
					read choice
					case $choice in
						n)
							continue 2
							;;
						a)
							archi_path=$HOME/dotarchive
							if [ ! -e $archi_path ]; then
								mkdir $archi_path
							fi

							if [ ! -e $archi_path$base_file ]; then
								mv $home_twin $archi_path
								break
							else
								printf "Error: another $base_file file is present in $archi_path. Aborting\n"
								exit 1
							fi
							;;
						y)
							break
							;;
						*)
							printf 'Invalid choice. Try again, shall I overwrite it ? (y=yes n=no a=archive) '
							;;
					esac
				done
			fi

			ln -sf $file $home_twin
		fi

	done
}

cd ${0%/*}
dot_path=$(pwd -P)

link_dir 'public'

if [ $USER = 'getkey' -o $USER = 'mourerj' ]; then
	link_dir 'personal'
fi

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
