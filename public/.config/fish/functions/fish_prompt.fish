function fish_prompt -d 'Write out the left prompt'
	set last_status $status

	if test $USER = 'root' > /dev/null
		set fmtd_user (set_color -o red) $USER
		set suffix '#'
	else
		set fmtd_user (set_color -o green) $USER
		set suffix '>'
	end

	if test $last_status = '0' > /dev/null
		set prompt_sign (set_color green) $suffix
	else
		set prompt_sign (set_color red) $suffix
	end

	echo -n -s $fmtd_user (set_color normal) @ (set_color -o green) (hostname) (set_color normal) ' ' (set_color -o blue) (prompt_pwd) (set_color -o blue) $prompt_sign (set_color normal) ' '
end
