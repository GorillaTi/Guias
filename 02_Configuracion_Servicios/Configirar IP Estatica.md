Guía de:

# Configurar IP Estática

---

## ACERCA DE:

Versión: 1.0.2

Nivel: Medio

Área: CPD

Elaborado por: Edmundo Céspedes Ayllón

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---

## Ubuntu 18.04 - 20.04 - 22.04

Antes de nada recomiendo que estemos validados como root para poder hacer los cambios sin ningún problema, el comando es:

```bash
sudo -i
```

Identificamos la tarjeta red a configurar con el comando:

```bash
sudo ifconfig -a
```

**Nota.-**Comando ifconfig comando deprecado

```bash
ip a
```

información a ser mostrada

```shell-session
enp0s3: flags=4163 mtu 1500
inet 192.168.1.105 netmask 255.255.255.0 broadcast 192.168.1.255
inet6 fe80::a00:27ff:fef6:dda1 prefixlen 64 scopeid 0x20
ether 08:00:27:f6:dd:a1 txqueuelen 1000 (Ethernet)
RX packets 9289 bytes 13486720 (13.4 MB)
RX errors 0 dropped 0 overruns 0 frame 0
TX packets 4059 bytes 339851 (339.8 KB)
TX errors 0 dropped 0 overruns 0 carrier 0 collisions 0*

lo: flags=73 mtu 65536
inet 127.0.0.1 netmask 255.0.0.0
inet6 ::1 prefixlen 128 scopeid 0x10
loop txqueuelen 1000 (Local Loopback)
RX packets 118 bytes 9766 (9.7 KB)

RX errors 0 dropped 0 overruns 0 frame 0
TX packets 118 bytes 9766 (9.7 KB)
TX errors 0 dropped 0 overruns 0 carrier 0 collisions 0*
```

Esto nos dice que está usando la tarjeta enp0s3 y que la ip que tenemos actualmente es la 192.168.1.105

Para cambiarlo debemos editar el fichero **/etc/netplan/50-cloud-init.yaml** con el siguiente comando:

```bash
sudo vim /etc/netplan/50-cloud-init.yaml 
```

Como está configurado el DHCP nos encontraremos este fichero:

```shell-session
network:
ethernets:
    enp0s3:
        dhcp4: true
        version: 2
```

Debemos cambiarlo por este:

```shell-session
network:
    version: 2
renderer: networkd
ethernets:
    enp0s3:
        dhcp4: no
        dhcp6: no
        addresses: [192.168.1.200/24]
        gateway4: 192.168.1.1
        nameservers:
            addresses: [192.168.1.1,8.8.8.8]
```

Una vez guardados los cambios debemos ejecutar el siguiente comando para aplicar los cambios:

```bash
netplan apply
```

Volvemos a ejecutar ifconfig nos saldrá esto:

```shell-session
enp0s3: flags=4163 mtu 1500
inet **192.168.1.200** netmask 255.255.255.0 broadcast 192.168.1.255
inet6 fe80::a00:27ff:fef6:dda1 prefixlen 64 scopeid 0x20
ether 08:00:27:f6:dd:a1 txqueuelen 1000 (Ethernet)
RX packets 12412 bytes 13736814 (13.7 MB)
RX errors 0 dropped 1 overruns 0 frame 0
TX packets 6016 bytes 612586 (612.5 KB)
TX errors 0 dropped 0 overruns 0 carrier 0 collisions 0

lo: flags=73 mtu 65536
inet 127.0.0.1 netmask 255.0.0.0
inet6 ::1 prefixlen 128 scopeid 0x10
loop txqueuelen 1000 (Local Loopback)
RX packets 118 bytes 9766 (9.7 KB)
RX errors 0 dropped 0 overruns 0 frame 0
TX packets 118 bytes 9766 (9.7 KB)
TX errors 0 dropped 0 overruns 0 carrier 0 collisions 0
```

## RHEL - CentOS - Alma Linux - Rocky

### Identificar la interfaz de Red

```bash
ip add
```

Posible salida enp0s3

### Mediante Edición del Archivo de Configuración

Deshabilitar otros gestores de red

```bash
systemctl stop NetworkManager
```

```bash
systemctl disable NetworkManager
```

Dirigirse al directorio donde se encuentra los archivos de configuración de red

```bash
cd /etc/sysconfig/network-scripts/
```

Listamos los archivos para ubicar la tarjeta de red.

```bash
ls -lha
```

Ubicada el archivo  de configuración de la tarjeta de red y procedemos a editarla.

```bash
sudo vim ifcfg-enp0s3
```

```shell-session
Nos encotraremos con un script similar al siguente, se debe de editar los campos que se encuentran marcados con * (BORAR * para que funcione el script).
TYPE=Ethernet
*BOOTPROTO=static #(static (ip estaticas) o dhcp)
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
*IPV6INIT=no
*IPV6_AUTOCONF=no
IPV6_DEFROUTE=
IPV6_FAILURE_FATAL=no
*NAME="Nombre Conexion"
UUID= #(La UUID de nuestra tarjeta de red, este número saldrá diferente diferente asignado por el sistema)
*DEVICE=enp0s3 #(nuestro dispositivo encontrado anteriormente en ip add)
*ONBOOT=yes #(si se activara al inicio del sistema)
*IPADDR0=192.168.1.150 #(La IP que queramos)
*PREFIX= 255.255.255.0 #(mascara de red 25.255.255.0 o 24)
*GATEWAY0=192.168.1.1 #(Nuestra puerta de enlace)
*DNS1=8.8.8.8 #(La dirección DNS de Google o la que queramos)
*DNS2=192.168.14.60 #(segundo DNS) 
PEERDNS=yes
PEERROUTES=yes
IPV6_PEERDNS=yes
IPV6_PEERROUTES=yes
```

