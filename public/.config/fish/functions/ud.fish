function ud
	if command -s nixos-rebuild > /dev/null
		sudo nixos-rebuild switch --upgrade-all
	else if command -s yay > /dev/null
		yay
	else if command -s pacman > /dev/null
		sudo pacman -Syu
	else if command -s apt-get > /dev/null
		sudo apt-get update
		and sudo apt-get upgrade
	else if command -s brew > /dev/null
		brew upgrade
	else
		echo 'No package manager detected'
		return 1
	end

	if command -s yarn > /dev/null
		yarn global upgrade-interactive
	end
end
