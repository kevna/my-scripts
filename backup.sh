#!/bin/sh
#script by Aaron Moore (kevna), all rights reserved
#tarball ~/scripts and all files named in backup.txt
#verbose output in backup.log

tarballFile=~/mtarball
logFile=~/backup.log

cd
echo $HOSTNAME
if [[ "$HOSTNAME" =~ "^.*\.aber\.ac\.uk" ]]; then
	echo "calling remote backup."
	ssh central 'backup.sh'
	echo "copying backup file."
	scp central:mtarball.tgz ~/
fi

if [ ! -e ~/backup.txt ]; then exit 0; fi
if [ -e ${tarballFile}.tgz ]; then
	mv ${tarballFile}.tgz ${tarballFile}.old
fi
tar cvf $tarballFile scripts > $logFile
if [ $? == 0 ]; then
	echo "tarball created (scripts)."
else
	echo "tarball creation failed." >&2
	exit 2
fi
	for files in $(cat ~/backup.txt | grep -v \#); do
		if [ -e $files ]; then
			tar rvf $tarballFile $files >> $logFile
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
gzip $tarballFile -S .tgz -v >> $logFile 2>&1
if [ $? == 0 ]; then
	echo "done."
else
	echo "compression failed." >&2
	exit 3
fi

