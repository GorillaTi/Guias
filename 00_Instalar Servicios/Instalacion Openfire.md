Despues de instalar la distribucion linux deseada procedemos a instalar OpenFire
Requerimientos mínimos Openfire Server

    Servidor. Este puede ser Microsoft Windows o Linux o MacOS
    Base de datos con conexión JDBC externa o interna embebida
    Java 5 o superior
    MySQL o MariaDB
    Oracle 9i o superior
    PostgreSQL
    IBM DB2
    SQL Server
    Sybase
    HSQL DB
    u otra DB con driver JDBC 2.0

Recomendaciones de hardware Openfire Server
    1 a 500 usuarios concurrentes: 384MB RAM y procesador de 1.5 Ghz.
    501 a 10.000 usuarios concurrentes: 784MB RAM y procesador de 3 Ghz.
    10.001 a 25.000 usuarios concurrentes: 1.5Gb RAM, 2 procesadores de 3Ghz y un manejador de conexiones en el mismo server.
    25.001 a 100.000 usuarios concurrentes: 2Gb RAM, 2 procesadores de 3Ghz y entre 1 y 4 manejadores de conexiones del mismo tamaño en su propio server.

Instalamos dependencias requeridas para nuestra instalación de Openfire Server
#yum install wget mariadb mariadb-server

Descargamos la ultima versión actual de Openfire XMPP desde el sitio oficial ignite realtime (sugiero primero verificar en la sección Downloads cual es la ultima versión)
wget -c http://download.igniterealtime.org/openfire/openfire-4.2.3-1.x86_64.rpm

Antes de comenzar la instalacion deshabilitamos el firewall
#systemctl status firewalld
#systemctl stop firewalld

**********Como instalar Openfire en Centos**********

Por medio del comando rpm instalamos el archivo descargado en nuestro Centos Linux
rpm -vi openfire-4.2.3-1.x86_64.rpm

Preparando paquetes...
openfire-4.2.3-1.x86_64
Restarting openfire (via systemctl): [ OK ]

*Directorio de instalación de Openfire Server: /opt/openfire

Activamos el servicio Openfire para que inicie apenas haga boot nuestro servidor Centos
#systemctl enable openfire

Seguidamente iniciamos el servicio y verificamos su ejecución
#systemctl start openfire
#systemctl status openfire

● openfire.service - SYSV: Openfire is an XMPP server, which is a server that facilitates XML based communication, such as chat.
Loaded: loaded (/etc/rc.d/init.d/openfire; bad; vendor preset: disabled)
Active: active (running) since mié 2018-11-14 10:18:36 -05; 4s ago
Docs: man:systemd-sysv-generator(8)
Process: 1344 ExecStart=/etc/rc.d/init.d/openfire start (code=exited, status=0/SUCCESS)
Main PID: 1358 (java)
CGroup: /system.slice/openfire.service
‣ 1358 /opt/openfire/jre/bin/java -server -DopenfireHome=/opt/openfire -Dopenfire.lib.dir=/opt/openfire/...

**********Centos Openfire iptables**********

Usaremos tres puertos TCP

    9090 TCP: Acceso consola web http Openfire Server
    9091 TCP: Acceso consola web https Openfire Server
    5222 TCP: Conexiones de clientes XMPP a nuestro servidor Openfire

Abrimos los tres puertos y reiniciamos el servicio firewalld para que tome los cambios
#firewall-cmd --permanent --zone=public --add-port=9090/tcp
success

#firewall-cmd --permanent --zone=public --add-port=9091/tcp
success

#firewall-cmd --permanent --zone=public --add-port=5222/tcp
success

#firewall-cmd --reload

**********Openfire MariaDB**********

Activamos el servicio para que se ejecute cada vez que haga boot nuestro Linux Centos
#systemctl enable mariadb

Ejecutamos el servicio y verificamos su estado
#systemctl start mariadb
#systemctl status mariadb

