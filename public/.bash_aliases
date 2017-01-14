olimex='getkey@getkey.eu'
alias ss="ssh $olimex"
alias st="ssh -t $olimex tmux a || ssh -t $olimex tmux"

ud() {
	if type yaourt > /dev/null 2>&1; then
		yaourt -Syua
	elif type pacman > /dev/null 2>&1; then
		sudo pacman -Syu
	elif type apt-get > /dev/null 2>&1; then
		sudo apt-get update && sudo apt-get upgrade
	else
		echo 'No package manager detected'
		return 1
	fi
}
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
