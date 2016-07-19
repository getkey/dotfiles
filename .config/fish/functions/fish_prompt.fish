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
