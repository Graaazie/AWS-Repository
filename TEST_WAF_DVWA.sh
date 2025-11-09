#!/bin/bash

# MySQL 변수 정의
DB_NAME="dvwa"
DB_USER="dvwa"
USER_PWD="p@ssw0rd"

# SQL 명령어 정의
SQL_COMMANDS=$(cat <<EOF
CREATE DATABASE ${DB_NAME} CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${USER_PWD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';
FLUSH PRIVILEGES;
EOF
)

# MySQL 접속 및 실행
mysql -uroot -e "${SQL_COMMANDS}"
