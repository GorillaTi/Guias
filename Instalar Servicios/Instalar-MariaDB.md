## Instalación De MariaDB en CentOS 8

1. Instalamos CentOS 8 minimal, solo con lo necesario.
   * Configuramos la interface red 
   * Configuramos con el servidor de hora
   * Colocamos  el password para root definido por el encargado de Data Center
   * Creamos el usuario sysadmin, registramos su password y le damos privilegios de administrador

2. Iniciamos sesión con *root* y verificamos que este corriendo el servicio ssh.

3. Nos conectamos al servidor mediante ssh

   ```bash
   ssh sysadmin@ipservidor
   ```

4.  Instalamos el repositorio de fedora

   ```bash
   sudo dnf install epel-release -y
   ```

5. Actualizamos e instalamos las actualizaciones.

   ```bash
   sudo dnf update -y
   ```

6. Creamos el usuario *desarrollo*

   ```bash
   sudo adduser desarrollo
   ```

7. Creamos contraseña de para el usuario *desarrollo*

   ```bash
   sudo passwd desarrollo
   ```

8. Incluimos al usuario *desarrollo* al grupo *sudoers*.

   ```bash
   sudo usermod -aG wheel desarrollo
   ```

9. Verificamos que el usuario desarrollo se encentra en el grupo wheel.

   ```bash
   sudo lid -g wheel
   ```

10. Instalamos mariadb

    ```bash
    sudo dnf install mariadb-server -y
    ```

11. Revisamos el estado del servidor mariadb.

    ```bash
    sudo systemctl status mariadb
    ```

    si esta inactivo lo iniciamos

    ```bash
    sudo systmctl start mariadb
    ```

12. Habilitamos el servicio de mariadb para que inicie con el sistema

    ```bash
    sudo systemctl enable mariadb
    ```

13. Aseguramos la instalación de mariadb

    ```bash
    sudo mysql_secure_installation
    ```

    el usuario root no tiene una contraseña das "Y" pedirá una contraseña para ese usuario, le das "Y" a todo  

14. Conexión a la base de datos

    ```bash
    mysql -u root -p
    ```

15. Creamos el usuario *sysadmin* y *desarrollo* para la base de datos con acceso remoto

    ```mysql
    mysql> GRANT ALL ON *.* TO 'desarrollo'@'%' IDENTIFIED BY 'pass_usuario' WITH GRANT OPTION;
    mysql> FLUSH PRIVILEGES;
    mysql> select user, host from mysql.user
    ```

16. Habilitamos el acceso remoto editando el archivo de configuración.

    ```bash
    sudo nano /etc/my.cnf.d/mariadb-server.cnf
    ```

    habilitamos borrando # de la línea bind-address = 0.0.0.0, reiniciamos el servicio mariadb.

    ```bash
    sudo systemctl restart mariadb
    ```

17. Deshabilitamos SElinix

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

18. Habilitamos los puertos del servicio mariadb el firewall

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

    ###### Si fuera necesario el cambio de password o host de un usuario se puede utilizar la siguiente sentencia

    ```mysql
    mysql> UPDATE mysql.user SET Password=PASSWORD(‘NuevaContraseña’) WHERE USER=’nombreUsuario’ AND Host=”NombreHost”;
    mysql> FLUSH PRIVILEGES;
    mysql> select user, host from mysql.user
    ```