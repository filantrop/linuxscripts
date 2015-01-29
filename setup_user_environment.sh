#!/bin/bash
if [ -L $0 ] ; then
    SCRIPT_DIR=$(dirname $(readlink -f $0)) ;
else
    SCRIPT_DIR=$(dirname $0) ;
fi ;
CALLING_DIR=`pwd`

echo $SCRIPT_DIR
echo $CALLING_DIR


ln -s $SCRIPT_DIR/.bash_aliases $CALLING_DIR/.bash_aliases
ln -s $SCRIPT_DIR/.vimrc $CALLING_DIR/.vimrc
ln -s $SCRIPT_DIR/.screenrc $CALLING_DIR/.screenrc
ln -s $SCRIPT_DIR/.bashrc $CALLING_DIR/.bashrc

source $CALLING_DIR/.bashrc
