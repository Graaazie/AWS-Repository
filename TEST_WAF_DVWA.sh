#!/bin/bash

DB_NAME="mytestdb"
DB_USER="dvwa"
USER_PWD="p@ssw0rd"
DB_Admin="admin"
Admin_PWD="password"
DB_HOST="waf-db.cp8was4ksowb.ap-northeast-2.rds.amazonaws.com"

SQL_COMMANDS=$(cat <<EOF
DROP USER IF EXISTS '${DB_USER}'@'%';
CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${USER_PWD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF
)

sed -i "s|getenv('DB_SERVER') ?: '127.0.0.1';|getenv('DB_SERVER') ?: '${DB_HOST}';|g" /var/www/html/config/config.inc.php
sed -i "s|getenv('DB_DATABASE') ?: 'dvwa';|getenv('DB_DATABASE') ?: '${DB_NAME}';|g" /var/www/html/config/config.inc.php
sed -i "s|getenv('DB_USER') ?: 'dvwa';|getenv('DB_USER') ?: '${DB_USER}';|g" /var/www/html/config/config.inc.php
sed -i "s|getenv('DB_PASSWORD') ?: 'p@ssw0rd';|getenv('DB_PASSWORD') ?: '${USER_PWD}';|g" /var/www/html/config/config.inc.php

mysql -h ${DB_HOST} -u ${DB_Admin} -p${Admin_PWD} ${DB_NAME} -e "${SQL_COMMANDS}"
