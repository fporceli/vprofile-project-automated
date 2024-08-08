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
sudo mysql -e "FLUSH PRIVILEGES;"

#PT-BR: Remover usuários anônimos
#EN: Remove anonymous users

sudo mysql -e "DELETE FROM mysql.user WHERE User='';"

#PT-BR: Remover acesso remoto para o usuário root
#EN: Remove remote access to root user

sudo mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host!='localhost';"

#PT-BR: Remover o banco de dados de teste
#EN: Remove the test database

sudo mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host!='localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"
sudo systemctl restart mysql
sudo mysql -u root -p$password_db

#PT-BR: Definir usuários e base de dados
#EN: Set users and database

sudo mysql -e "CREATE DATABASE accounts;"
sudo mysql -e "GRANT ALL PRIVILEGES ON accounts.* TO 'admin'@'%' IDENTIFIED BY '${$password_db}';"
sudo mysql -e "FLUSH PRIVILEGES";
exit

#PT-BR: Baixar código fonte e iniciar base de dados
#EN: Download source code and initialize database

sudo git clone -b main https://github.com/hkhcoder/vprofile-project.git
cd vprofile-project
sudo mysql -u root -p$password_db accounts < src/main/resources/db_backup.sql
sudo systemctl restart mariadb