● mariadb.service - MariaDB database server
Loaded: loaded (/usr/lib/systemd/system/mariadb.service; enabled; vendor preset: disabled)
Active: active (running) since mié 2018-11-14 10:30:44 -05; 10s ago
Process: 1683 ExecStartPost=/usr/libexec/mariadb-wait-ready $MAINPID (code=exited, status=0/SUCCESS)
Process: 1601 ExecStartPre=/usr/libexec/mariadb-prepare-db-dir %n (code=exited, status=0/SUCCESS)
Main PID: 1682 (mysqld_safe)
CGroup: /system.slice/mariadb.service
├─1682 /bin/sh /usr/bin/mysqld_safe --basedir=/usr
└─1843 /usr/libexec/mysqld --basedir=/usr --datadir=/var/lib/mysql --plugin-dir=/usr/lib64/mysql/plugin ...

Para mayor seguridad activamos contraseña y hacemos ajustes a MariaDB
#mysql_secure_installation

NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MariaDB
SERVERS IN PRODUCTION USE! PLEASE READ EACH STEP CAREFULLY!

In order to log into MariaDB to secure it, we'll need the current
password for the root user. If you've just installed MariaDB, and
you haven't set the root password yet, the password will be blank,
so you should just press enter here.

Enter current password for root (enter for none):
OK, successfully used password, moving on...

Setting the root password ensures that nobody can log into the MariaDB
root user without the proper authorisation.

Set root password? [Y/n] New password: <--Escribimos contraseña para root de MariaDB
Re-enter new password: <--Volvemos a escribir la contraseña
Password updated successfully!
Reloading privilege tables..
... Success!

By default, a MariaDB installation has an anonymous user, allowing anyone
to log into MariaDB without having to have a user account created for
them. This is intended only for testing, and to make the installation
go a bit smoother. You should remove them before moving into a
production environment.

Remove anonymous users? [Y/n] ... Success!

Normally, root should only be allowed to connect from 'localhost'. This
ensures that someone cannot guess at the root password from the network.

Disallow root login remotely? [Y/n] ... Success!

By default, MariaDB comes with a database named 'test' that anyone can
access. This is also intended only for testing, and should be removed
before moving into a production environment.

Remove test database and access to it? [Y/n] - Dropping test database...
... Success!
- Removing privileges on test database...
... Success!

Reloading the privilege tables will ensure that all changes made so far
will take effect immediately.

Reload privilege tables now? [Y/n] ... Success!

Cleaning up...

All done! If you've completed all of the above steps, your MariaDB
installation should now be secure.

Thanks for using MariaDB!
DB y usuario MariaDB para Openfire Server

Ya asegurado el servicio de MariaDB y su cuenta root, debemos crear una db junto a un usuario con privilegios para ella (no es recomendable usar root)

Ingresamos al CLI de MariaDB y creamos db y usuario.

Haz los cambios según tu conveniencia

Estos datos los necesitaremos mas adelante en la configuración
#mysql -u root -p
Enter password:
Welcome to the MariaDB monitor. Commands end with ; or \g.
Your MariaDB connection id is 11
Server version: 5.5.60-MariaDB MariaDB Server

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> create database openfiredb;<------Creamos la base de datos
Query OK, 1 row affected (0.00 sec)

MariaDB [(none)]> grant all on openfiredb.* to 'ofusr'@'localhost' identified by 'contraseña';
Query OK, 0 rows affected (0.00 sec)

MariaDB [(none)]> flush privileges;<--------Reiniciamos los provilegios
Query OK, 0 rows affected (0.00 sec)

MariaDB [(none)]> exit;<-------Salimos de la Base de Datos
Bye

Incrementar Openfire Java Memory

Este es un parámetro que debemos tener siempre presente para con el pasar del tiempo y aumento de carga, irlo aumentando

-Modificamos quitando el comentario de la linea y asignamos memoria RAM (en este caso 1 Gb)
#vi /etc/sysconfig/openfire
OPENFIRE_OPTS="-Xmx1024m"
