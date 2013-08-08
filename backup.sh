#!/bin/bash
#script by Aaron Moore (Dent), all rights reserved
#tarball ~/scripts and all files named in backup.txt
#verbose output in backup.log
set position="$(pwd)"
if [ ! -e ~/scripts/backup.txt ]; then exit 1; fi;
cd /aber/aam13
if [ -e mtarball.tar.gz ]; then mv mtarball.tar.gz mtarball.old; fi;
tar cvf mtarball.tar scripts > backup.log
if [ $? == 0 ]; then echo "tarball created (scripts).";
else echo "tarball creation failed."; exit 1; fi;
for files in $(cat ~/scripts/backup.txt); do
	if [ ! $(echo $files|cut -c1-1) == '#'  ]; then if [ -e $files ]; then
		tar rvf mtarball.tar $files >> backup.log
		if [ $? == 0 ]; then echo "$files added to tarball.";
		else echo "failed to add $files to tarball."; fi;
	else echo "$files is not an existing directory or file."; fi; fi;
done
echo "compressing tarball."
gzip mtarball.tar
if [ $? == 0 ]; then echo "done."; else echo "compression failed."; exit 1; fi;
cd $position
