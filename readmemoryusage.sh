#!/bin/bash

# if yuo use php-cgi replace php-fpm
while true; do
 ps -C php-fpm -o pid=,%mem=,vsz= >> mem-trunk.log
sleep 1
done
