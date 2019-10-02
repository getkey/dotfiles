function npm-switch -d 'Switch to a different NPM user'
	if test (count $argv) -lt 1
		echo 'Please provide an argument'
		return 1
	end

	cp ~/.npmrc-$argv[1] ~/.npmrc
end
