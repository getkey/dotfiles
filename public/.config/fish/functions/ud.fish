function ud
	argparse 'l/latest' -- $argv

	if command -s nixos-rebuild > /dev/null
		if set -q _flag_latest
			echo 'Skipping lag, using live channel tip'
			sudo nix-channel --add https://channels.nixos.org/nixos-26.05 nixos
		else
			set -l lag_seconds 172800 # 2 days

			set -l rev (curl -s -H "Accept: application/json" "https://hydra.nixos.org/jobset/nixos/release-26.05/evals" | python3 -c "
import json, sys
try:
    evals = json.load(sys.stdin)['evals']
    cutoff = evals[0]['timestamp'] - $lag_seconds
    for e in evals:
        if e['timestamp'] <= cutoff:
            rev = e.get('jobsetevalinputs', {}).get('nixpkgs', {}).get('revision')
            if rev:
                print(rev)
                break
except Exception:
    pass
" 2>/dev/null)

			if test -z "$rev"
				echo 'Could not determine an older cached revision, falling back to the live channel tip'
				sudo nix-channel --add https://channels.nixos.org/nixos-26.05 nixos
			else
				echo "Pinning nixos channel to nixpkgs revision $rev (>=2 days old, should be fully cached)"
				sudo nix-channel --add https://github.com/NixOS/nixpkgs/archive/$rev.tar.gz nixos
			end
		end

		sudo nix-channel --update
		sudo nixos-rebuild switch
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
end
