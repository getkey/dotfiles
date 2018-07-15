function ud
	if command -s yay > /dev/null
		yay -Syua
	else if command -s pacman > /dev/null
		sudo pacman -Syu
	else if command -s apt-get > /dev/null
		sudo apt-get update
		and sudo apt-get upgrade
	else if command -s brew > /dev/null
		brew upgrade
		brew cask upgrade
	else
		echo 'No package manager detected'
		return 1
	end
end
