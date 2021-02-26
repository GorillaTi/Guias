GUÍA DE INSTALACIÓN 

# Instalación De PHP en CentOS 8

## ACERCA DE:

Versión: 1.0
Fecha: 25-02-2021
Nivel: Todos
Área: Data Center
Elaborado por: Edmundo Céspedes Ayllón
Técnico Encargado Data Center - G.A.M.S.
e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

------

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
   
   ```

   

8. Deshabilitamos SElinix

   revisamos el estado del servicio

   ```bash
   sestatus
   ```

   si esta habilitado procedemos a deshabilitar

   ```bash
   sudo nano /etc/selinux/config
   ```

   editamos la línea

   ```
   SELINUX=disabled
   ```

   reiniciamos el servidor para aplicar los cambios

   ```bash
   sudo shutdown -r now
   ```

   o

   ```bash
   sudo reboot
   ```

   revisamos el estado del servicio

   ```bash
   sestatus
   ```

   ```output
   SELinux status:                 disabled
   ```

9. revisamos si el sistema necesita reinicio.


  ```bash
    dnf whatprovides needs-restarting
    needs-restarting -r
  ```