###################################################################################
GUIA DE CONFIGURACION RED EN SERVIDORES DEBIAN CORES

Versión 1.0
Nivel: Todos
Área: Data Center
Elaborado por Edmundo Cespedes
Tecnico Responsable Data Center, GAMS
Email: ed.cespedesa@gmail.com
###################################################################################
1.- Identificar la interfaz de Red
$ ifconfig
$ ifconfig -a
# ip -4 address

posible salida eth0

2.- Detenemos los servicion de gestopres de Red
# systemctl stop NetworkManager.service
# systemctl disable NetworkManager.service
o
$ sudo /etc/init.d/networking stop
o
# systemctl stop networking


2.-  Editar la configuracion ya sea con vi o nano.
$ sudo vi /etc/network/interfaces
3.- Nos encotraremos con un script similar al siguente
a.- Para dhcp
auto eth0
iface eth0 inet dhcp
b.- Para IP estatica
# Configurar IP estatica en eth0
auto eth0
iface eth0 inet static
address 192.168.1.110
gateway 192.168.1.1
netmask 255.255.255.0
network 192.168.1.0
broadcast 192.168.1.255

Nota: para configurar una segunda IP a una mistma interface de red se agrega lo siguiente.
auto eth0:1
iface eth0:1 inet static
address 192.168.1.60
netmask 255.255.255.0
network x.x.x.x
broadcast x.x.x.x
gateway x.x.x.x

VALIDO PARA AMBAS OPCIONES DE CONFIGURACION
4.- Configuramos los DNS editando el achivo /etc/resolv.conf
$ sudo vi /etc/resolv.conf
5.- Adicionamos los DNS que veamos convenientes
nameserver 10.50.50.130
nameserver 10.50.50.131


6.- Guardamos y reiniciamos el servicio.
# systemctl restart NetworkManager.service
# systemctl status NetworkManager.service
o
$ sudo /etc/init.d/networking restart
o
# systemctl restart networking
# systemctl status networking


7.- Verificamos el estado
$ ifconfig
o
# ip -4 address
y
# ip route 