### Gestor de Red mntui

Ejecutamos la herramienta de configuración de red

```bash
sudo nmtui
```

En el entorno visual usando los cursores se navega en ella, realizamos los cambios necesarios.

Modificar conexion

Una vez realizados los cambios procedemos a salir
Salir y enter 

Aceptar y enter

Verificamos las modificaciones realizadas

```bash
cat /etc/sysconfig/network-scripts/ifcfg-enp0s3 $ cat /etc/resolv.conf
```

### Valido para Ambas Configuraciones

Guardamos y reiniciamos el servicio.

```bash
systemctl restart network.service
```

```bash
systemctl enable NetworkManager
```

```bash
systemctl restart NetworkManager
```

Verificamos el estado

```bash
ip add
```

```bash
ping www.google.com
```

## Debian

Identificar la interfaz de Red

```bash
ifconfig
```

```bash
ifconfig -a
```

o

```bash
ip a
```

```bash
ip add
```

```bash
ip -4 address
```

Detenemos los servicion de gestopres de Red

```bash
systemctl stop NetworkManager.service
```

```bash
systemctl disable NetworkManager.service
```

o

```bash
sudo /etc/init.d/networking stop
```

o

```bash
systemctl stop networking
```

Editar la configuración.

```bas
sudo vim /etc/network/interfaces
```

Encontraremos con un script similar al siguiente

- Para dhcp

```shell-session
auto eth0
iface eth0 inet dhcp
```

- Para IP estática

Configurar IP estática en eth0

```shell-session
auto eth0
iface eth0 inet static
address 192.168.1.110
ipagateway 192.168.1.1
netmask 255.255.255.0
network 192.168.1.0
broadcast 192.168.1.255
```

o

```bash
cat /etc/network/interfaces
```

```shell-session
#This file describes the network interfaces available on your system
#and how to activate them. For more information, see interfaces(5).
#source /etc/network/interfaces.d/*
#The loopback network interface
auto lo
iface lo inet loopback
#The primary network interface
allow-hotplug ens18
iface ens18 inet static
    address 192.168.14.95/24
    gateway 192.168.14.10
    #dns-* options are implemented by the resolvconf package, if installed
​    dns-nameservers 192.168.14.60 192.168.14.61
​    dns-search sucre.bo
```

> **Nota.-** para configurar una segunda IP a una misma interface de red se agrega lo siguiente.

```shell-session
auto eth0:1
iface eth0:1 inet static
    address 192.168.1.60
    netmask 255.255.255.0
    network x.x.x.x
    broadcast x.x.x.x
    gateway x.x.x.x
```

### Valido para Ambas Opciones de Configuración

Reiniciamos el servicio.

```bash
sudo systemctl restart NetworkManager.service
```

```bash
systemctl status NetworkManager.service
```

o

```bash
sudo /etc/init.d/networking restart
```

o

```bash
sudo systemctl restart networking
```

```bash
sudo systemctl status networking
```

Verificamos el estado

```bash
ifconfig
```

o

```bash
ip -4 address
```

y

```bas
ip route
```

## Manejo de Interfaces

### Detener la interfaz de red eth0:

```bash
sudo ifdown eth0
```

```bash
sudo ifconfig eth0 down
```

### Iniciar la interfaz de red eth0:

```bash
sudo ifup eth0
```

```bash
sudo ifconfig eth0 up
```

Esto no debe ser confundido con el siguiente comando, que **reinicia todos los servicios de red**:

```bash
/etc/init.d/networking restart
```

```bash
systemctl restart network.service
```

```bash
systemctl enable NetworkManager
```

Para conocer las **diversas interfaces de red**, utiliza el comando:

```bash
/sbin/ifconfig –a
```

o 

```bash
ip a
```

### Limpiar cache de configuración de las interfaces

```bash
bash ip addr flush dev enp2s0
```

### Configurar interfaces por:

#### Comando

```bash
ifconfig eth0 172.19.20.186 netmask 255.255.255.252 up
```

### Archivo de configuracion

```shell-session
auto eth0 eth1

iface eth0 inet static
  address 172.19.20.186
  netmask 255.255.255.252

iface eth1 inet static
  address 172.18.182.55
  netmask 255.255.254.0
  gateway 172.18.182.1
```

### Configuración de rutas por:

#### Comando

Ruta por default

```bash
sudo route add default gw 172.18.182.1
```

ruta estatica

```bash
sudo route add -net 172.19.26.0/23 gw 172.19.20.185 dev eth0
```

#### Archivo de Configuracion

```shell-session
up route add -net 172.19.26.0/23 gw 172.19.20.185 dev eth0
up route add -net 172.19.24.0/23 gw 172.19.20.185 dev eth0
```
