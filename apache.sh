#!/bin/bash
# Datos de conexión (deben coincidir con los de mysql.sh)
DB_NAME="lamp_db"
DB_USER="lamp_user"
DB_PASS="Lamp_2026_Marcos"
MYSQL_IP="192.168.56.11"

export DEBIAN_FRONTEND=noninteractive

# Instala Apache, PHP con el módulo para MySQL, Git y el cliente de MariaDB
apt-get update
apt-get install -y apache2 php libapache2-mod-php php-mysql git mariadb-client

# Descarga la aplicación desde GitHub
rm -rf /tmp/app
git clone https://github.com/josejuansanchez/iaw-practica-lamp.git /tmp/app

# Copia el código de la aplicación al directorio web
rm -f /var/www/html/index.html
cp -r /tmp/app/src/* /var/www/html/

# Ajusta config.php para que use la base de datos de la otra máquina
sed -i "s/define('DB_HOST', 'localhost');/define('DB_HOST', '${MYSQL_IP}');/" /var/www/html/config.php
sed -i "s/database_name_here/${DB_NAME}/" /var/www/html/config.php
sed -i "s/username_here/${DB_USER}/" /var/www/html/config.php
sed -i "s/password_here/${DB_PASS}/" /var/www/html/config.php

# Permisos y reinicio del servidor web
chown -R www-data:www-data /var/www/html
systemctl restart apache2
