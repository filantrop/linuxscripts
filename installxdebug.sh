#!/bin/bash
cd /var/opt
wget -U iCab http://xdebug.org/files/xdebug-2.2.5.tgz &> /dev/null
tar -xzf xdebug-2.2.5.tgz
cd /var/opt/xdebug-2.2.5
/opt/php53/bin/phpize
sh ./configure --with-php-config=/opt/php53/bin/php-config
make
make install
