#!/bin/bash
#PT-BR: Instalação de pacotes dependentes
#EN: Installing dependent packages

sudo yum update -y
sudo yum install epel-release -y
sudo dnf -y install java-11-openjdk java-11-openjdk-devel
sudo dnf install git maven wget -y
cd /tmp/

#PT-BR: Baixando o pacote Tomcat  
#EN: Downloading the Tomcat package

sudo wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.75/bin/apache-tomcat-9.0.75.tar.gz
sudo tar xzvf apache-tomcat-9.0.75.tar.gz

#PT-BR: Adicionando o usuário tomcat
#EN: Adding tomcat user

sudo useradd --home-dir /usr/local/tomcat --shell /sbin/nologin tomcat
sudo cp -r /tmp/apache-tomcat-9.0.75/* /usr/local/tomcat/
sudo chown -R tomcat.tomcat /usr/local/tomcat

#PT-BR: Configurando o comando systemctl para o Tomcat
#EN: Setup systemctl command fot tomcat

sudo touch /etc/systemd/system/tomcat.service
echo -e "[Unit]\nDescription=Tomcat\nAfter=network.target\n[Service]\nUser=tomcat\nWorkingDirectory=/usr/local/tomcat\nEnvironment=JRE_HOME=/usr/lib/jvm/jre\nEnvironment=JAVA_HOME=/usr/lib/jvm/jre\nEnvironment=CATALINA_HOME=/usr/local/tomcat\nEnvironment=CATALINE_BASE=/usr/local/tomcat\nExecStart=/usr/local/tomcat/bin/catalina.sh run\nExecStop=/usr/local/tomcat/bin/shutdown.sh\nSyslogIdentifier=tomcat-%i\n[Install]\nWantedBy=multi-user.target\n" | sudo tee /etc/systemd/system/tomcat.service
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat

#PT-BR: Iniciando o firewall e habilitando a porta 8080 para para o Tomcat
#EN: Enabling the firewall and allowing port 8080 to access the tomcat

sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --get-active-zones
sudo firewall-cmd --zone=public --add-port=8080/tcp --permanent
sudo firewall-cmd --reload
