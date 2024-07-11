Guía de:

# Instalación De Apache  y PHP.

## ACERCA DE:

Versión: 2.0.0

Nivel: Medio - Avanzado

Área: CPD

Elaborado por: Edmundo Céspedes Ayllón

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

------

## En CentOS 8

Instalamos y configuramos el servidor conforme a la [Guía de Instalación de CentOS ](https://github.com/GorillaTi/Guias/blob/main/01_Instalar_Servicios/Instalar-CentOS-AlmaLinux.md#instalaci%C3%B3n-de-centos---alma-linux)

### Instalamos Apache2

Actualizamos

```bash
sudo dnf upgrade -y
```

Instalamos `httpd`

```bash
sudo dnf install -y httpd
```

### Configuración  de Firewall

Habilitamos el  los puertos `http` y `https` en el firewall

- Verificamos el estado del firewall

```bash
sudo systemctl status firewalld
```

- Verificamos los servicios habilitados

```bash
sudo firewall-cmd --list-services
```

```bash
sudo firewall-cmd --list-all
```

- Adicionamos el servicio de forma permanente

```bash
firewall-cmd --add-service=http --permanent
firewall-cmd --add-service=https --permanent
```

- Reiniciamos el servicio del firewall   

```bash
firewall-cmd --reload
```

- Verificamos los servicios habilitados

```bash
sudo firewall-cmd --list-services
```

### Instalación de PHP

Revisamos la versión de PHP en los repositorios

```bash
sudo dnf module list php
```

Si la versiones disponibles cubren nuestras necesidades, la instalamos

Caso contrario adicionamos el repositorio para versiones mas actuales en la pagina 

https://rpms.remirepo.net/wizard/

Instalando PHP

```bash
sudo dnf install -y php
```

instalando los módulos de PHP

```bash
sudo dnf install -y php{opcache,curl,common,mysqlnd,gd}
```

habilitamos los servicios de PHP

```bash
sudo systemctl enable --now php-fpm.service
```

revisamos el estado del servicio

```bash
sudo systemctl status php-fpm.service
```

recargamos la configuración del servidor apache2

```bash
sudo systemctl reload httpd
```

## En Debian 10

Instalamos y configuramos el servidor conforme a la [Guía de Instalación de Debian](https://github.com/GorillaTi/Guias/blob/main/01_Instalar_Servicios/Instalar-Debian.md#instalaci%C3%B3n-de-debian)

### Instalación de Apache2

 Actualizamos e instalamos actualizaciones

```bash
sudo apt update && sudo apt dist-upgrade -y
```

Instalamos apache2

```bash
sudo apt install apache2 apache2-doc
```

Configuramos el auto inicio y iniciamos el servicio

```bash
sudo systemctl enable --now apache2.service
sudo systemctl start apache2.service
```

Revisamos el estado del servicio.

```bash
sudo sytemctl status apache2.service
```

Revisamos los puertos

```bash
sudo ss -tpan
```

### Configuración de Firewall

- Comprobamos el estado de la iptables

```bash
sudo iptables -L
```

- Habilitamos los puertos

```bash
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw allow mysql
```

- Para rangos de puertos

```bash
sudo ufw allow in 1000:2000/udp
```

- Habilitamos el firewall

```bash
sudo ufw enable
```

### Instalamos PHP 7.x, 8.x mediante PPA Sury

- Instalar los requisitos mínimos

```bash
sudo apt -y install lsb-release apt-transport-https ca-certificates wget
```

- Descargamos la llave GPG para PPA Sury para PHP 7.x, 8.x usando `wget`

```bash
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
```

- Agregando la PPA Sury a la lista de repositorios.

```bash
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee     /etc/apt/sources.list.d/php.list
```

- Actualizamos la lista de repositorios

```bash
sudo apt update
```

- Instalamos PHP
  
  PHP7.x

```bash
sudo apt install -y php7.4
```

        PHP8.x

```bash
sudo apt install -y php8.1
```

- Verificamos la versión instalada

```bash
php -v
```

### Instalar modulos de PHP

```bash
sudo apt install php8.1-{common,mysql,xml,xmlrpc,curl,gd,imagick,cli,dev,imap,mbstring,opcache,soap,zip,intl,bcmath} -y 
```

## Hardening de Apache2

Ubicarse en la carpeta de configuración

```bash
cd /etc/apache2/conf-available/
```

Respaldo de seguridad de los archivos `charset.conf`   y `security.con`

```bash
sudo cp -rpfv charset.conf charset.conf.orig
sudo cp -rpfv security.conf security.conf.orig
```

### Charset

- Modificamos el archivo `charset.conf`

```bash
sudo vim charset.conf
```

- des cometamos la línea

```output
AddDefaultCharset UTF-8
```

### Security

- Modificamos el archivo `security.conf`

```bash
sudo vim security.conf
```

- Des comentamos la línea y colocamos en `off`

```shell-session
ServerSignature Off
```

- De comentamos la linea y colocamos en `Prod`

```shell-session
ServerTokens Prod
```

### Ports

Ubicamos en el directorio `apache2`

```bash
cd /etc/apache2/
```

Respaldo de seguridad de  `ports.conf`

```bash
sudo cp -rpfv ports.conf ports.conf.orig 
```

Editamos el archivo `ports.conf`

```bash
sudo vim ports.conf
```

Editamos la linea

```output
Listen 192.168.0.95:80
```

Verificamos la configuraciones realizadas

```bash
sudo apache2ctl -t
```

### .git

Editar el archivo de configuración

- Debian

```bash
sudo vim /etc/apache2/apache2.conf
```

- CentOS

```bash
sudo vim /etc/httpd/httpd.conf
```

Insertamos el código para la restricción

- Denegando el acceso al directorio

Opción 1

```shell-session
<Directory ~ “\.git”>
    Order allow,deny
    Deny from all
</Directory>
```

Opción 2

```shell-session
<DirectoryMatch "^/.*/\.git/">
  Deny from all
</Directorymatch>
```

- Denegar el acceso por medios de código 404

```shell-session
RedirectMatch 404 /\.git
```

> **Nota.-** esto evita dar mayor información al atacante de la existencia del directorio de configuración .git 

### Reinicio del Servicio

Reiniciamos el servicio de Apache2

```bash
sudo systemctl restart apache2.service
```

o

```bash
sudo apache2ctl restart
```

### Revisión del estado del Servicio

Revisamos los puertos

```bash
sudo ss -tpan | grep apache
```

```sh-session
sysadmin@app01:/etc/apache2$ ss -tpan
State       Recv-Q      Send-Q           Local Address:Port              Peer Address:Port       
LISTEN      0           128              192.168.0.95:80                     0.0.0.0:*          
LISTEN      0           128                    0.0.0.0:22                     0.0.0.0:*          
ESTAB       0           0                192.168.10.95:22              192.168.14.254:49748      
LISTEN      0           128                       [::]:22                        [::]:* 
```

o

```bash
sudo netstat -tlpn| grep apache
```

```shell-session
sysadmin@app02:~$ sudo netstat -tlpn | grep apache
tcp6       0      0 :::80                   :::*                    LISTEN      41521/apache2
tcp6       0      0 :::8081                 :::*                    LISTEN      41521/apache2
```

## Revisando versión de PHP

revisamos la versión de PHP

```bash
php -v
```

## Revisando versiones de PHP instaladas

```bash
sudo update-alternatives --config php
```



## Prueba de Funcionamiento de la instalación de php

* Para probar que todo esta funcionando nos creamos  carpeta `test` y archivo de prueba `index.php`
  
  ```bash
  sudo mkdir -p /var/www/html/test
  sudo nano /var/www/html/test/index.php
  ```

* Ingresamos el siguiente código
  
  ```php
  <?php
  phpinfo();
  ?>
  ```

* Revisamos  el resultado en la ruta del navegador ya se por IP o por URL
  
  * http://10.10.0.1/test
  * http://mi.dominio/test

## Configuración php.ini

Editar el archivo de configuración

```bash
sudo nano /etc/php/7.4/fpm/php.ini
```

Parámetros básicos de configuración

```shell-session
upload_max_filesize = 32M 
post_max_size = 48M 
memory_limit = 256M 
max_execution_time = 600 
max_input_vars = 3000 
max_input_time = 1000
```

Ocultar versión de PHP

```shell-session
expose_php = Off
```

## Configuración para enlaces simbólicos de `/home` a` /var/www/html`

* Editar el archivo `apache.conf` o `httpd.conf`
  
  Debian / Ubuntu
  
  ```bash
  sudo vim /etc/apache2/apache2.conf
  ```
  
  CentOS / Alma Linux / Rocky Linux
  
  ```bash
  sudo nano /etc/httpd/conf/httpd.conf 
  ```

* Insertamos el siguiente código
  
  ```http
  <Directory /var/www/html/ >
      Options Indexes FollowSymLinks MultiViews
      AllowOverride All
      Order allow,deny
      allow from all
  </Directory>
  ```

* Verificamos la configuraciones realizadas
  
  ```bash
  sudo apache2ctl -t
  ```

* Recargamos la Configuración de Apache.
  
  Debian
  
  ```bash
  sudo systemctl reload apache2.service 
  ```
  
  CentOS / Alma Linux / Rocky Linux
  
  ```bash
  sudo nano /etc/httpd/conf/httpd.conf 
  ```

## Prueba de funcionamiento de enlace simbólico

* Movemos el directorio `/test` 
  
  ```bash
  sudo mv -fv /var/www/html/test/ /home/[usuario]/
  ```

* Cambiamos el propietario de la carpeta
  
  ```bash
  sudo chown -R [usuario]:[grupo] test/
  ```

* Creamos el enlace simbólico
  
  ```bash
  sudo ln -s /home/[usuario]/test/ /var/www/html/test
  ```

* Revisamos en el navegador
  
  * http://10.10.0.1/test
  * http://mi.dominio/test

## Configurando VirtualHost  Manual

### Apache

000-default.conf

```shell-session
<VirtualHost *:80>
        #ServerName www.example.com
        #ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html

        <FilesMatch \.php$>
             SetHandler "proxy:unix:/var/run/php/php7.4-fpm.sock|fcgi://localhost"
        </FilesMatch>

        ErrorLog /error.log
        CustomLog /access.log combined
        RewriteEngine on
        RewriteCond %{SERVER_NAME} =[tudominio.com] [OR]
        RewriteCond %{SERVER_NAME} =www.[tudominio.com]
        RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]
</VirtualHost>
```

 000-default-le-ssl.conf

```shell-session
<IfModule mod_ssl.c>
<VirtualHost *:443>
        ServerAdmin [tucorreo]@[tudominio.com]
        DocumentRoot /var/www/html
        ServerName [tudominio.com]
        Include /etc/letsencrypt/options-ssl-apache.conf
        ServerAlias www.[tudominio.com]
        SSLCertificateFile /etc/letsencrypt/live/[tudominio.com]/fullchain.pem
        SSLCertificateKeyFile /etc/letsencrypt/live/[tudominio.com]/privkey.pem

        <FilesMatch \.php$>
             SetHandler "proxy:unix:/var/run/php/php7.4-fpm.sock|fcgi://localhost"
        </FilesMatch>

        ErrorLog /error.log
        CustomLog /access.log combined
</VirtualHost>
</IfModule>
```

### Nginx

```shell-session
server {
        listen 80 default_server;
        return 301 https://$host$request_uri;
        }

server {
        listen 443 ssl;

        ssl_certificate     /etc/letsencrypt/live/[tudominio.com]/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/[tudominio.com]/privkey.pem;
        ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
        ssl_ciphers         HIGH:!aNULL:!MD5;

        root /var/www/html;

        index index.html index.htm index.nginx-debian.html;

        location / {
                try_files $uri $uri/ =404;
                }
        }
```

Verificamos el estado del VHost

```bash
sudo apachectl -S
```

```shell-session
VirtualHost configuration:
*:443                  [tudominio.com] (/etc/apache2/sites-enabled/000-default-le-ssl.conf:2)
*:80                   [tudominio.com] (/etc/apache2/sites-enabled/000-default.conf:1)
ServerRoot: "/etc/apache2"
Main DocumentRoot: "/var/www/html"
Main ErrorLog: "/var/log/apache2/error.log"
Mutex watchdog-callback: using_defaults
Mutex rewrite-map: using_defaults
Mutex ssl-stapling-refresh: using_defaults
Mutex ssl-stapling: using_defaults
Mutex proxy: using_defaults
Mutex ssl-cache: using_defaults
Mutex default: dir="/var/run/apache2/" mechanism=default
PidFile: "/var/run/apache2/apache2.pid"
Define: DUMP_VHOSTS
Define: DUMP_RUN_CFG
User: name="www-data" id=33
Group: name="www-data" id=33
```
