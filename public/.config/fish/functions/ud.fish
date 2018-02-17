function ud
	if command -s yaourt > /dev/null
		argparse --name=ud 'n/noconfirm' -- $argv
		if set -q _flag_n; or set -q _flag_noconfirm
			yaourt -Syua --noconfirm
		else
			yaourt -Syua
		end
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
