#! /bin/bash
# Renames remote directorires that contains the rename text
#in symbolic links to a new diretory
# a call could be ~/linuxscripts/rename_symobliclinks.sh /directory "drupal\-7\.28\.1" "drupal-7.32.1"

#Commands
READLINK=$(which readlink)

# Arguments
SOURCEDIR=$1
FIND=$2
REPLACE=$3

if [ "$#" -ne 3 ];then echo 'Call this script with e.g. /data/disk/o1/distro/001/ebiz-1.3.1 "drupal\-7\.28\.1" "drupal-7.32.1"';exit 0;fi

if [ -z "$SOURCEDIR" ];then echo "SOURCEDIR is not given";exit 0;fi
if [ ! -d "$SOURCEDIR" ];then echo "$SOURCEDIR does not exist";exit 0;fi
if [ -z "$FIND" ];then echo "FIND is not given";exit 0;fi
if [ -z "$REPLACE" ];then echo "REPLACE is not given";exit 0;fi

# Code
cd $SOURCEDIR

FILES=$(find `pwd` -type l)

for SOURCEFILE in $FILES; do
    DESTINATIONFILE=`$READLINK "$SOURCEFILE"`

    if [[ $DESTINATIONFILE =~ $FIND ]]
    then
        RESULT=$(echo "$DESTINATIONFILE"|sed -e "s/$FIND/$REPLACE/g")
        echo "$RESULT - $SOURCEFILE - $DESTINATIONFILE"
        ln -s $RESULT ${SOURCEFILE}_newfile_torename
        rm $SOURCEFILE
        mv ${SOURCEFILE}_newfile_torename $SOURCEFILE
        chown -h o1:users $SOURCEFILE
    fi        
done
