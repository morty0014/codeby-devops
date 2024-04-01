#!/bin/bash

mkdir -p ~/myfolder

# file 1
echo "Hello Codeby!!!" > ~/myfolder/file1
echo `date` >> ~/myfolder/file1

# file 2
touch ~/myfolder/file2 && chmod 777 ~/myfolder/file2

# file 3
text=$(tr -dc 'A-Za-z0-9!?%=' < /dev/urandom | head -c 20)
echo ${text} > ~/myfolder/file3

# file 4 and 5
touch ~/myfolder/file4 && touch ~/myfolder/file5