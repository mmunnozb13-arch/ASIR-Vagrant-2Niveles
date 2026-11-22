#!/bin/bash
# Variables de la base de datos
DB_NAME="lamp_db"
DB_USER="lamp_user"
DB_PASS="Lamp_2026_Marcos"
APACHE_IP="192.168.56.10"
MYSQL_IP="192.168.56.11"

export DEBIAN_FRONTEND=noninteractive

# Actualiza la lista de paquetes e instala MariaDB (el equivalente a MySQL en Debian 12)
apt-get update
apt-get install -y mariadb-server

# Hace que MariaDB escuche en la IP de la red interna en vez de solo en localhost
sed -i "s/^bind-address.*/bind-address = ${MYSQL_IP}/" /etc/mysql/mariadb.conf.d/50-server.cnf
systemctl restart mariadb

# Crea la base de datos, el usuario (solo accesible desde Apache) y la tabla de la aplicación
mysql <<SQL
CREATE DATABASE IF NOT EXISTS ${DB_NAME} CHARACTER SET utf8mb4;
CREATE USER IF NOT EXISTS '${DB_USER}'@'${APACHE_IP}' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'${APACHE_IP}';
FLUSH PRIVILEGES;
USE ${DB_NAME};
CREATE TABLE IF NOT EXISTS users (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  age INT UNSIGNED NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SQL
