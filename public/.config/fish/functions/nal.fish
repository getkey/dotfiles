function nal
	if not mount | string match -q "* on $HOME/mnt (*"
		gocryptfs $NAL_PATH ~/mnt/; or return
	end
	read -P 'Where are you? ' location
	printf '\n\n## '(date '+%F %R')', '$location'\n\n' >> ~/mnt/journal/journal.md
	$EDITOR '+normal Go' +startinsert ~/mnt/journal/journal.md
end
