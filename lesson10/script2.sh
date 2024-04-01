#!/bin/bash

cd ~
path=$(pwd)


if [ -e $path/myfolder ]
then

# files enumeration
    count=$(find $path/myfolder/ -type f | wc -l)
    echo "Number files: $count"

# file 2 permissions

    if [ -e $path/myfolder/file2 ]
    then
	chmod 644 $path/myfolder/file2
	echo "File2 set 644"
    fi

# find empty files
    find $path/myfolder -empty -delete && echo "Empty file delete from $path/myfolder"

# find files, delete lines (ex. 1 str)
    for file in `find $path/myfolder -type f`; do
	head -n1 $file | tee $file >/dev/null;
    done

fi

