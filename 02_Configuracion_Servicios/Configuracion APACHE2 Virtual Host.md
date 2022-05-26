Gia de:

# Configuración de VirtualHost

## ACERCA DE:

Versión: 1.0.1

Nivel: Medio

Área: CPD

Elaborado por: Edmundo Céspedes Ayllón

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---

## Carpetas de Trabajo APACHE2

Ubicaciones de los archivos de :

Configuraciones

```bash
/etc/apache2
```

Alojamiento

```bash
/var/www/html
```

## Carpeta de configuración de virtual host

```bash
/etc/apache2/site-avaible/
```

```bash
/etc/apache2/site-enable/
```

## Archivo de configuración por defecto

```bash
000-default.conf
```

## Configurando de acuerdo al Dominio

Se crea archivos de configuración de acuerdo al dominio o sub-dominio, sitio.ejemplo.conf

Ejemplo de configuración:

---NORMAL----

```shell-session
<VirtualHost *:80> ---(*) es la IP - (:80) Numero de Puerto
    ServerName sitio.ejemplo.com --nombre del servidor
    ServerAdmin datacenter.gams@sucre.bo -- direccion email del sysadmin
    ServerAlias www.sitio.ejemplo.com -- alias de sitio
    DocumentRoot /var/www/html -- carpeta donde se aloja el sitio
    DirectoryIndex index.html -- archivo principal del sitio.
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

----LARAVEL-----

```shell-session
<VirtualHost *:80>
    ServerName soporte.sucre.bo
    ServerAlias www.soporte.sucre.bo
    ServerAdmin datacenter.gams@sucre.bo
    DocumentRoot /var/www/html/soporte/public/ 
    ErrorLog ${APACHE_LOG_DIR}/error_soporte.log
    CustomLog ${APACHE_LOG_DIR}/access_soporte.log combined
    <Directory "/var/www/html/soporte/public">
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

### Verificar sintaxis correcta

```bash
sudo apache2ctl -t
```

### Para habilitar el sitio

```bash
sudo a2ensite sitio.ejemplo.conf
```

Se debe de recargar el servicio de apache2

```bash
sudo sevice apache2 reload
```

### Para deshabilitar el sitio

```bash
sudo a2dissite sitio.ejemplo.conf
```

Se debe de recargar el servicio de apache2

```bash
sudo sevice apache2 reload
```

## Ver host virtuales activos

```bash
sudo apachectl -S
```

Ejemplo:

```output
AH00112: Warning: DocumentRoot [/var/www/html/laravel-prueba] does not exist
VirtualHost configuration:
*:80                   is a NameVirtualHost
         default server mensaje.sucre.bo.local (/etc/apache2/sites-enabled/000-default.conf:1)
         port 80 namevhost mensaje.sucre.bo.local (/etc/apache2/sites-enabled/000-default.conf:1)
         port 80 namevhost credenciales.sucre.bo.local (/etc/apache2/sites-enabled/credenciales.conf:1)
                 alias credenciales.sucre.bo.local
         port 80 namevhost registro.sucre.bo.local (/etc/apache2/sites-enabled/registro.conf:1)
                 alias registro.sucre.bo.local
         port 80 namevhost test.gams.bo (/etc/apache2/sites-enabled/test.conf:1)
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
