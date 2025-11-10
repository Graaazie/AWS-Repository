#!/bin/bash

DB_NAME="mytestdb"
DB_USER="user1"
USER_PWD="p@ssw0rd"
DB_Admin="admin"
Admin_PWD="password"
DB_HOST="waf-db.cp8was4ksowb.ap-northeast-2.rds.amazonaws.com"

SQL_COMMANDS=$(cat <<EOF
CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${USER_PWD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF
)

sed -i ": '127.0.0.1'/: '${DB_HOST}'/g" /var/www/html/config/config.inc.php
sed -i ": 'dvwa'/: '${DB_NAME}'/g" /var/www/html/config/config.inc.php
sed -i ": 'dvwa'/: '${DB_USER}'/g" /var/www/html/config/config.inc.php
sed -i ": 'p@ssw0rd'/: '${USER_PWD}'/g" /var/www/html/config/config.inc.php

mysql -h ${DB_HOST} -u ${DB_Admin} -p${Admin_PWD} ${DB_NAME} -e "${SQL_COMMANDS}"
