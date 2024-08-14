# vprofile-project-automated
###### **EN: **
- This repository aims to automate the process of creating a service stack to deploy an application.
- The application will be a web application written in Java and initially user access will be controlled by Nginx. Nginx currently also works as a reverse proxy and email proxy for the IMAP, POP3, and SMTP protocols. However, in this case, its usefulness for our project will be as an HTTP load balancer.
- Although NGINX is a very good web server for load balancing, since our application is in Java, Apache Tomcat will be used to run the server, as it is specifically designed to run Java web applications.
- Next, Apache will send this request to RabbitMQ. In practice, it will not be useful for our project, as it acts as a messaging service. Next, our request will go to the MySQL server, but first it will pass through the Memcached service. Basically, it will manage the cache, so that the next time the user makes a request to MySQL, there will be a certain amount of cached data to make the experience faster.

###### **PT-BR: **
- Esse repositório tem como objetivo automatizar o processo de criação de uma pilha de serviços para o deploy de uma aplicação.
- A aplicação web é programada em Java, e inicialmente será controlada o acesso de usuários pelo Nginx. O Nginx hoje, também funciona como proxy reverso, proxy de email para os protocolos IMAP, POP3, e SMTP. Mas nesse caso, sua utilidade para o nosso projeto será como balanceador de carga HTTP.
- O NGINX apesar de ser um servidor web muito bom para balanceamento de carga, pelo fato da nossa aplicação ser em java, será usado o Apache Tomcat para rodar o servidor, pois ele é feito especificamente para rodar aplicações web em java.
- Em seguida, o Apache irá enviar essa requisição para o RabbitMQ. Na prática, ele não será útil para o nosso projeto, pois ele atua como um serviço de mensageria. Em seguida, nossa solicitação irá para o servidor MySQL, porém, antes ele ira passar pelo serviço do Memcached onde ele irá fazer gerenciamento de cache, para que a próxima vez que o usuário faça uma requisição ao MySQL, exista uma quantidade de dados em cache para tornar a experiência mais rápida.

![](https://i.ibb.co/nkG6FWt/Screenshot-2024-08-14-004253.png)


#### Dependences
- Oracle VM Virtualbox
- Vagrant
- Git bash or equivalent editor
- Vagrant plugins
#### Execute below command in your computer to install hostmanager plugin
`$ vagrant plugin install vagrant-hostmanager`

