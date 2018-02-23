function orcl -d 'Remove orphan packages'
	if set orphans (pacman -Qdtq)
		sudo pacman -Rsn $orphans
	else
		echo 'No orphans to clean!'
	end
end
