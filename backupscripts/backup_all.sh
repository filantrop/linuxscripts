#! /bin/bash

# Declare array with rsyncpaths, or just include a file with data
#------------------------------------
declare -A FLS
#FLS['user ip source']="port destination"

declare -A SQL
#SQL['user ip']="port destination"

. backup_conf.sh


#-----------------------------------

REALPATH=$(which realpath)
#PWD=$(pwd)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RSYNC_COMMAND="$DIR/rsync_backup.sh"
MYSQL_COMMAND="$DIR/mysql_backup.sh"
BACKUP_DIR=$($REALPATH $DIR/../backups)
NOW=$(date +"%Y-%m-%d_%H%M")
DATE=`date "+%Y-%m-%dT%H:%M:%S"`

echo $BACKUP_DIR
echo $REALPATH
echo $DIR
echo $RSYNC_COMMAND

# Functions

function RUN_RSYNC {
    for key in "${!FLS[@]}"
        do
            KEY_ARR=($key)
                VALUE=(${FLS[$key]})

                USER=${KEY_ARR[0]}
        HOST=${KEY_ARR[1]}
        SOURCE=${KEY_ARR[2]}
        PORT=${VALUE[0]}
        DESTINATION=${VALUE[1]}

        COMBINED_SOURCE="$USER@$HOST:$SOURCE"
        BACKUP_PATH=$BACKUP_DIR/${HOST}${SOURCE}
#LOGFILE=$BACKUP_DIR/log/${NOW}.log
cat <<OUT
            user:   $USER 
            host:   $HOST 
            source: $SOURCE 
            port:   $PORT 
            destination: $DESTINATION 
            backup_path: $BACKUP_PATH
            combined_source: $COMBINED_SOURCE

OUT
        $RSYNC_COMMAND $PORT $COMBINED_SOURCE $BACKUP_PATH $DATE

        done
        wait
        echo "All rsync commands has finnished"
}

function RUN_MYSQLDUMP {
# Iterate all mysqdump lines
    for key in "${!SQL[@]}"
        do
            KEY_ARR=($key)
                VALUE=(${SQL[$key]})

                USER=${KEY_ARR[0]}
        HOST=${KEY_ARR[1]}
        PORT=${VALUE[0]}
        DESTINATION=${VALUE[1]}


# Run mysql backups
        $MYSQL_COMMAND $PORT $DESTINATION/$HOST/sql $USER $HOST $DATE
        done

        echo "Databasebackup has finnished"
}

RUN_RSYNC

RUN_MYSQLDUMP

