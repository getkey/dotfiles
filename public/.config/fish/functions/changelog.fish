function changelog -d 'Print all the git commits since the previous version'
	git log (git describe --tags --abbrev=0)..HEAD --graph --date=relative --topo-order --pretty="format:%C(yellow)%h%Creset %s (%Cgreen%an%Creset)"
end
