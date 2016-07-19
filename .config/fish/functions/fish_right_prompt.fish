function fish_right_prompt
	if not set -q __git_cb
		if test (git rev-parse --is-inside-work-tree 2> /dev/null ^&1 | tail -n 1) = "true"
			set __git_cb (parse_git_dirty)"["(git branch --list | grep "\*" | sed "s/\*\ //")(parse_git_changes)"] "(set_color normal)
		else
			set __git_cb ""
		end
	end
	echo $__git_cb
end
