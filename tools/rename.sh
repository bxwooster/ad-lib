#!/bin/bash

if [ -z "$1" ]; then
	echo First argument?
	exit 1
fi

if [ -z "$2" ]; then
	echo Second argument?
	exit 2
fi

if [ -n "$3" ]; then
	echo What? Third argument?
	exit 3
fi

files=$(find code -name \*$1\*.c -o -name \*$1\*.h)
for file in $files; do
	renamed=$(echo $file | sed s/$1/$2/)
	git mv $file $renamed
done ;

gsed -i s/$1/$2/g `find code -name \*.c -o -name \*.h`
