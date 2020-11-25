###################################################################################
GUIA DE INSTALACIOIN DNS

Versión 1.0
Nivel: Todos
Área: Data Center
Elaborado por Edmundo Cespedes
Tecnico Responsable Data Center, GAMS
Email: ed.cespedesa@gmail.com
###################################################################################
INSTALANDO BIND9 EM DEBIAN
1.- Obtener un df -h y un free -h para guardar la info de nuestro server
# df -h
# free -h
2.- Actualizado nuetro servidor
# apt upgrade
# apt update
3.-  Instalar NMAP
# apt install nmap -y

4.- Auditar ser con NMAP
# nmap localhost

5.- Validar version del paquete Bind9
# apt-cache policy bind9

6.- Instalar los paquetes de Bind9
# apt install bind9 bind9utils bind9-doc -y

7.-Finalizada la instalacion podemos comprobar que el servicio de DNS (proceso named) se ha iniciado
# ps -ef | grep named

8.- Validar que el servicio de DNS esta a la escucha en los puertos 53 en los protocolos TCP y UDP
# ss -ltun | grep :53
# netstat -ltun | grep :53
# nmap localhost  

9.- Validar el status del servicio de Bind9
# systemctl status bind9

10.- Habilitar el servicio de Bind9 para su reinicialiazacion automatica
# systemctl enable bind9

Configurando el Servicio DNS como Server de Cache y Recursivo
11.- Editar el fichero named.conf.options
(DEBIAN)
# nano /etc/bind/named.conf.options
(CENTOS)
# nano /etc/named.conf

12.- habilitar la opcion de redes pemitida forwarders y otros
acl nombre-lista{
    192.168.0.0/16
    10.0.0.0/8
    172.16.0.0/12    
};
options{
allow-query{nombre-lista;};
allow-recursive{nombre-lista;};
};
forwarders{
8.8.8.8;
8.8.4.4;
}
y los que sean necesarios como los DNS RUAT 172.17.18.137 y 192.9.200.137

13.- Se procede a consigura la zona ejemplo.com


***NOTA***
en otra consola colocamos:
revisando los logs en Debian
# tail -f /var/log/syslog
revisando los logs en Centos
# tail -f /var/named/data/named_stats.txt
# tail -f /var/named/data/named_men_stats.txt

paginamos hasta que quede limpia la pantalla y reinicuimoas el servicio bind9
# /etc/init.d/bind9 restart

observamos el proceso de reinicio de Bind9, entramos a una maquina donde tengamos configurado el DNS en ingresamos en ell navegador y colocamos una direccion de una pagina web, veremos que nos carge y el la consala se observara que se denego el acceso a dicha pagina

***TIPS***
Recuerde que hay 3 comandos con los que podemos reiniciar los servicios, esto ya queda a decisión de usted que comando usan.
#systemctl start|stop|restart bind9 (mamed)
#service bind9 start|stop|restart   (mamed)
#/etc/init.d/bind9 start|stop|restart   (mamed)

puebas de servicio
#host ejemplo.com 192.168.14.60
#dig ejemplo.com 192.168.14.60
redes locales
192.168.0.0/16
10.0.0.0/8
172.16.0.0/12




13.-
$ 
8.- 
#
#
