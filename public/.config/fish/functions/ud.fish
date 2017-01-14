function ud
	if command -s yaourt > /dev/null
		yaourt -Syua
	else if command -s pacman > /dev/null
		sudo pacman -Syu
	else if command -s apt-get > /dev/null
		sudo apt-get update
		and sudo apt-get upgrade
	else
		echo 'No package manager detected'
		return 1
	end
end
