#!/bin/sh
#script by Aaron Moore (Kevna), all rights reserved
#iteratively cleans up filenames by replacing spaces
#or underscores or sequences of both of them and '-'
#with '-' characters


ls | while read -r FILE; do
	mv -v "$FILE" `echo $FILE | tr ' ' '_' | tr -d '[{}(),\!]' | tr -d "\'" | tr '[A-Z]' '[a-z]' | sed 's/[-_]\+/_/g' | sed '/_$/d'`
done
