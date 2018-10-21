#!/bin/sh

recursive_setup() {
	# TODO: split this up in composable function so that different functions are used for copy and link
	# $1 is the root directory
	# $2 is the command that should be used to link/copy
	dir_path=$project_root/$1

	for file in $(find $dir_path ! -path $dir_path); do

		base_file=${file#$dir_path}
		home_twin=$HOME$base_file


		if [ -d $file ] && [ ! -d $home_twin ]; then
			if [ -e $home_twin ]; then
				e_error "Error: can't create directory $home_twin; a file is present already. Aborting"
				exit 1
			else
				mkdir $home_twin
			fi
		elif [ -h $home_twin ] && type readlink > /dev/null 2>&1 && [ $(readlink $home_twin) != $file ]; then
			ln -sf $file $home_twin #overwrite incorrect links
		elif [ -f $file ] && [ ! -h $home_twin ]; then
			if [ -f $home_twin ]; then
				e_warning "The file $file already exists."
				e_prompt "Overwrite it? (y=yes n=no a=archive)"
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
								e_error "another $base_file file is present in $archi_path. Aborting\n"
								exit 1
							fi
							;;
						y)
							break
							;;
						*)
							e_error "Invalid choice."
							e_prompt "Try again, shall I overwrite it ? (y=yes n=no a=archive)"
							;;
					esac
				done
			fi

			$2 $file $home_twin
		fi

	done
}

cd $(dirname $0) # go to the directory containing this script
project_root=$(pwd -P) # get cwd so we are sure `$project_root` is not a symlink
link='ln -sf'

recursive_setup 'public' "$link"
recursive_setup 'copy' 'cp'

if [ $USER = 'getkey' -o $USER = 'mourerj' -o $USER = 'julien' ]; then
	recursive_setup 'personal' "$link"
fi
