#!/bin/sh

while read -r line; do
	filename=$(echo $line | rev | cut -d'#' -f 1 | rev)
	wget $line -O $filename
done < $1
