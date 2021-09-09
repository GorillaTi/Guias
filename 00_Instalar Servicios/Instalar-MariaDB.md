Guía de:

# Instalación De MariaDB

## ACERCA DE:

Versión: 1.0.1

Nivel: Medio

Área: CPD

Elaborado por: Edmundo Cespedes Ayllon

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

----

1. Instalamos CentOS 8 minimal, de acuerdo al manual

2. Nos conectamos al servidor mediante ssh

   ```bash
   ssh [usuario]@[ipservidor]
   ```

3. Actualizamos e instalamos las actualizaciones.

   ```bash
   sudo dnf update -y
   ```


## En CenOS 8 - Alma Linux 8.x

4. Instalamos mariadb

   ```bash
   sudo dnf install mariadb-server -y
   ```

10. Revisamos el estado del servidor mariadb.

    ```bash
    sudo systemctl status mariadb
    ```

    si esta inactivo lo iniciamos

    ```bash
    sudo systmctl start mariadb
    ```

11. Habilitamos el servicio de mariadb para que inicie con el sistema

    ```bash
    sudo systemctl enable --now mariadb
    ```

12. Aseguramos la instalación de mariadb

    ```bash
    sudo mysql_secure_installation
    ```

    el usuario root no tiene una contraseña das "Y" pedirá una contraseña para ese usuario, le das "Y" a todo  

13. Conexión a la base de datos

    ```bash
    mysql -u root -p
    ```

14. Creamos el usuario *sysadmin* y *desarrollo* para la base de datos con acceso remoto

    ```mysql
    GRANT ALL ON *.* TO 'desarrollo'@'%' IDENTIFIED BY 'pass_usuario' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
    select user, host from mysql.user;
    ```

15. Habilitamos el acceso remoto editando el archivo de configuración.

    ```bash
    sudo nano /etc/my.cnf.d/mariadb-server.cnf
    ```

    habilitamos borrando # de la línea 

    ```output
    bind-address = 0.0.0.0,
    ```

    reiniciamos el servicio mariadb.

    ```bash
    sudo systemctl restart mariadb
    ```

16. Deshabilitamos SElinix

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

17. Habilitamos los puertos del servicio mariadb el firewall

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
    firewall-cmd --add-service=http --permanent
    ```

    Reiniciamos el servicio del firewall

    ```bash
    firewall-cmd --reload
    ```

    Verificamos los servicios habilitados

    ```bash
    sudo firewall-cmd --list-services
    ```

    :bangbang: **​NOTA.-** Si fuera necesario el cambio de password o host de un usuario se puede utilizar la siguiente sentencia

    ```mysql
    UPDATE mysql.user SET Password=PASSWORD(‘NuevaContraseña’) WHERE USER=’nombreUsuario’ AND Host=”NombreHost”;
    ```
    ```mysql
    FLUSH PRIVILEGES;
    ```
    ```mysql
    select user, host from mysql.user
    ```