Guía de:

# Instalación De Apache  y PHP.

## ACERCA DE:

Versión: 1.1.0

Nivel: Todos

Área: CPD

Elaborado por: Edmundo Céspedes Ayllón

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

------

## En CentOS 8

1. Instalamos y configuramos el servidor conforme a la Guía de Instalación de CentOS 8.

### Instalamos Apache2

2. Actualizamos
   
   ```bash
   sudo dnf upgrade
   ```

3. Instalamos http
   
   ```bash
   sudo dnf install -y httpd
   ```

### Configuración  de Firewall

4. Habilitamos el  los puertos http y https en el firewall
   
   - Verificamos el estado del firewall
   
   ```bash
   systemctl status firewalld
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

5. Revisamos la versión de PHP en los repositorios
   
   ```bash
   sudo dnf module list php
   ```
   
   Si la versiones disponibles cubren nuestras necesidades, la instalamos
   
   Caso contrario adicionamos el repositorio para versiones mas actuales en la pagina 
   
   https://rpms.remirepo.net/wizard/

6. instalamos los módulos de php
   
   ```bash
   sudo dnf install -y php php-opcache php-curl php-common php-mysqlnd php-gd
   ```

7. habilitamos los servicios de php
   
   ```bash
   sudo systemctl enable --now php-fpm.service
   ```
   
   revisamos el estado del servicio
   
   ```bash
   sudo systemctl status php-fpm.service
   ```
   
   revisamos la versión de php
   
   ```bash
   php -v
   ```
   
   recargamos la configuración del servidor apache2
   
   ```bash
   sudo systemctl reload htpd
   ```
   
   para probar que todo esta funcionando nos creamos un archivo de prueba
   
   ```bash
   sudo nano /var/www/html/info.php
   ```
   
    ingresamos el siguiente código
   
   ```php
   <?php
   phpinfo();
   ?>
   ```
   
   ingresamos a la ruta del navegador ya se por IP o por URl
   
   http://192.168.0.95/info.php
   
   http://[tu_dominio]/info.php

8. Habilitando la publicación por medio de enlaces simbólicos desde las carpetas /home a /var/www/html
   
   modificamos la configuración de apache2
   
   ```bash
   sudo nano /etc/httpd/conf/httpd.conf 
   ```
   
   la necesaria para lo requerido
   
   ```tex
   <Directory /var/www/html/>
       Options Indexes FollowSymLinks MultiViews
       AllowOverride All
       Order allow,deny
       allow from all
   </Directory>
   ```
   
   comprobamos la configuración de apache2
   
   ```bash
   apachectl -t
   ```
   
   recargamos la configuración del servidor apache2
   
   ```bash
   sudo systemctl reload htpd
   ```
   
   creamos una carpeta en la carpeta personal 
   
   ```bash
   mkdir test
   ```
   
   y movemos el archivo de /var/www/html a home/usuario
   
   ```bash
   sudo mv -fv /var/www/html/info.php /home/[tu_usuario]/test/
   ```
   
   cambiamos el propietario el grupo
   
   ```bash
   sudo chown -R [usuario]:[Grupo] test/info.php
   ```
   
   creamos el enlace simbólico
   
   ```bash
   ln -s [origen] [destino]
   ```

## En Debian 10

Instalamos y configuramos el servidor conforme a la Guía de Instalación de **Debian 10**

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

### Instalamos PHP

    - Descargamos Sury PPA for PHP 7.4 usando `wget`
    
    ```bash
    sudo apt -y install lsb-release apt-transport-https ca-certificates wget
    sudo wget -O /etc/apt/trusted.gpg.d/php.gpg     https://packages.sury.org/php/apt.gpg
    ```
    
    - adicionamos el APP descargada al servidor
    
    ```bash
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee     /etc/apt/sources.list.d/php.list
    ```
    
    - Actualizamos la lista de repositorios
    
    ```bash
    sudo apt update
    ```
    
    - Instalamos php
    
    ```bash
    sudo apt install php7.4
    ```
    
    Verificamos la versión instalada
    
    ```bash
    php -v
    ```

Instalamos exenciones básicas de PHP

    ```bash
    sudo apt install php7.4-    {common,mysql,xml,xmlrpc,curl,gd,imagick,cli,dev,imap,mbstring,opcache,soap,zip,intl,bcmath} -y
    ```

## Configuraciones de seguridad de Apache2

- ubicarse en la carpeta de configuración

```bash
cd /etc/apache2/conf-available/
```

- Respaldo de seguridad de los archivos charset.conf y security.con

```bash
sudo cp -rpfv charset.conf charset.conf.orig
sudo cp -rpfv security.conf security.conf.orig
```

- Modificamos el archivo charset.conf 

```bash
sudo nano charset.conf
```

- des cometamos la línea

```output
AddDefaultCharset UTF-8
```

- Modificamos el archivo security.conf

```bash
sudo nano security.conf
```

- des comentamos la línea

```output
ServerSignature Off
```

- cometamos la linea

```output
#ServerSignature On 
```

- nos ubicamos en

```bash
cd /etc/apache2/
```

- Respaldamos el archivo ports.conf

```bash
sudo cp -rpfv ports.conf ports.conf.orig
```

- Editamos el archivo ports.conf

```bash
sudo nano ports.conf
```

- Editamos la linea

```output
Listen 192.168.0.95:80
```

- Verificamos la configuraciones realizadas

```bash
sudo apache2ctl -t
```

- Reiniciamos el servicio de Apache2

```bash
sudo systemctl restart apache2.service
```

- Revisamos los puertos

```bash
sudo ss -tpan
```

```output
sysadmin@app01:/etc/apache2$ ss -tpan
State       Recv-Q      Send-Q           Local Address:Port              Peer Address:Port       
LISTEN      0           128              192.168.14.95:80                     0.0.0.0:*          
LISTEN      0           128                    0.0.0.0:22                     0.0.0.0:*          
ESTAB       0           0                192.168.14.95:22              192.168.14.254:49748      
LISTEN      0           128                       [::]:22                        [::]:* 
```

## Prueba de Funcionamiento de la instalación de php

* Para probar que todo esta funcionando nos creamos  carpeta `test` y archivo de prueba `index.php`
  
  ```bash
  sudo mkdir /var/www/html/test
  sudo nano /var/www/html/test/index.php
  ```

* Ingresamos el siguiente código
  
  ```php
  <?php
  phpinfo();
  ?>
  ```

* Revisamos  el resultado en la ruta del navegador ya se por IP o por URL
  
  * http://192.168.14.95/test
  * http://[tu_dominio]/test

## Archivo de Configuración php.ini

* Para editar el archivo de configuración
  
  ```bash
  sudo nano /etc/php/7.4/fpm/php.ini
  ```

* Parámetros básicos de configuración para modificar
  
  ```output
  upload_max_filesize = 32M 
  post_max_size = 48M 
  memory_limit = 256M 
  max_execution_time = 600 
  max_input_vars = 3000 
  max_input_time = 1000
  ```

## Configuración para en enlaces simbólicos de `/home` a` /var/www/html`

* Editar el archivo `apache.conf`
  
  ```bash
  sudo nano apache.conf
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
  
  ```bash
  sudo systemctl reload apache2.service 
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
  
  * http://192.168.0.95/test
  * http://[tu_dominio]/test

## Certificado SSL

### Instalamos certbot

apache

```bash
sudo apt install -y certbot python3-certbot-apache
```

nginx

```bash
sudo apt install -y certbot python3-certbot-nginx
```

Iniciamos la instalación y auto configuración del certificado

Sin configura apache o nginx

```bash
sudo certbot certonly -d tudominio.com --noninteractive --standalone --agree-tos --register-unsafely-without-email
```

configurando Apache

```bash
sudo certbot --apache -d tudominio.com -d www.tudominio.com --register-unsafely-without-email
```

configurando Nginx

```bash
sudo certbot --nginx -d tudominio.com -d www.tudominio.com --register-unsafely-without-email
```

resultado

```output
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Plugins selected: Authenticator standalone, Installer None
Obtaining a new certificate
Performing the following challenges:
http-01 challenge for [tudominio.com]
Waiting for verification...
Cleaning up challenges

IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/[tudominio.com]/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/[tudominio.com]/privkey.pem
   Your cert will expire on 2021-06-20. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot
   again. To non-interactively renew *all* of your certificates, run
   "certbot renew"
 - If you like Certbot, please consider supporting our work by:

   Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
   Donating to EFF:                    https://eff.org/donate-le
```

### Eliminar certificado SSL

```bash
sudo certbot delete
```

elijes el dominio al cual pertenece el certificado

```bash
1 dominio1.com
2 dominio2.com
```

o

```bash
sudo certbot delete --cert-name ejemplo.com
```

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

Verificamos el estado del VH

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

---

## Hardening

### Restricción de Acceso a Configuración .git

  
