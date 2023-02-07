Guía de: 

# Instalación de Debian

## ACERCA DE:

Versión: 1.0.2

Nivel: Todos

Área: CPD

Elaborado por: Edmundo Céspedes Ayllón

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

## Instalación del S.O.

- Instalar SO siguiendo las instrucciones del instalador.
* Creamos las particiones de acuerdo a la siguiente tabla de particiones bajo LVM.
  
  | Tamaño    | Tipo     | Punto de montaje |
  | --------- | -------- | ---------------- |
  | 1024 MB   | Primaria | /boot            |
  | 2048 MB   | LVM      | swap             |
  | min 20 GB | LVM      | /                |
  | min 20 GB | LVM      | /home            |

* Colocamos  el password para root definido por el encargado de Data Center

* Creamos el usuario sysadmin, registramos su password 

* seleccionamos los servicios mínimos para su instalación
  
  * SSH server
  * Utilidades estándar del sistema 

Iniciamos sesión con *root* y verificamos que este corriendo el servicio ssh.

```bash
systemctl statsus sshd.service
```

## Dar permisos de Super Ususario

Instalamos las características sudo

```bash
apt update
apt install sudo
```

### a) Editando el archivo de sudoers

Ejecutando el comado

```bash
visudo
```

o editamos con el comado

```bash
vim /etc/sudoer
```

adicionamos el usuario como sigue

```output
# User privilege specification
root    ALL=(ALL:ALL) ALL
sysadmin ALL=(ALL:ALL) ALL
```

### b) Añadiendo el usuario al grupo sudo

```bash
usermod -aG sudo [usuario] 
```

> **Nota.-** Nos conectamos al servidor mediante ssh
> 
> ```bash
> ssh sysadmin@ipservidor
> ```
> 
> Para habilitar el grupo sudo se debe de ejecutar desde `/sbin/usermod`  o `su -` para poder usar el comado `usermod`

Verificar los usuarios que forman parte del grupo sudo

```bash
getent group sudo
```

## Creamos el usuario desarrollo

```bash
sudo adduser desarrollo
```

Creamos contraseña de para el usuario *desarrollo*

```bash
sudo passwd desarrollo
```

## Verificamos versión de S.O.

```bash
cat /etc/*-release
```

## Actualizamos el S.O.

Verificar paquetes de actualizacion y actualizar al sistema

```bash
sudo apt update
sudo apt dist-upgrade -y
```

## Instalar paquetes adicionales

net-tools y DNS bind9utils

```bash
sudo apt install -y net-tools bind9utils vim git| Puertos abiertos
```

```bash
  sudo netstat -nputa | grep :53
```

### Revisar configuración de Red

```bash
ip addr show
```

## Revisamos Servicios

```bash
service --status-all
```
