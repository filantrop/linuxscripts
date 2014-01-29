#!/bin/bash
while true; do
 ps -C php-cgi -o pid=,%mem=,vsz= >> mem-trunk.log
sleep 1
done
