#! /bin/bash
# Creates symbolic links from sourcedirectory in destinationdirectory
# Searches only in root of sourcedirectory according to maxdepth
SOURCEDIR=$1
DESTDIR=$2

mkdir -p "$DESTDIR"
cd -- "$SOURCEDIR"

# Search all files, could be extended to us -type f for files or -type d for directories
find * -maxdepth 0 -exec ln --symbolic -- "$SOURCEDIR"/{} "$DESTDIR"/{} \;



