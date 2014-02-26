#! /bin/bash

# Declare array with rsyncpaths
#------------------------------------
#['user ip source']="ssh-port destination"

declare -A C
C['root 1.2.3.4 /sourcedirectory']="22 /NOT.IN.USE"
#C['o1 192.168.1.30 /data/disk/o1']="22 /home/o1"
#C['o1 192.168.1.30 /data/disk/o1']="22 /home/o1"

#-----------------------------------

REALPATH=$(which realpath)
#PWD=$(pwd)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RSYNC_COMMAND="$DIR/rsync_backup.sh"
MYSQL_COMMAND="$DIR/mysql_backup.sh"
BACKUP_DIR=$($REALPATH $DIR/../backups)
NOW=$(date +"%Y-%m-%d_%H%M")

echo $BACKUP_DIR
echo $REALPATH
echo $DIR
echo $RSYNC_COMMAND



#declare -A C

#C['o1 192.168.1.30 /data/disk/o1']="22 /home/o1"

for key in "${!C[@]}"
do
	KEY_ARR=($key)
	VALUE=(${C[$key]})
	
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
	$RSYNC_COMMAND $PORT $COMBINED_SOURCE $BACKUP_PATH

done

# Run mysql backups
$MYSQL_COMMAND 22 '/home/o1/backups/192.168.1.30/sql' root 192.168.1.30

