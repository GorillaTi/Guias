GUÍA DE INSTALACIÓN 

# Instalación de CentOS

## ACERCA DE:

Versión: 1.0
Fecha: 25-22-2021
Nivel: Todos
Área: Data Center
Elaborado por: Edmundo Cespedes Ayllon
Técnico Encargado Data Center - GAMS
Email: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)


- Instalar SO siguiendo las instrucciones del instalador.
- Instalamos CentOS 8 minimal, solo con lo necesario.
  * Configuramos la interfaces red 

  * Configuramos con el servidor de hora

* Creamos las particiones de acuerdo a la siguiente tabla de particiones bajo LVM.

  ​    

   * Colocamos  el password para root definido por el encargado de Data Center

   * Creamos el usuario sysadmin, registramos su password y le damos privilegios de administrador

2. Iniciamos sesión con *root* y verificamos que este corriendo el servicio ssh.

3. Nos conectamos al servidor mediante ssh

   ```bash
   ssh sysadmin@ipservidor
   ```

4. Habilitamos la interface web del servidor

   ```bash
   systemctl enable --now cockpit.socket
   ```

5. Instalamos el repositorio de fedora

   ```bash
   sudo dnf install -y epel-release
   ```

6. Actualizamos e instalamos las actualizaciones.

   ```bash
   sudo dnf update -y
   ```

7. Instalar  utilidades de dnf

   ```bash
   sudo dnf install -y dnf-utils
   ```

8. Creamos el usuario *desarrollo*

   ```bash
   sudo adduser desarrollo
   ```

9. Creamos contraseña de para el usuario *desarrollo*

   ```bash
   sudo passwd desarrollo
   ```

10. Incluimos al usuario *desarrollo* al grupo *sudoers*.

    ```bash
    sudo usermod -aG wheel desarrollo
    ```

11. Verificamos que el usuario desarrollo se encentra en el grupo wheel.

    ```bash
    sudo lid -g wheel
    ```

## Configuración de red y el nombre del equipo
```bash
sudo nmtui
```
## Verificamos versión de S.O.

```bash
cat /etc/redhat-release
```
```bash
cat /etc/os-release
```
## Actualizamos el SO

- Con yum

```bash
sudo yum update
sudo yum -y upgrade
```

- Con dnf

```bash
sudo dnf update
```

## Instalar paquetes adicionales 

- net-tools y DNS bind-utils
  
```bash
sudo yum -y install net-tools bind-utils
```

- instalamos utilidades de dnf
```bash
sudo dnf install dnf-utils
```
## Revisamos los Puertos abiertos

```bash
  sudo netstat -nputa|grep :53
```

## Revisamos si el sistema necesita reinicio.

```bash
    dnf whatprovides needs-restarting
    needs-restarting -r
```

