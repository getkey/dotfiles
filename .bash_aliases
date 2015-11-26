olimex='getkey@getkey.eu'
alias ss="ssh $olimex"
alias st="ssh -t $olimex tmux a || ssh -t $olimex tmux"
alias sr="rsync --exclude='node_modules' --exclude='shared' --delete -azv ~/devel/getkey $olimex:~/"

alias ud='(type yaourt > /dev/null 2>&1 && yaourt -Syua) || (type pacman > /dev/null 2>&1 && sudo pacman -Syu) || (type apt-get > /dev/null 2>&1 && sudo apt-get update && sudo apt-get upgrade)'
alias orcl="sudo pacman -Rsn \$(echo \$(pacman -Qdtq))" # echo to remove the line break

alias ada='gnatmake -gnato -gnatv'
alias cada='gnatgcc -c -gnatv -gnato'

sudo() {
	# use sudo's path to prevent this function from calling itself
	if [ $1 = 'vim' ]; then
		$(which sudo) -E $@
	else
		$(which sudo) $@
	fi
}
