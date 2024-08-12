#!/bin/bash
#PT-BR: Instalação de pacotes dependentes
#EN: Installing dependent packages

sudo yum update -y
sudo yum install epel-release -y
sudo yum install wget -y
cd /tmp/
sudo dnf -y install centos-release-rabbitmq-38
sudo dnf --enablerepo=centos-rabbitmq-38 -y install rabbitmq-server
sudo systemctl enable --now rabbitmq-server

#PT-BR: Configurar acesso ao teste do usuário e torná-lo administrador
#EN: Setup access to user test and make it admin

sudo sh -c 'echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config'
sudo rabbitmqctl add_user test test
sudo rabbitmqctl set_user_tags test administrator
sudo systemctl restart rabbitmq-server

#PT-BR: Iniciando o firewall e habilitando a porta 5672 para o RabbitMQ
#EN: Starting the firewall and allowing the port 5672 to access rabbitmq

sudo firewall-cmd --add-port=5672/tcp
sudo firewall-cmd --runtime-to-permanent
sudo systemctl start rabbitmq-server
sudo systemctl enable rabbitmq-server
sudo systemctl status rabbitmq-server
