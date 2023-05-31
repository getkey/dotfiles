function nal
	gocryptfs $NAL_PATH ~/mnt/
	read -P 'Where are you? ' location
	printf '\n\n## '(date '+%F %R')', '$location'\n\n' >> ~/mnt/journal/journal.md
	$EDITOR '+normal Go' +startinsert ~/mnt/journal/journal.md
end
