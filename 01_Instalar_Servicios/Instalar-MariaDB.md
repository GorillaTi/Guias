Guía de:

# Instalación De MariaDB

## ACERCA DE:

Versión: 2.0.0

Nivel: Medio

Área: CPD

Elaborado por: Edmundo Céspedes Ayllón

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

----

## Requisitos

1. Instalamos el sistema operativo de acuerdo al manual de instalación.

2. Conectarse al servidor mediante ssh
   
   ```bash
   ssh [usuario]@[ipservidor]
   ```

## En CenOS 8 / Alma Linux 8.x / RokiLinux 8.x

1. Actualizamos e instalamos las actualizaciones.
   
   ```bash
   sudo dnf update -y
   ```

2. Instalamos MariaDB
   
   ```bash
   sudo dnf install mariadb-server -y
   ```

## En Debian 11

1. Actualizamos e instalamos las actualizaciones.
   
   ```bash
   sudo apt-get update && sudo apt-get upgrade -y
   ```

2. Instalando paquetes necesarios
   
   ```bash
   sudo apt-get install software-properties-common dirmngr gnupg2 -y
   ```
   
   ```bash
   sudo apt-get install apt-transport-https wget curl -y
   ```

3. Instalamos MariaDB
   
   ```bash
   sudo apt-get install mariadb-server -y
   ```

## Iniciando MariaDB

1. Estado del servicio MariaDB.
   
   ```bash
   sudo systemctl status mariadb
   ```

2. Habilitar el servicio de MariaDB para que inicie con el sistema
   
   ```bash
   sudo systemctl enable --now mariadb
   ```

3. Iniciando MariaDB
   
   ```bash
   sudo systmctl start mariadb
   ```

## Asegurando MariaDB

1. Aseguramos la instalación de MariaDB
   
   ```bash
   sudo mysql_secure_installation
   ```
   
   o
   
   ```bash
   sudo /usr/bin/mysql_secure_installation
   ```
   
       el usuario root no tiene una contraseña seleccionas  `Y` pedirá        una contraseña para ese usuario, le das "`Y`" a todo 

## Accediendo a MariaDB

1. Conexión a la base de datos
   
   ```bash
   mysql -u root -p
   ```

## Creación de Usuarios

1. Creando usuarios para todas la base de datos con acceso remoto
   
   ```sql
   GRANT ALL ON *.* TO 'usuario'@'%' IDENTIFIED BY 'pass_usuario' WITH GRANT OPTION;
   ```

2. Reiniciando privilegios
   
   ```sql
   FLUSH PRIVILEGES;
   ```

3. Listando usuarios
   
   ```sql
   select user, host from mysql.user;
   ```

4. Saliendo de la consola de MariaDB
   
   ```sql
   exit;
   ```
   
   o
   
   ```sql
   quit;
   ```

## Habilitando acceso Remoto

1. Habilitar acceso remoto editando el archivo de configuración.
   
   En CentOS
   
   ```bash
   sudo nano /etc/my.cnf.d/mariadb-server.cnf
   ```
   
   En Debian
   
   ```bash
   sudo vim /etc/mysql/mariadb.conf.d/50-server.cnf
   ```

2. Habilitamos borrando # de la línea 
   
   ```shell-session
   bind-address = 0.0.0.0,
   ```

3. Reiniciamos el servicio MariaDB.
   
   ```bas
   sudo systemctl restart mariadb
   ```

## Configurar firewall para MariaDB

### En CentOS

Verificamos el estado del firewall

```bash
systemctl status firewalld
```

Verificamos los servicios habilitados

```bash
sudo firewall-cmd --list-services
```

Adicionamos el servicio de forma permanente

```bash
firewall-cmd --add-service=mysql --permanent
```

Reiniciamos el servicio del firewall

```bash
firewall-cmd --reload
```

Verificamos los servicios habilitados

```bash
sudo firewall-cmd --list-services
```

## Cambio de Password o Host

Si fuera necesario el cambio de password o host de un usuario se puede utilizar la siguiente sentencia

```sql
UPDATE mysql.user SET Password=PASSWORD(‘NuevaContraseña’) WHERE USER=’nombreUsuario’ AND Host=”NombreHost”;
```

```sql
FLUSH PRIVILEGES;
```

```sql
select user, host from mysql.user
```