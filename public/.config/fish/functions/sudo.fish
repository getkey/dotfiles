function sudo -w sudo
	# use `command` to prevent recursion
	if test $argv[1] = 'vim' -o $argv[1] = 'nvim' -o $argv[1] = 'nvim-qt'
		command sudo -E $argv[1..-1]
	else
		command sudo $argv[1..-1]
	end
end
