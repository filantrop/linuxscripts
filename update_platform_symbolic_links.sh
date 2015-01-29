#! /bin/bash
PLATFORMPATH=$1
DRUPAL_CORE_PATH=$2

# Check if paths exist
if [ ! -d "$PLATFORMPATH" ];then echo "You must give a valid platformpath.";exit 0;fi
if [ ! -d "$DRUPAL_CORE_PATH" ];then echo "You must give a valid drupalcorepath.";exit 0;fi

# Declare drupalfiles and directories
declare -a DRUPAL_FILES=(
'authorize.php'
'cron.php'
'crossdomain.xml'
'index.php'
'install.php'
'js.php'
'update.php'
'web.config'
'xmlrpc.php'
);

declare -a DRUPAL_DIRECTORIES=(
'includes'
'misc'
'modules'
'themes'
);

# First Remove all txt and unnessaccary files 
rm $PLATFORMPATH/*.txt
rm $PLATFORMPATH/*.ini

# Remove files and add them as new symbolic links
for DF in "${DRUPAL_FILES[@]}"
do
    if [ -f "$PLATFORMPATH/$DF" ];
    then
        rm $PLATFORMPATH/$DF
        ln -s $DRUPAL_CORE_PATH/$DF $PLATFORMPATH/$DF
    fi
done

for DD in "${DRUPAL_DIRECTORIES[@]}"
do
    if [ -d "$PLATFORMPATH/$DD" ];
    then
        rm -r $PLATFORMPATH/$DD
        ln -s $DRUPAL_CORE_PATH/$DD $PLATFORMPATH/$DD
    fi
done

