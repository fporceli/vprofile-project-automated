Vagrant.configure("2") do |config|
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true

# VM Banco de dados
    config.vm.define "db01" do |db01|
        db01.vm.box = "eurolinux/centos-stream-9"
        db01.vm.box_version = "9.0.43"
        db01.vm.network "private_network", ip: "192.168.56.15"
        db01.vm.hostname = "db01"
        #Rodar o provisionamento do mysql.sh
        db01.vm.provision "shell", path: "mysql.sh"
        db01.vm.provider "virtualbox" do |vb|
            vb.memory = "600"
        end
# VM memcached
  config.vm.define "mc01" do |mc01|
    mc01.vm.box = "eurolinux-vagrant/centos-stream-9"
    mc01.vm.box_version = "9.0.43"
    mc01.vm.network "private_network", ip: "192.168.56.14"
    mc01.vm.hostname = "mc01"
    #Rodar o provisionamento do memcached.sh
    mc01.vm.provision "shell", path: "memcached.sh"
    mc01.vm.provider "virtualbox" do |vb|
     vb.memory = "600"
   end
  end
  
# VM RabbitMQ
  config.vm.define "rmq01" do |rmq01|
    rmq01.vm.box = "eurolinux-vagrant/centos-stream-9"
    rmq01.vm.box_version = "9.0.43"
    rmq01.vm.network "private_network", ip: "192.168.56.13"
    rmq01.vm.hostname = "rmq01"
    #Rodar o provisionamento do rabbitmq.sh
    rmq01.vm.provision "shell", path: "rabbitmq.sh"
    rmq01.vm.provider "virtualbox" do |vb|
     vb.memory = "600"
   end
  end
  
# VM Tomcat
   config.vm.define "app01" do |app01|
    app01.vm.box = "eurolinux-vagrant/centos-stream-9"
    app01.vm.box_version = "9.0.43"
    app01.vm.network "private_network", ip: "192.168.56.12"
    app01.vm.hostname = "app01"
    #Rodar o provisionamento do tomcat.sh
    app01.vm.provision "shell", path: "tomcat.sh"
    app01.vm.provider "virtualbox" do |vb|
     vb.memory = "800"
   end
   end
   
  
# VM Nginx
  config.vm.define "web01" do |web01|
    web01.vm.box = "ubuntu/jammy64"
    web01.vm.hostname = "web01"
  web01.vm.network "private_network", ip: "192.168.56.11"
  web01.vm.provider "virtualbox" do |vb|
     vb.gui = true
     vb.memory = "800"
   end
end
  
end
