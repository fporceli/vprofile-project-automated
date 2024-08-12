#!/bin/bash
#PT-BR: Instalação de pacotes dependentes
#EN: Installing dependent packages
sudo yum update -y
sudo dnf install epel-release -y
sudo dnf install memcached -y

#PT-BR: Instalação, inicialização e habilitando o memcached na porta 11211
#EN: Install, start & enable memcache on port 11211

sudo systemctl start memcached
sudo systemctl enable memcached
sudo systemctl status memcached
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/sysconfig/memcached
sudo systemctl restart memcached

#PT-BR: Inicializando o firewall e habilitando a porta 11211 acessar o memcached
#EN: Starting the firewall and allowing the port 11211 to access memcache

sudo firewall-cmd --add-port=11211/tcp
sudo firewall-cmd --runtime-to-permanent
