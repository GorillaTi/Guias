############################################################################
# # ####
GUIA DE CONFIGURACION RED EN SERVIDORES CENTOS CORES

Versión 1.0
Nivel: Todos
Área: Data Center
Elaborado por Edmundo Cespedes
Tecnico Responsable Data Center, GAMS
Email: ed.cespedesa@gmail.com
###################################################################################
1.- Identificar la interfaz de Red
# ip add
posible salida enp0s3

A.- CONFIGURACION MEDIANTE EDICION DE EL ARCHIVO DE CONFIGURACION

2.- Deshabilitar otros gestores de red
# systemctl stop NetworkManager
# systemctl disable NetworkManager

3.- Dirigirse a la carpeta donde se encuentra los archivos de configuracion de red 
# cd /etc/sysconfig/network-scripts/

3.- Listamos los archivos para ubicar la targeta de red.
# ls

4.-  Ubicada la targeta de red procedemos a editarla ya sea con vi o nano.
# vi ifcfg-enp0s3

5.- Nos encotraremos con un script similar al siguente, se debe de editar los campos que se encuentran marcados con * (BORAR * para que funcione el script).
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

B.- CONFIGURACION USANDO GESTOR DE RED NMTUI
2.- ejecutamos la herramienta de configuracion de red
$ sudo nmtui
# nmtui
3.- En el entorno visual usando los cursores se navega en ella, realizamos los cambios necesarios.
> Modificar conexion
4.- Una vez realizados los cambios procedemos a salir
> Salir y enter, Aceptar y enter
5.- Verificamos las modificaciones realizadas
$ cat /etc/sysconfig/network-scripts/ifcfg-enp0s3
$ cat /etc/resolv.conf

VALIDO PARA AMBAS OPCIONES DE CONFIGURACION
6.- Guardamos y reiniciamos el servicio.
a.- # systemctl restart network.service
b.- # systemctl enable NetworkManager
    # systemctl restart NetworkManager
7.- Verificamos el estado
# ip add
# ping www.google.com
