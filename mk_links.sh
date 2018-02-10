#!/bin/sh

link_dir() {
	dir_path=$project_root/$1

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

cd $(dirname $0) # go to the directory containing this script
project_root=$(pwd -P) # get cwd so we are sure `$project_root` is not a symlink

link_dir 'public'

if [ $USER = 'getkey' -o $USER = 'mourerj' ]; then
	link_dir 'personal'
fi
