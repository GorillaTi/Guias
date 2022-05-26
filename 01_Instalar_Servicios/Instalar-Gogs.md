Guía de:

# Instalar Gogs (Servidor Git)

## ACERCA DE:

Versión: 1.0.0

Nivel: Medio

Área: C.P.D.

Elaborado por: Edmundo Céspedes Ayllón

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---

Actualizamos el sistema operativo

```bash
sudo apt upgrade
```

Instalamos paquetes necesarios

```bash
sudo apt install git wget curl
```

Creamos la carpeta 

```bash
mkdir programs
```

Descargamos el paquete de el repositorio oficial de  [Gogs](https://gogs.io/docs/installation/install_from_binary)

```bash
wget https://dl.gogs.io/0.12.4/gogs_0.12.4_linux_amd64.tar.gz
```

Descomprimir el archivo descargado

```bash
tar xvf gogs_0.12.4_linux_amd64.tar.gz
```

Copiamos el archivo `gogs.service `al directorio `/etc/systemd/sysytem/`

```bash
sudo cp /home/git/programs/gogs/scripts/systemd/gogs.service /etc/systemd/system/
```

Editar archivo  `gogs.service`

```bash
[Unit]
Description=Gogs
After=syslog.target
After=network.target
After=mariadb.service mysqld.service postgresql.service memcached.service redis.service

[Service]
# Modify these two values and uncomment them if you have
# repos with lots of files and get an HTTP error 500 because
# of that
###
#LimitMEMLOCK=infinity
#LimitNOFILE=65535
Type=simple
User=git
Group=git
WorkingDirectory=/home/git/gogs
ExecStart=/home/git/gogs/gogs web
Restart=always
Environment=USER=git HOME=/home/git

# Some distributions may not support these hardening directives. If you cannot start the service due
# to an unknown option, comment out the ones not supported by your version of systemd.
ProtectSystem=full
PrivateDevices=yes
PrivateTmp=yes
NoNewPrivileges=true

[Install]
WantedBy=multi-user.target
```

Iniciamos el servicio gogs

```bash
sudo systemctl start --enablid gogs.service
```

Cree una base de datos MySQL y un usuario para Gogs, y otorgue permisos al usuario emitiendo los siguientes comandos:

```sql
SET @s = IF(version() < 8 OR (version() LIKE '%MariaDB%' AND version() < 10.3),
            'SET GLOBAL innodb_file_per_table = ON,
                        innodb_file_format = Barracuda,
                        innodb_large_prefix = ON;',
            'SET GLOBAL innodb_file_per_table = ON;');
PREPARE stmt1 FROM @s;
EXECUTE stmt1;

DROP DATABASE IF EXISTS gogs;
CREATE DATABASE IF NOT EXISTS gogs CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
```

Ingresamos en el navegador la siguiente URL

```bash
http://[ip_servidor]]/install
```

### Configuramos gogs

```bash
**Database Settings**
Database Type: MySQL
Host: https://[ip servidor]:3000
User: [ususario_db]
Password:[pass_usuario_db]
Database Name: [db_name]

**Application General Settings**
Aplicaction Name: [Nombre_App]
Repository Path: /hime/hit/gogs-repositories
Run User: git
Domain: [ip servidor]
SSH Port: 22 
HTTP Port: 3000
Application URL: https://[ip servidor]:3000
Log Path: /home/git/log

**Admin Acount Setings**
User: [ususario_super_admin]
Password: [pass_super_admin]
email: [email]
```

### Configurar Nginx como proxy

creamos el archivo gogs.midominio.site en el directorio /etc/nginx/sites-available

```bash
sudo vim /etc/nginx/sites-available/[gogs.midominio.site]
```

e insertamos el siguiente código

```bash
server {
    listen 80;
    server_name gogs.midominio.site;

    location / {
        proxy_pass http://[ip:servidor_gogs]:3000;
    }
}
```
