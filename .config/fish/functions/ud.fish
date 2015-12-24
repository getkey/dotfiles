function ud
	if command -s yaourt > /dev/null
		yaourt -Syua
	else if command -s pacman > /dev/null
		pacman -Syu
	else if command -s apt-get > /dev/null
		sudo apt-get update
		and sudo apt-get upgrade
	end
end
