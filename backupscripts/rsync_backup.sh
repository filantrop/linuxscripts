#! /bin/bash
set -x

# Arguments
SOURCE_PORT=$1
SOURCE=$2
DESTINATION=$3


# Check if all arguments is present
if [ "$#" -ne 3 ]; then
    echo "Illegal number of paramaters"
    exit 1
fi

# Create date and paths
date=`date "+%Y-%m-%dT%H:%M:%S"`
NOW=$(date +"%Y-%m-%d_%H%M")
LOGFILE=$DESTINATION/${NOW}.log
DESTINATION_BACKUP_PATH=$DESTINATION/b-$date
LINK_DESTINATION=$DESTINATION/current


# Create linkpath if it does not exist
if [ ! -d $LINK_DESTINATION ]; then
   DUMMY_LINK_DESTINATION=$DESTINATION/date-dummy
   mkdir -p $DUMMY_LINK_DESTINATION
   ln -s $DUMMY_LINK_DESTINATION $LINK_DESTINATION
fi

# Setup rsync command
BR="/usr/bin/rsync -av --delete --inplace --rsh='ssh -p $SOURCE_PORT' --link-dest='$LINK_DESTINATION' $SOURCE $DESTINATION_BACKUP_PATH "

echo $BR
echo "">$LOGFILE
eval $BR 2>> $LOGFILE

rm -f $LINK_DESTINATION
ln -s $DESTINATION_BACKUP_PATH $LINK_DESTINATION
