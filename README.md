bash scripts
============

My command line scripts written for the linux Bourne Again SHell.
They attempt to conform to the UNIX principle - 'do ONE thing and do it well' and they output their warning and fatal error messages through STDERR

backup.sh
---------
"backup.sh" backs up files listed in the file ~/backup.txt, if not running on the named server it will also call the server copy of the script & download the resulting tarball

addwatermark
------------
"addwatermark" places watermarks on to images, it takes a space delimited list of one or more files along with a list of zero or more switches (also space delimited) from:
* -h/?	display help message and exit
* -r	replace file instead of generating new file
* -q	do not ask before replacing files
* -s	'spin' file (orients files using 'gravity')
* -f bar	specify "bar" as file to use as watermark
* -o #	specify # as percentage opacity of the watermark image
* -d bar	specify "bar" as the destination for the watermarked files
* -v/vv	use verbose (display progress) or very-verbose (also display file info) output

comptex
-------
"comptex" script compiles LaTeX document using pdflatex, it too takes a space delimited filename list and zero or more switches from:
* -h/?	display help and exit
* -n #	compiles the document # times (default = 3)

remspace.sh
-----------
"remspace.sh" simply iterates through a folder modifying the filenames to meet the following rules:
no capitals, no superfluous symbols, dashes replace spaces.

