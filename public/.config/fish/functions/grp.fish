function grp
	grep -rIn --exclude-dir=node_modules --exclude-dir=.git --exclude='*bundle.js' $argv
end
