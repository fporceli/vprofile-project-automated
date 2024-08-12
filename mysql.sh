#!/bin/bash
#PT-BR: Instalação de pacotes dependentes
#EN: Installing dependent packages

password_db='admin123'
sudo yum update -y
sudo yum install epel-release -y
sudo yum install git mariadb-server -y
sudo systemctl enable mariadb
sudo systemctl start mariadb 

#PT-BR: Configurando manualmente o script "mysql_secure_installation"
#EN: Configuring manually the "mysql_secure_installation" script

#PT-BR: Configurar senha do root
#EN: Configure root password
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${password_db}';"
sudo mysql -e "FLUSH PRIVILEGES;" -p$password_db

#PT-BR: Remover usuários anônimos
#EN: Remove anonymous users

sudo mysql -e "DELETE FROM mysql.user WHERE User='';" -p$password_db

#PT-BR: Remover acesso remoto para o usuário root
#EN: Remove remote access to root user

sudo mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host!='localhost';" -p$password_db

#PT-BR: Remover o banco de dados de teste
#EN: Remove the test database

sudo mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host!='localhost';" -p$password_db
sudo mysql -e "FLUSH PRIVILEGES;" -p$password_db
sudo systemctl restart mysql 

#PT-BR: Definir usuários e base de dados
#EN: Set users and database

sudo mysql -e "CREATE DATABASE accounts;" -p$password_db
sudo mysql -e "GRANT ALL PRIVILEGES ON accounts.* TO 'admin'@'%' IDENTIFIED BY '$password_db';" -p$password_db
sudo mysql -e "FLUSH PRIVILEGES;" -p$password_db
exit

#PT-BR: Baixar código fonte e iniciar base de dados
#EN: Download source code and initialize database

sudo git clone -b main https://github.com/hkhcoder/vprofile-project.git
cd vprofile-project
sudo mysql -u root -p$password_db accounts < src/main/resources/db_backup.sql
sudo systemctl restart mariadb

#PT-BR: Inicializando o firewall e habilitando mariadb acessar a porta 3306
#EN: Starting the firewall and allowing the mariadb to access from port no. 3306

sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --get-active-zones
sudo firewall-cmd --zone=public --add-port=3306/tcp --permanent
sudo firewall-cmd --reload
sudo systemctl restart mariadb
