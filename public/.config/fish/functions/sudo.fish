function sudo
	# use `command` to prevent recursion
	if test $argv[1] = 'vim'
		command sudo -E $argv[1..-1]
	else
		command sudo $argv[1..-1]
	end
end
