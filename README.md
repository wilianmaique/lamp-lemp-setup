# PHP Server Setup Script

Este script automatiza a instalação e configuração de um servidor PHP com as opções de servidor web (Apache ou Nginx), banco de dados (MySQL ou MariaDB) Redis, Supervisor, NodeJS, Composer, etc, facilitando o processo de setup de um ambiente de desenvolvimento ou produção.

- O processo é indicado para um sistema recem instalado.
- O script deve ser executado em um sistema baseado em Ubuntu/Debian (ou similar).


## Como usar
- Faça o processo com usuario ```root```
- Tenha ```curl``` instalado
- Execute: ```curl -sSL "https://raw.githubusercontent.com/wilianmaique/lamp-lemp-setup/refs/heads/main/installer.sh" | bash -s 8.4 nginx mariadb```
- Param: **php_version** = ```8.4``` **server_type** = ```apache | nginx``` **db_type** = ```mysql | mariadb```
- Depois de instalar, você ainda precisa configurar o banco de dados, para isso execute: ```sudo mysql_secure_installation```