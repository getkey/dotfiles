set fish_greeting

set __fish_prompt_cwd (set_color -o $fish_color_cwd)


set fish_git_dirty_color -o yellow
set fish_git_clean_color -o green

function parse_git_dirty
	if test (env LANG=en_EN.UTF-8 git status | tail -n1) != "nothing to commit, working directory clean"
		echo (set_color $fish_git_dirty_color)
	else
		echo (set_color $fish_git_clean_color)
	end
end

function parse_git_changes
	echo (env LANG=en_EN.UTF-8 git diff --stat | tail -n1 | sed "s/\,//g" | sed "s/ files\{0,1\}\ changed/~/" | sed "s/ insertions\{0,1\}(+)/+/" | sed "s/ deletions\{0,1\}(-)/-/")
end


function fish_prompt
	if not set -q __fish_prompt_normal
		set -g __fish_prompt_normal (set_color normal)
	end

	switch $USER
	
		case root			
			set __fish_prompt_cwd (set_color -o $fish_color_cwd_root)		
			printf "%s%s #%s " $__fish_prompt_cwd (prompt_pwd) (set_color normal)
		case '*'
			printf "%s%s >%s " $__fish_prompt_cwd (prompt_pwd) (set_color normal)

	end
end

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
