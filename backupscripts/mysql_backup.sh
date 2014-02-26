#! /bin/bash

#Arguments 
SOURCE_PORT=$1
#SOURCE=$2
DESTINATION=$2
USER=$3
HOST=$4

# Check if all arguments is present
if [ "$#" -ne 4 ]; then
    echo "Illegal number of paramaters in mysql_backup.sh"
    exit 1
fi

# Create date and paths
date=`date "+%Y-%m-%dT%H:%M:%S"`
NOW=$(date +"%Y-%m-%d_%H%M")
LOGFILE=$DESTINATION/${NOW}.log
DESTINATION_BACKUP_PATH=$DESTINATION/b-$date
LINK_DESTINATION=$DESTINATION/current
MKDIR=$(which mkdir)
# Create linkpath if it does not exist
#if [ ! -d $LINK_DESTINATION ]; then
#   DUMMY_LINK_DESTINATION=$DESTINATION/date-dummy
#   mkdir -p $DUMMY_LINK_DESTINATION
#   ln -s $DUMMY_LINK_DESTINATION $LINK_DESTINATION
#fi

# Setup rsync command
#BR="/usr/bin/ssh -p $SOURCE_PORT -C ${USERNAME}@${HOSTNAME} mysqldump -u mysqldump_user --lock-tables=false ${DB_NAME}|gzip>$DB_DST/backup.0/db.sql.gz"
BR=$(/usr/bin/ssh ${USER}@${HOST} -p $SOURCE_PORT 'mysql -e "show databases"')


DATABASES=$BR
 

#DATABASES=eval $BR

i=0
while read -r DB_NAME
do
   if [ $i != 0 ]; then
     echo $DB_NAME

     $MKDIR -p $DESTINATION_BACKUP_PATH
     #MYSQL_RUN="/usr/bin/ssh $USER@$HOST -p $SOURCE_PORT mysqldump -u root --lock-tables=false ${DB_NAME}|gzip>$DESTINATION_BACKUP_PATH/$DB_NAME.sql.gz"
     MYSQL_RUN="/usr/bin/ssh $USER@$HOST -p $SOURCE_PORT mysqldump -u root --lock-tables=false ${DB_NAME}>$DESTINATION_BACKUP_PATH/$DB_NAME.sql &"
     echo $MYSQL_RUN
     eval $MYSQL_RUN
     #echo "pid: $PID";
   fi
   i=$i+1

done<<<"$DATABASES"

#echo "">$LOGFILE
#eval $BR 2>> $LOGFILE

#irm -f $LINK_DESTINATION
#ln -s $DESTINATION_BACKUP_PATH $LINK_DESTINATION


