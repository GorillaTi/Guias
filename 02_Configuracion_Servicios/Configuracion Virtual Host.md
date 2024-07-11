Guía de:

# Configuración de Virtual Host

## ACERCA DE:

Versión: 1.2.3

Nivel: Medio

Área: CPD

Elaborado por: Edmundo Céspedes Ayllón

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---

## Directorios de Trabajo

### APACHE2 / HTTPD

#### Archivos de :

Configuraciones

- Debian / Ubuntu

```bash
/etc/apache2
```

- RHEL

```bash
/etc/httpd
```

Alojamiento

```bash
/var/www/html
```

#### Directorios de configuración de virtual host

- Debian / Ubuntu

```bash
/etc/apache2/sites-available/
```

```bash
/etc/apache2/site-enable/
```

#### Archivo de configuración por defecto

```bash
000-default.conf
```

## Configurando de acuerdo al Dominio

Se crea archivos de configuración de acuerdo al `dominio` o `sub-dominio`

- Debian / Ubuntu

```bash
sudo vim /etc/pache2/sites-available/sitio.ejemplo.conf
```

Ejemplo de configuración:

### ---NORMAL----

```apacheconf
<VirtualHost *:80> ---(*) es la IP - (:80) Numero de Puerto
    ServerName [tu_dominio.com]--nombre del servidor
    ServerAdmin datacenter.gams@sucre.bo -- direccion email del sysadmin
    ServerAlias www.[tu_dominio.com] -- alias de sitio
    DocumentRoot /var/www/html -- carpeta donde se aloja el sitio
    DirectoryIndex index.html -- archivo principal del sitio.
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

### ----LARAVEL-----

```apacheconf
<VirtualHost *:80>
    ServerName [tu_dominio.com]
    ServerAlias www.[tu_dominio.com]
    ServerAdmin [email_admin]
    DocumentRoot /var/www/html/[directorio]/public/ 
    ErrorLog ${APACHE_LOG_DIR}/error_[name_app].log
    CustomLog ${APACHE_LOG_DIR}/access_[name_app].log combined
    <Directory "/var/www/html/[directorio]/public">
        Options +Indexes +FollowSymLinks
        DirectoryIndex index.php
        AllowOverride None
        Require all granted
            <IfModule mod_rewrite.c>
                <IfModule mod_negotiation.c>
                    Options -MultiViews
                </IfModule>

                RewriteEngine On

                # Handle Front Controller...
                RewriteCond %{REQUEST_FILENAME} !-d
                RewriteCond %{REQUEST_FILENAME} !-f
                RewriteRule ^ index.php [L]

                # Handle Authorization Header
                RewriteCond %{HTTP:Authorization} .
                RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]
            </IfModule>
    </Directory>
</VirtualHost>
```

<a name="sintaxis"></a>

### Verificar sintaxis correcta

```bash
sudo apache2ctl -t
```

### Para habilitar el sitio

```bash
sudo a2ensite sitio.ejemplo.conf
```

<a name="recarga"></a>

### Recargar el servicio apache2 / httpd

- Debian / Ubuntu

```bash
sudo sevice apache2 reload
```

o

```bash
sudo systemctl reload apache2.service
```

- RHEL

```bash
sudo systemctl restart httpd.service
```

### Para des-habilitar el sitio

```bash
sudo a2dissite sitio.ejemplo.conf
```

Se debe [recargar el servicio](#recarga) de apache.

## Ver host virtuales activos

```bash
sudo apachectl -S
```

Ejemplo:

```shell-session
AH00112: Warning: DocumentRoot [/var/www/html/laravel-prueba] does not exist
VirtualHost configuration:
*:80                   is a NameVirtualHost
         default server [url_sitio].local (/etc/apache2/sites-enabled/000-default.conf:1)
         port 80 namevhost [url_sitio].local (/etc/apache2/sites-enabled/000-default.conf:1)
         port 80 namevhost [url_sitio].local (/etc/apache2/sites-enabled/credenciales.conf:1)
                 alias [url_sitio].local
         port 80 namevhost [url_sitio].local (/etc/apache2/sites-enabled/registro.conf:1)
                 [url_sitio].local
         port 80 namevhost [url_sitio] (/etc/apache2/sites-enabled/[url_sitio].conf:1)
