#!/bin/bash
#script by Aaron Moore (Kevna), all rights reserved
#tarball ~/scripts and all files named in backup.txt
#verbose output in backup.log

tarballFile="mtarball"

cd
echo $HOSTNAME
if [[ "$HOSTNAME" != "central.aber.ac.uk" ]]; then
	echo "calling remote backup."
	ssh central 'backup.sh'
	echo "copying backup file."
	scp central:mtarball.tar.gz ~/
fi

if [ ! -e ~/backup.txt ]; then exit 0; fi
if [ -e ${tarballFile}.tar.gz ]; then
	mv ${tarballFile}.tar.gz ${tarballFile}.old
fi
tar cvf ${tarballFile}.tar scripts > backup.log
if [ $? == 0 ]; then
	echo "tarball created (scripts)."
else
	echo "tarball creation failed." >&2
	exit 1
fi
	for files in $(cat ~/backup.txt | grep -v \#); do
		if [ -e $files ]; then
			tar rvf ${tarballFile}.tar $files >> backup.log
			if [ $? == 0 ]; then
				echo "$files added to tarball."
			else
				echo "failed to add $files to tarball." >&2
			fi
		else
			echo "$files is not an existing directory or file." >&2
		fi
	done
echo "compressing tarball."
gzip ${tarballFile}.tar
if [ $? == 0 ]; then
	echo "done."
else
	echo "compression failed." >&2
	exit 1
fi

