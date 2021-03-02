GUÍA DE INSTALACIÓN 

# Instalación De Apache  y PHP. 

## ACERCA DE:

Versión: 1.0
Fecha: 25-02-2021
Nivel: Todos
Área: Data Center
Elaborado por: Edmundo Céspedes Ayllón
Técnico Encargado Data Center - G.A.M.S.
e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

------

## En CentOS 8

1. Instalamos y configuramos el servidor conforme a la Guía de Instalación de CentOS 8.

2. Instalamos Apache2

   ```bash
   sudo dnf install -y httpd
   ```

3. Habilitamos el  los puertos http y https en el firewall

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

4. Instalamos PHP

   - Revisamos la versión de php en los repositorios

   ```bash
   sudo dnf module list php
   ```

   Si la versiones disponibles cubren nuestras necesidades, la instalamos

   Caso contrario adicionamos el repositorio para versiones mas actuales en la pagina 

   https://rpms.remirepo.net/wizard/

5. instalamos los módulos de php

   ```bash
   sudo dnf install -y php php-opcache php-curl php-common php-mysqlnd php-gd
   ```

6. habilitamos los servicios de php

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
   sudo systemctl reload hhpd
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

   http://192.168.14.95/info.php

   http://app.sucre.bo/info.php

7. Habilitando la publicación por medio de enlaces simbólicos desde las carpetas /home a /var/www/html

   modificamos la configuración de apache2

   ```bash
   sudo nano /etc/httpd/conf/httpd.conf 
   ```

   la necesaria para lo requerido

   ```tex
   <Directory /var/www/html/ >
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
   sudo systemctl reload hhpd
   ```

   creamos una carpeta en la carpeta personal 

   ```bash
   mkdir test
   ```

   y movemos el archivo de /var/www/html a home/usuario

   ```bash
   sudo mv -fv /var/www/html/info.php /home/sysadmin/test/
   ```

   cambiamos el propietario el grupo

   ```bash
   sudo chown -R sysadmin:sysadmin test/info.php
   ```

   creamos el enlace simbólico

   ```
   ln -s
   ```
## En Debian 10

1. Instalamos y configuramos el servidor conforme a la Guía de Instalación de **Debian 10**
   
### Instalación de Apache2

2. Actualizamos e instalamos actualizaciones

   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

3. Instalamos apache2

   ```bash
   sudo apt install apache2
   ```

4. Configuramos el auto inicio y iniciamos el servicio

   ```bash
   sudo systemctl enable --now apache2.service
   sudo systemctl start apache2.service
   ```

5. Revisamos el estado del servicio.

   ```bash
   sudo sytemctl status apache2.service
   ```

6. Revisamos los puertos

   ```bash
   sudo ss -tpan
   ```

7. Configuraciones de seguridad de Apache2

   * ubicarse en la carpeta de configuración

     ```bash
     cd /etc/apache2/conf-available/
     ```

   * Respaldo de seguridad de los archivos charset.conf y security.con

     ```bash
     sudo cp -rpfv charset.conf charset.conf.orig
     sudo cp -rpfv security.conf security.conf.orig
     ```

   * Modificamos el archivo charset.conf 

     ```bash
     sudo nano charset.conf
     ```

     des cometamos la linea 

     ```output
     AddDefaultCharset UTF-8
     ```

   * Modificamos el archivo security.conf

     ```bash
     sudo nano securyti.conf
     ```

     des comentamos la linea

     ```output
     ServerSignature Off
     ```

     y cometamos la linea

     ```output
     #ServerSignature On 
     ```

   * nos ubicamos en

     ```bash
     cd /etc/apache2/
     ```

   * Respaldamos el archivo ports.conf

     ```bash
     sudo cp -rpfv ports.conf ports.conf.orig
     ```

   * editamos el archivo ports.conf

     ```bash
     sudo nano ports.conf
     ```

     editamos la linea

     ```output
     Listen 192.168.14.95:80
     ```

   * verificamos la configuraciones realizadas

     ```bash
     sudo apache2ctl -t
     ```

   * reiniciamos el servicio de Apache2

     ```bash
     sudo systemctl restart apache2.service
     ```

   * Revisamos los puertos

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
### Instalamos PHP 

5. Descargamos Sury PPA for PHP 7.4 usando `wget`

   ```bash
   sudo apt -y install lsb-release apt-transport-https ca-certificates wget
   sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
   ```

   adicionamos el APP descargada al servidor

   ```bash
   echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list
   ```

6. Actualizamos la lista de repositorios

   ```bash
   sudo apt update
   ```

7. Instalamos php

   ```bash
   sudo apt install php7.4
   ```

8. Verificamos la versión instalada

   ```bash
   php -v
   ```

9. Instalamos exenciones básicas de PHP

   ```bash
   sudo apt install php7.4-{common,mysql,xml,xmlrpc,curl,gd,imagick,cli,dev,imap,mbstring,opcache,soap,zip,intl,bcmath} -y
   ```

### Prueba de Funcionamiento de la instalación de php

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

   * Revisamos  el resultado en la ruta del navegador ya se por IP o por URl
        * http://192.168.14.95/test
        * http://app.sucre.bo/test

### Archivo de Configuración php.ini

* Para editar el archivo de configuración

  ```bash
  sudo nano /etc/php/7.4/fpm/php.ini
  ```

*  Parámetros básicos de configuración para modificar

  ```output
  upload_max_filesize = 32M 
  post_max_size = 48M 
  memory_limit = 256M 
  max_execution_time = 600 
  max_input_vars = 3000 
  max_input_time = 1000
  ```

### Configuración para en enlaces simbólicos de `/home` a` /var/www/html`

* Editar el archivo `apache.conf`

  ```bash
  sudo nano apache.conf
  ```

* Insertamos el siguiente código

  ```properties
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

### Prueba de funcionamiento de enlace simbólico

* Movemos el directorio `/test` 

  ```bash
  sudo mv -fv /var/www/html/test/ /home/sysadmin/
  ```

* Cambiamos el propietario de la carpeta

  ```bash
  sudo chown -R sysadmin:sysadmin test/
  ```

* Creamos el enlace simbólico

  ```bash
  sudo ln -s /home/sysadmin/test/ /var/www/html/test
  ```

* Revisamos en el navegador

  * http://192.168.14.95/test
     * http://app.sucre.bo/test