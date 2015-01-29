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
    fi        
done
