GUÍA DE INSTALACIÓN 

# Instalación de Debian

## ACERCA DE:

Versión: 1.0

Fecha: 25-22-2021

Nivel: Todos

Área: Data Center

Elaborado por: Edmundo Céspedes Ayllón

Técnico Encargado Data Center - G.A.M.S.

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

## Instalación del S.O.


- Instalar SO siguiendo las instrucciones del instalador.

* Creamos las particiones de acuerdo a la siguiente tabla de particiones bajo LVM.

  |Tamaño|Tipo|Punto de montaje|
  |----|----|----|
  |1024 MB|Primaria|/boot|
  |2048 MB|LVM|swap|
  |min 20 GB|LVM|/|
  |min 20 GB|LVM|/home|

* Colocamos  el password para root definido por el encargado de Data Center
* Creamos el usuario sysadmin, registramos su password 

* seleccionamos los servicios mínimos para su instalación
  * SSH server
  * Utilidades estándar del sistema 

2. Iniciamos sesión con *root* y verificamos que este corriendo el servicio ssh.

3. Instalamos las características sudo

   ```bash
   sudo apt update
   sudo apt install sudo
   ```

4. damos permisos root al usuario creado en la instalación

   ```bash
   visudo
   ```

   adicionamos el usuario como sigue

   ```output
   # User privilege specification
   root    ALL=(ALL:ALL) ALL
   sysadmin ALL=(ALL:ALL) ALL
   ```

5. Nos conectamos al servidor mediante ssh

   ```bash
   ssh sysadmin@ipservidor
   ```

6. Creamos el usuario *desarrollo*

   ```bash
   sudo adduser desarrollo
   ```

7. Creamos contraseña de para el usuario *desarrollo*

   ```bash
   sudo passwd desarrollo
   ```

8. Incluimos al usuario *desarrollo* al grupo **sudo**.

   ```bash
   sudo usermod -aG sudo desarrollo
   ```

9. Verificamos que el usuario desarrollo se encentra en el grupo **sudo**.

   ```bash
   sudo cat /etc/group | grep sudo
   ```

## Verificamos versión de S.O.

```bash
cat /etc/*-release
```
## Actualizamos el S.O.

- Con apt

```bash
sudo apt update
sudo apt upgrade -y
```

## Instalar paquetes adicionales 

- net-tools y DNS bind9utils
  
```bash
sudo apt install -y net-tools bind9utils
```

## Revisamos los Puertos abiertos

```bash
  sudo netstat -nputa|grep :53
```

### Revisar configuración de Red

```bash
ip addr show
```
