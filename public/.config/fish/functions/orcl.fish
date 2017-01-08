function orcl -d 'Remove orphan packages'
	sudo pacman -Rsn (pacman -Qdtq)
end
