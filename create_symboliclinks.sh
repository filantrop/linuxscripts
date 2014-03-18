#! /bin/bash

SOURCEDIR=$1
DESTDIR=$2

mkdir -p "$DESTDIR"
cd -- "$SOURCEDIR"

#find -maxdepth 1 -type d -exec ln --symolic  -- "$DESTDIR"/{} \;

find * -maxdepth 0 -exec ln --symbolic -- "$SOURCEDIR"/{} "$DESTDIR"/{} \;



