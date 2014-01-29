#!/bin/bash
STRING=$1

while true; do
if [ -z "$STRING" ]; then
echo "Usage:calc_memory <string to identify process>"
exit 0
else

USAGE_PRCNT=`ps aux | grep ${STRING} | grep -v grep | awk '{print $4}' | awk '{total = total +$1}END{print total}'`
NO_THRDS=`ps aux | grep ${STRING} | grep -v grep | wc -l`
SYS_MEM=`cat /proc/meminfo | grep MemTotal | awk '{print $2}'`
USG=`echo "$SYS_MEM*$USAGE_PRCNT/102400" |bc`;
echo Total Usage  ${STRING}:${USG}MB   ${NO_THRDS}
#echo Total Number of Threads:${NO_THRDS}
fi
sleep 1
done
