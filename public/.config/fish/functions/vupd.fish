function vupd -d 'Update Vundle plugins'
	set -lx SHELL (which sh)
	vim +BundleInstall! +BundleClean +qall
end
