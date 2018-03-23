#!/bin/sh

if [ -z $1 ]; then
	printf 'Usage:\n \t%s filename_containing_dl_urls\n' $0
	exit 1
fi

while read -r line; do
	filename=$(echo $line | rev | cut -d'#' -f 1 | rev)
	wget $line -O $filename
done < $1
