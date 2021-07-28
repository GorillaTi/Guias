Guía de:

# Instalación y Configuración DNS

## ACERCA DE:

Versión 1.0.1

Nivel: Medio

Área: CPD

Elaborado por: Edmundo Cespedes A.

Email: ed.cespedesa@gmail.com

---

1.- Obtener un `df -h` y un  `free -h` para guardar la información del estado de nuestro servidor.

```bash
df -h
```

```bash
free -h
```

2.- Actualizado nuestro servidor

```bash
apt upgrade && apt update
```

3.-  Instalar herramientas

NMAP (Opcional)

```bash
apt install nmap -y
```

Herramientas

```bash
apt install net-tool bind9-utils dnsutils
```

4.- Auditar servicios locales con NMAP

```bash
nmap localhost
```

5.- Validar versión del paquete Bind9

```bash
apt-cache policy bind9
```

6.- Instalar los paquetes de Bind9

```bash
apt install bind9 bind9utils bind9-doc -y
```

7.-Finalizada la instalación podemos comprobar que el servicio de DNS (proceso named) se ha iniciado

```bash
ps -ef | grep named
```

8.- Validar que el servicio de DNS esta a la escucha en los puertos 53 en los protocolos TCP y UDP
```bash
ss -ltun | grep :53
```

o

```bash
netstat -ltun | grep :53
netstat -nputa | grep :53
```

o

```bash
nmap localhost  
```

9.- Validar el status del servicio de Bind9
```bash
systemctl status bind9
```

10.- Habilitar el servicio de Bind9 para su inicialización automática

```bash
systemctl enable --now bind9
```

## Configurando Server de Cache y Recursivo

11.- Editar el fichero named.conf.options
Debian

```bash
nano /etc/bind/named.conf.options
```

CentOS
```bash
nano /etc/named.conf
```

12.- Habilitar la opción de redes permitidas, forwarders y otros

```config
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
};
```

y los que sean necesarios como los DNS RUAT 172.17.18.137 y 192.9.200.137

13.- Se procede a consignar la zona ejemplo.com

***NOTA*** 
en otra consola colocamos revisando los logs en: 

Debian

```bash
tail -f /var/log/syslog
```

CentOS
```bash
tail -f /var/named/data/named_stats.txt
```

o

```bash
tail -f /var/named/data/named_men_stats.txt
```

paginamos hasta que quede limpia la pantalla y reiniciamos el servicio bind9 

```bash
systemctl restart bind9
```

o 

```bash
/etc/init.d/bind9 restart
```

Observamos el proceso de reinicio de Bind9, entramos a una maquina donde tengamos configurado el DNS en ingresamos en el navegador y colocamos una dirección de una pagina web, veremos que nos cargué y en la consola se observara que se denegó el acceso a dicha pagina.

***Auditoria:***

Habilitar los logs:

```bash
log-queries: yes
log-replies: yes
```

## Configuración de DNS Autoritativo



## Configuración de DNS secundario



## TIPS

Recuerde que hay 3 comandos con los que podemos reiniciar los servicios, esto ya queda a decisión de usted que comando usan.

```bash
systemctl start|stop|restart bind9 		(named)
service bind9 start|stop|restart   		(named)
/etc/init.d/bind9 start|stop|restart   	(named)
```

Pruebas de servicio

```bash
host [nombre_dominio] [IP_dns]
```

```bash
dig [nombre_dominio] [IP_dns]
```

Segmento de redes locales

```config
192.168.0.0/16
10.0.0.0/8
172.16.0.0/12
```

TTL recomendadas

```config
180 		preparar para cambios
3600 a 7200 para produccion
```