ServerRoot: "/etc/apache2"
Main DocumentRoot: "/var/www/html"
Main ErrorLog: "/var/log/apache2/error.log"
Mutex mpm-accept: using_defaults
Mutex watchdog-callback: using_defaults
Mutex rewrite-map: using_defaults
Mutex default: dir="/var/lock/apache2" mechanism=fcntl 
PidFile: "/var/run/apache2/apache2.pid"
Define: DUMP_VHOSTS
Define: DUMP_RUN_CFG
Define: MODSEC_2.5
Define: MODSEC_2.9
User: name="www-data" id=33
Group: name="www-data" id=33
```

## Ver los registro de errores de apache2

```bash
tail -f /var/log/apache2/error_log
```

## Habilitar Modulo rewrite

Habilitar modulo `rewrite`

```bash
sudo a2enmod rewrite
```

Verificando que este habilitado

```bash
sudo apache2ctl -M
```

Se debe [recargar el servicio](#recarga) para actualizar las configuraciones. 

### Habilitar AllowOverride en:

#### General

Editar el archivo `apache2.conf`

```bash
sudo vim /etc/apache2/apache2.conf
```

Modificamos la lineas de `AllowOverride`

```apacheconf
AllowOverride All
```

Se debe [recargar el servicio](#recarga) para actualizar las configuraciones.

### VHost SSL

Editar el archivo vhost en especifico

```bash
sudo vim /etc/apache2/site-available/[vhost_a_modificar]
```

Insertamos las siguientes configuraciones

```apacheconf
<IfModule mod_ssl.c>
<VirtualHost [ip_host]:443>
    ServerName [name_site]
    ServerAdmin [email_admin]
    ServerAlias [alias_name_site]
    DocumentRoot /var/www/html/[dir_public]
    DirectoryIndex index.html index.php

    ErrorLog /var/log/apache2/[name_site].log
    CustomLog /var/log/apache2/[name_site].access.log combined

    RewriteEngine on
    #redirect https non-www to https www
    #RewriteCond %{SERVER_NAME} !^www\.(.*)$ [NC]
    #RewriteRule ^ https://www.%{SERVER_NAME}%{REQUEST_URI} [END,QSA,R=permanent]

    SSLEngine on
    Include /etc/letsencrypt/options-ssl-apache.conf
    SSLCertificateFile /etc/letsencrypt/live/[name_site]/fullchain.pem
    SSLCertificateKeyFile /etc/letsencrypt/live/[name_site]/privkey.pem

    # Config Acces Laravel
    <Directory "/var/www/html/[dir_public]/">
        Options +Indexes +FollowSymLinks
        DirectoryIndex index.php index.html
        AllowOverride all
        Require all granted
             <IfModule mod_rewrite.c>
                 <IfModule mod_negotiation.c>
                     Options -MultiViews
                 </IfModule>

                 RewriteEngine On
                 # Handle Authorization Header
                 #RewriteCond %{HTTP:Authorization} .
                 RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]
                 # Handle Front Controller...
                 RewriteBase /portal/
                 RewriteRule ^index\.php$ - [L]
                 RewriteCond %{REQUEST_FILENAME} !-f
                 RewriteCond %{REQUEST_FILENAME} !-d
                 RewriteRule ./portal/index.php [L]
            </IfModule>
    </Directory>
</VirtualHost>
</IfModule>
```

Creamos el archivo `.htaccess` en el directorio raíz de la aplicación

```bash
sudo vim /var/www/html/[directorio]/.htaccess
```

Insertamos el siguiente código

```apacheconf
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]
RewriteBase /portal/
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /portal/index.php [L]
</IfModule>
```

> ***Nota.-*** Configuración recomendada par WordPress y URLs amigables.

[Verificar la configuración](#sintaxis) realizada

Se debe [recargar el servicio](#recarga) para actualizar las configuraciones.

## Configurar VHost para Proxy Reverso

Crear el archivo de configuración del vhost  para el puerto 80

- Debian

```bash
sudo vim /etc/apache2/site-availeable/[nombre_host]
```

- RHEL

```bash
sudo vim /etc/httpd/conf.d/[nombre_archivo]
```

Insertamos la siguiente configuración 

```apacheconf
<VirtualHost *:80>
        ServerAdmin [email_admin_site]
        ServerName [ip_servidor]
        ServerAlias [ip_servidor]

        RewriteEngine On

        DocumentRoot "/var/www/html/[dir_app]"
        <Directory "/var/www/html/sigec/[dir_app]">
                Options Indexes FollowSymLinks MultiViews
                AllowOverride All
                Order allow,deny
                Allow from all
                Require all granted
        </Directory>
</VirtualHost>
```

[Verificar la configuración](#sintaxis) realizada

Se debe [recargar el servicio](#recarga) para actualizar las configuraciones.

## VHost por Puertos

Editamos el archivo `ports.conf` o `httpd.conf`

- Debian

```bash
nano /etc/apache2/ports.conf
```

- RHEL

```bash
nano /etc/httpd/conf/httpd.conf
```

Incluimos la linea siguiente

```bash
Listen [numero_puerto]
```

Editamos o creamos el archivo VHost

- Debian

```bash
sudo vim /etc/apache2/site-avaliable/[vhost_arch]
```

- RHEL

```bash
sudo vim /etc/httpd/conf.d/[vhost_arch]
```

Insertamos la siguiente configuración

```apacheconf
<VirtualHost *:[numero_puerto]>
        ServerAdmin [mail_admin]
        ServerName [ip_servidor]
        ServerAlias [ip_servidor]

        RewriteEngine On

        DocumentRoot "/var/www/html/[dir_app]"
        <Directory "/var/www/html/[dir_app]">
                Options Indexes FollowSymLinks MultiViews
                AllowOverride All
                Order allow,deny
                Allow from all
                Require all granted
        </Directory>
</VirtualHost>
```

[Verificar la configuración](#sintaxis) realizada

Se debe [recargar el servicio](#recarga) para actualizar las configuraciones.

<a name="puertos"></a>

### Verificamos el estado de los puertos

```bash
sudo netstat -tlpn| grep apache
```

o

```bash
sudo ss -tlpn| grep apache
```

### Probar su funcionamiento usamos un navegador web

```textile
http://[ip_serv]:[numero_puerto]
```

### Habilitar puertos en Firewall y SELinux

Instalamos el gestor interactivo de SELinux

```bash
sudo dnf install policycoreutils
```

Habilitamos la política para el numero de Puerto

```bash
sudo semanage port -a -t http_port_t -p tcp [numero_puerto]
sudo semanage port -m -t http_port_t -p tcp [numero_puerto]
```

> **Nota.-** En caso del problemas con `semanager`
> 
> Instalar la alternativa
> 
> ```bash
> sudo dnf install policycoreutils-python
> ```

Se deber [reiniciar el servicio](#recarga)

Verificamos el Estado de los [puertos del Servicio](#puertos)
