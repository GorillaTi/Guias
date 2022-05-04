Guía de:

# Instalación Certbot (Let's Encrypt)

## ACERCA DE:

Versión: 1.0.0

Nivel: Medio

Área: C.P.D.

Elaborado por: Edmundo Céspedes Ayllón

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---

## Instalación de Certbot

Instalamos certbot

```bash
sudo apt install certbot
```

Apache

```bash
sudo apt install -y certbot python3-certbot-apache
```

Nginx

```bash
sudo apt install -y certbot python3-certbot-nginx
```

Verificamos la instalacion

```bash
sudo cerbot --version
```

## Certificado SSL mediante Dominio

Generamos el certificado SSL con configuración para:

Apache

```bash
sudo certbot --apache -d [tu_dominio.com] -d www.[tu_dominio.com] --register-unsafely-without-email
```

para subdominio especifico

```bash
sudo certbot --apache -d subdominio.[tu_dominio.com] --register-unsafely-without-email
```

Nginx

```bash
sudo certbot --nginx -d [tu_dominio.com] -d www.[tu_dominio.com] --register-unsafely-without-email
```

Para subdominio especifico

```bash
sudo certbot --nginx -d subdominio.[tu_dominio.com] --register-unsafely-without-email
```

Sin configura apache o nginx

```bash
sudo certbot certonly -d tudominio.com --noninteractive --standalone --agree-tos --register-unsafely-without-email
```

Resultado

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

Configurando VirtualHost  Manual

Apache

000-default.conf

```output
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

```output
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

Nginx

```
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

Eliminar certificado SSL

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

## Certificado SSL mediante DNS [Wildcard]

Generamos el certificado SSL

```bash
sudo certbot certonly  --manual --preferred-challenges=dns --email [t.email@] --server https://acme-v02.api.letsencrypt.org/directory --agree-tos -d *.[tu_dominio.com]
```

```bash
Los parámetros del comando son los siguientes:
```

- **certonly:** obtiene o renueva un certificado, pero no lo instala.
- **manual:** obtiene el certificado de forma interactiva.
- **preferred-challenges=dns:** es la forma en la que le indico a Let’s Encrypt que controlo en dominio (con DNS). Para ello me pedirá que cree un registro DNS de tipo TXT en mi dominio.
- **email:** dirección de correo electrónico para notificaciones importantes relacionadas con el certificado.
- **server:** el servidor de Let’s Encrypt contra el que se ejecutarán todas las operaciones.
- **agree-tos:** acepto los términos de servicio de Let’s Encrypt.
- **d:** dominio para el que quiero obtener el certificado. Fíjate que lleva un asterisco, lo que indica que va a ser wildcard.

El comando es interactivo, se tiene que responder unas cuantas preguntas.

 Compartir mi correo con la EFF para  que me envíen información sobre su trabajo.

```
Saving debug log to /var/log/letsencrypt/letsencrypt.log
Plugins selected: Authenticator manual, Installer None

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Would you be willing to share your email address with the Electronic Frontier
Foundation, a founding partner of the Let's Encrypt project and the non-profit
organization that develops Certbot? We'd like to send you email about our work
encrypting the web, EFF news, campaigns, and ways to support digital freedom.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(Y)es/(N)o: Y
```

A continuación indica que la IP desde la que esta ejecutando el comando será almacenada en registros púbicos y pregunta si esta de acuerdo con esto.

```
Obtaining a new certificate
Performing the following challenges:
dns-01 challenge for example.com

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
NOTE: The IP of this machine will be publicly logged as having requested this
certificate. If you're running certbot in manual mode on a machine that is not
your server, please ensure you're okay with that.

Are you OK with your IP being logged?
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
(Y)es/(N)o: Y
```

A continuación pide que cree un registro DNS de tipo TXT para  [tu_dominio.com].

Conectarse el  servidor de DNS de Zona de [tu_dominio.com] y crear el registro 

```
_acme-challenge.example.com IN TXT  KgZgEbDHUj3Zs-H4THSdCzU6z1GFmAyJw8psyAGEbqg
```

Una vez creado el registro esperamos unos minutos a que se propague el  cambio antes de continuar, ya que si el servidor de Let’s Encrypt no es  capaz de leer este registro, se tendra que empezar el proceso de nuevo.

Se puede comprobar si el registro TXT está propagado en [DNS Checker](https://dnschecker.org/#TXT/_acme-challenge.example.com) o en [MX Toolbox](https://mxtoolbox.com/SuperTool.aspx?action=txt%3a_acme-challenge.example.com&run=toolpage).

```
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Please deploy a DNS TXT record under the name
_acme-challenge.example.com with the following value:

KgZgEbDHUj3Zs-H4THSdCzU6z1GFmAyJw8psyAGEbqg

Before continuing, verify the record is deployed.
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Press Enter to Continue
```

Ahora el servidor de Let’s Encrypt comprueba el registro TXT y, si es correcto, genera el certificado wildcard.

```
Waiting for verification...
Cleaning up challenges

IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/example.com/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/example.com/privkey.pem
   Your cert will expire on 2020-09-01. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot
   again. To non-interactively renew *all* of your certificates, run
   "certbot renew"
 - If you like Certbot, please consider supporting our work by:

   Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
   Donating to EFF:                    https://eff.org/donate-le
```

Y ya está generado el certificado wildcard creado para usarlo con múltiples subdominios.

## Renovacion Automática

### Prueba de renovación del certificado

```bash
sudo certbot renew --dry-run
```

Lo siguiente es probar el comando, pero añadiéndole un `post hook`, que permite ejecutar un comando por shell tras el intento de renovación del certificado. Esto se hace para que se cargue los nuevos certificados.

Apache

```bash
certbot renew --post-hook "systemctl restart apache2.service"
```

Nginx

```bash
certbot renew --post-hook "systemctl restart nginx.service"
```

### Añadir la renovación del  certificado en el cron del root.

Buscamos las rutas absolutas de certbot y systemctl

```bash
which certbot
```

```
which systemctl
```

Editamos el cron

```bash
sudo crontab -e
```

Inserta la siguiente linea que ejecutar la renovación todos los días a la 1 y las 13 horas, 2 vedes por dia segun recomendacion de Let's Encrypt para:

Apache

```
00 2,14 * * * /usr/bin/certbot renew --quiet --post-hook "/bin/systemctl restart apache2.service"
```

Nginx

```
00 2,14 * * * /usr/bin/certbot renew --quiet --post-hook "/bin/systemctl restart nginx.service"
```
