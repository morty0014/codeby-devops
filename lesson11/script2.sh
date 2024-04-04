#!/bin/bash

#*********************************************************#
#                     Script v0.2                         #
#                   For Lesson: 11                        #
#          Refactoring script2.sh from lesson: 10         #
#*********************************************************#

cd ~ || exit
PATH_TO_DIR="$(pwd)"

# "myfolder" exist check
if [ -e "$PATH_TO_DIR"/myfolder ]
then

# files enumeration
    count=$(find "$PATH_TO_DIR"/myfolder/ -type f | wc -l)
    echo "Number files: $count"

# file 2 permissions
    if [ -e "$PATH_TO_DIR"/myfolder/file2 ]
    then
	chmod 644 "$PATH_TO_DIR"/myfolder/file2
	echo "File2 set 644"
    fi

# find empty files
    find "$PATH_TO_DIR"/myfolder -empty -delete && echo "Empty file delete from $PATH_TO_DIR/myfolder"

# find files, delete lines (ex. 1 str)
    while IFS= read -r -d '' file; do
	head -n1 "$file" | tee "$file" >/dev/null;
    done <  <(find "$PATH_TO_DIR"/myfolder -type f -print0)

fi

