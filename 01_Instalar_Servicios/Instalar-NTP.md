Guía de :

# Servidor NTP

## ACERCA DE:

Versión: 1.0.1

Nivel: Medio

Área: CPD

Elaborado por: Edmundo Céspedes Ayllón

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---

## Instalación del Servidor NTP

1. Instalando paquetes
- Debian

```bash
sudo apt install ntp ntpstat ntp-doc -y
```

- CentOS - Alma Linux

```bash
sudo dnf install ntp -y (chrony)
```

**NOTA.-** a partir de la versión 7 de CentOS el paquete NTP pasa a ser CHRONY

2. Verificamos la Instalación NTP
- Debian

```bash
sudo dpkg -l ntp
```

- CentOS - Alma Linux

```bash
sudo rpm -q chrony
```

## Configuración Servidor NTP

Archivo de configuración

- Debian

```bash
sudo nano /etc/ntp.conf 
```

- CentOS - Alma Linux

```bash
sudo nano /etc/chrony.conf
```

Insertamos en la configuración

```conf
server horaoficial.ibmetro.gob.bo iburst
server [ip_servidor] iburst
```

Deshabilitar el pool de servidores de hora e introducimos las políticas de seguridad de los clientes a cual servirá la hora.

```config
restrict 192.168.0.0 mask 255.255.0.0 nomodify notrap
restrict 10.0.0.0 mask 255.0.0.0 nomodify notrap
restrict 172.16.0.0 mask 255.240.0.0 nomodify notrap
```

Reiniciando el servicio NTP

```bash
sudo systemctl restart ntp 
```

Revisando la sincronía

```bash
sudo ntpq -p
```

## Configuración  Cliente NTP

Instalando el servicio SNTP

- Debian

```bash
sudo apt install sntp ntpdate
```

**Nota.-** el paquete ntpdate esta deprecado en su reemplazo se utiliza sntp.

- CentOS

```bash
sudo dnf install ntp -y (chrony)
```

Verificamos la Instalación NTP

- Debian

```bash
sudo dpkg -l sntp ntpdate
```

- CentOS

```bash
sudo rpm -q ntp
```

Probamos si tenemos conexión con el servidor NTP

```bash
ping [hora.tu_dominio] -c 3
```

Actualizamos el servidor sntp 

```bash
sudo sntp [hora.tu_dominio] o [ip_servidor]
```

o

```
sudo ntpdate [hora.tu_dominio] o [ip_servidor]
```

## Configuración por comando

Comprobando la fecha y hora

```bash
$ date
```

Resultado

```output
Mon Oct 12 09:43:36 BOT 2020
```

Listamos zonas horarias

```bash
$ timedatectl list-timezones
```

Ahora podemos configurar la `zona horaria` usando el comando siguiente:

```bash
$ timedatectl set-timezone
$ sudo timedatectl set-timezone America/La_Paz
```

Estableciendo la `hora y fecha`

```bash
$ date  --set "2020-10-12 12:44:00"    
```

## Prueba de servicio

Ejecutar el comando

```bash
ntpdate -q [fqdn o ip_host]
```

## Recursos

[Probar NTP en linux, ver zona horaria | Bajo Bits](https://bajobits.wordpress.com/2012/07/30/probar-ntp-en-linux/)

[Capítulo 11. Uso de la suite Chrony para configurar NTP Red Hat Enterprise Linux 8 | Red Hat Customer Portal](https://access.redhat.com/documentation/es-es/red_hat_enterprise_linux/8/html/configuring_basic_system_settings/using-chrony-to-configure-ntp)

[Configuración y uso de NTP. - Alcance Libre](https://blog.alcancelibre.org/staticpages/index.php/como-ntp)