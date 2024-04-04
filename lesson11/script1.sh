#!/bin/bash


#*******************************************************#
#                     Script v0.2                       #
#                   For Lesson: 11                      #
#          Refactoring script1.sh from lesson: 10       #
#*******************************************************#

# creating folder "myfolder" in homedir
cd ~ && mkdir -p ~/myfolder

# set variable "path" from homedir/myfolder
PATH_TO_DIR=$(pwd)/myfolder

# file1:  2 string "Hello" and "Date"
echo "Hello Codeby!!!" > "$PATH_TO_DIR"/file1
date >> "$PATH_TO_DIR"/file1

# file2:  empty file with attr 777 
touch "$PATH_TO_DIR"/file2 && chmod 777 "$PATH_TO_DIR"/file2

# file3:  generating string (20 char) 
tr -dc 'A-Za-z0-9!?%=' < /dev/urandom | head -c 20 > "$PATH_TO_DIR"/file3


# file4
# and
# file5: 2 empty files  
touch "$PATH_TO_DIR"/file4 && touch "$PATH_TO_DIR"/file5