#!/bin/bash
#PT-BR: Instalação de pacotes dependentes
#EN: Installing dependent packages
sudo apt update
sudo apt install nginx -y
cat <<EOT > vproapp
upstream vproapp {

 server app01:8080;

}

server {

  listen 80;

location / {

  proxy_pass http://vproapp;

}

}

EOT

mv vproapp /etc/nginx/sites-available/vproapp
rm -rf /etc/nginx/sites-enabled/default
ln -s /etc/nginx/sites-available/vproapp /etc/nginx/sites-enabled/vproapp

#PT-BR: Inicializando o serviço do nginx e firewall
#EN: Starting nginx service and firewall
systemctl start nginx
systemctl enable nginx
systemctl restart nginx