#!/bin/bash

cat list | \
while read file _file
do
	if [ ! -z "$file" ]; then
		echo "Saving $file to $_file"
		cp $file $_file
	fi
done

