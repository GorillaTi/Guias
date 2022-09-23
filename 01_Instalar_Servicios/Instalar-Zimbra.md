Guía de :

# Instalación de Zimbra OSE

Versión 1.1.2

Nivel: Avanzado

Área: CPD

Elaborado por: Edmundo Céspedes Ayllón

e-mail: ed.cespedesa@gmail.com

---

## Particionamiento  Recomendado del O.S.

### Simple

Este particionamiento es el más simple  para ello tendremos la siguiente configuración:

| P.M.  | Tipo     | Formato | Min    | Obs.                                |
|:-----:|:--------:|:-------:|:------:|:-----------------------------------:|
| /boot | primaria | xfs     | 1 GB   |                                     |
| swap  | LVM      | xfs     | 2 GB   |                                     |
| /opt  | LVM      | xfs     | 100 GB | Dependiendo del numero de usuarios. |
| /     | LVM      | xfs     | 20 GB  |                                     |

Nota: con 200 MB por usuario como mínimo tomando en cuanta la calidad de servició (COS).  

### Avanzado

Para evitar problemas de llenado en el directorio /var/log deberemos realizar un swaoparticionamiento  como el siguiente:

| P.M.  | Tipo     | Formato | Min    | Obs.                                |
|:-----:|:--------:|:-------:|:------:|:-----------------------------------:|
| /boot | primaria | xfs     | 1 GB   |                                     |
| swap  | LVM      | xfs     | 2 GB   |                                     |
| /var  | LVM      | xfs     | 15 GB  |                                     |
| /opt  | LVM      | xfs     | 100 GB | Dependiendo del numero de usuarios. |
| /     | LVM      | xfs     | 20 GB  |                                     |

Nota: con 200 MB por usuario como mínimo tomando en cuanta la calidad de servició (COS).  

### Particionamiento recomendado avanzado y Backup

Zimbra Collaboration Network Edition almacena sus backups a  la ruta `/opt/zimbra/backup` es por ello  recomiendo el siguiente  particionamiento para evitar este problema:

| P.M.    | Tipo     | Formato | Min    | Obs.                                |
|:-------:|:--------:|:-------:|:------:|:-----------------------------------:|
| /boot   | primaria | xfs     | 1 GB   |                                     |
| swap    | LVM      | xfs     | 2 GB   |                                     |
| /var    | LVM      | xfs     | 15 GB  |                                     |
| /opt    | LVM      | xfs     | 100 GB | Dependiendo del numero de usuarios. |
| /backup | LVM      | xfs     | 200 GB | Con BackUps diarios                 |
| /       | LVM      | xfs     | 20 GB  |                                     |

Nota: con 200 MB por usuario como mínimo tomando en cuanta la calidad de servició (COS).

Otra opción es mantener el directorio `/bauckup` dentro de la partición  `/opt` y mover su contenido a un almacenamiento de red o externo (NAS) 

### Calculo recomendado para la partición /OPT

Calculo con una cantidad de 500 usuarios con una capacidad de 200 MB de almacenamiento por cada uno 

```
Datos  x Usuario: 500 usuarios x 200 MB = 100 GB de Datos

Datos en MySQL: 5%  de 100 GB de Datos = 5 GB

Binarios de Zimbra: 10 GB

Logs de Zimbra: 20 GB

Indexación de Zimbra: 25% de  100 GB de Datos = 25 GB 

Subtotal: 100 + 5 + 10 + 20 + 25 = 160 GB

Backup: 160% del Subtotal 160 GB = 256 GB

Total: 160 GB + 256 GB = 416 GB
```

## Configuración y/o Instalación de DNS

### DNS Interno (dnsmasq)

Resolución de dominio en el mismo servidor donde se instalara el servidor ZIMBRA. 

Instalando dnsmasq

```bash
sudo apt install dnsmask
```

configuramos el servicio

```bash
sudo vim /etc/dnsmasq.conf
```

e introducimos la siguientes líneas

```shell-session
server=[dns_server]
listen-address=127.0.0.1
domain=[url_dominio]
mx-host=[url_dominio],[url_mail_server],0
address=/[url_mail_server]/[ip_server_mail]
```

reiniciamos el servicio

```bash
service dnsmasq restart
```

### DNS Externo

Configuración en DNS de zona.

Revisamos el archivo de configuración del DNS

```bash
sudo vim /etc/bind/named.conf.options 
```

Comprobamos que que se encuentren habilitadas las siguientes configuraciones

```shell-session
options{
    directory "var/cache/bind";
    listen-on { any; };
    allow-query { any; };
    //allow-recursion { none; };
    forwarders{
        8.8.8.8;
        8.8.4.4;
    };
};
```

Configuramos el el archivo de registro de zona

```bash
sudo vim /etc/bind/zona/dn.[dominio].test
```

Insertamos los siguientes registros 

```shell-session
@                               IN      MX      1       mail
mail                            IN      A       [ip_server]
webmail                         IN      A       [ip_server]
```

Reiniciamos el servicio de DNS

```bash
sudo systemctl restart bind9
```

## Configurando la resolución de dominio

Deshabilitando el servicio (opcional). 

```bash
sudo systemctl disable systemd-resolved.service
```

Verificando que es un enlace simbólico

```bash
ls -lh /etc/resolv.conf
```

Nos mostrara algo similar a esta salida

```shell-session
/etc/resolv.conf -> ../run/systemd/resolve/stub-resolv.conf
```

Removiendo el link simbólico

```bash
rm -f /etc/resolv.conf
```

Creando el Nuevo link simbólico

```bash
sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf 
```

Editamos el archivo `resolv.conf`.

- Para dnsmasq

```bash
echo "nameserver 127.0.0.1 > resolv.conf
```

- Para dns externo

```bash
echo "nameserver [ip.servidor.dns] >> resolv.conf
```

### Pruebas de Funcionamiento de DNS

Probamos la resolución con dig y mx

```shell-session
dig mx [dominio]

; <<>> DiG 9.11.3-1ubuntu1.9-Ubuntu <<>> mx [dominio]
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 8778
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;[dominio].              IN      MX

;; ANSWER SECTION:
[dominio].       0       IN      MX      0 [fqdm.dominio].

;; Query time: 0 msec
;; SERVER: [ip.server.dns]#53(ip.server.dns)
;; WHEN: Thu Jul 19 00:04:38 UTC 2022
;; MSG SIZE  rcvd: 65<code></code>
```

Probamos la resolución con dig y a

```shell-session
dig [fqdm.dominio]

; <<>> DiG 9.11.3-1ubuntu1.9-Ubuntu <<>> [fqdm.dominio]
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 48780
;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;[fqdm.dominio].          IN      A

;; ANSWER SECTION:
[fqdm.dominio].   0       IN      A       [ip.serv.mail]

;; Query time: 0 msec
;; SERVER: [ip.server.dns]#53(ip.server.dns)
;; WHEN: Thu Jul 19 00:04:31 UTC 2022
;; MSG SIZE  rcvd: 65<code></code>
```

### Configurando nombre del Hostname y Hosts

#### Manual

Editar archivo `hostname`

```bash
sudo vim /etc/hostname
```

Definimos el FQDN del servidor

```shell-session
[fqdn.servidor]
```

Editamos el archivo  `hosts`

```bash
sudo vim /etc/hosts
```

Definimos los siguientes parámetros

```shell-session
127.0.0.1 localhost
[ip.servidor]    [fqdn] [hostname]
```

### Por Comando

Ver información del hostname

```bash
hostnamectl
```

Configuramos los cambios del hostname

```bash
hostnamectl set-hostname geeksforgeeks --static
```

Reiniciamos el Servidor

```bash
sudo reboot
```

### ## Instalando Zimbra Collaboration OSE

Creamos el directorio

```bash
mkdir /tmp/zcs
```

Ingresamos al directorio creado

```bash
cd /tmp/zcs
```

Descargamos Zimbra 9 de: 

### Zextras

Para Ubuntu 18.x

```bash
wget http://download.zextras.com/zcs-9.0.0_OSE_UBUNTU18_latest-zextras.tgz
```

### Zimbra

- Par Ubuntu 18.x

```bash
wget https://files.zimbra.com/downloads/8.8.15_GA/zcs-8.8.15_GA_3869.UBUNTU18_64.20190918004220.tgz
```

- Para Ubuntu 20.4

```bash
wget https://files.zimbra.com/downloads/8.8.15_GA/zcs-8.8.15_GA_4179.UBUNTU20_64.20211118033954.tgz
```

Para descarga actualizada y par otros sistemas operativos se realizad de [Zimbra Collaboration OSE](https://www.zimbra.com/downloads/zimbra-collaboration-open-source/)

### Descomprimimos el paquete descargado

```bash
tar -xzvf zcs-9.0.0_OSE_UBUNTU18_latest-zextras.tgz
```

Nos ubicamos en el directorio generado 

```bash
cd zimbra-installer/
```

ejecutamos

```bash
./install.sh
```

Seguimos los siguientes pasos:

```shell-session
Do you agree with the terms of the software license agreement? [N]  y
Use Zimbra's package repository [Y]

Select the packages to install
Install zimbra-ldap [Y]
Install zimbra-logger [Y]
Install zimbra-mta [Y]
Install zimbra-dnscache [Y] n
Install zimbra-snmp [Y]
Install zimbra-store [Y]
Install zimbra-apache [Y]
Install zimbra-spell [Y]
Install zimbra-memcached [Y]
Install zimbra-proxy [Y]
Install zimbra-drive [Y] n --desfasado NO INSTALAR
Install zimbra-imapd (BETA - for evaluation only) [N] n
Install zimbra-chat [Y] n (opcional)

The system will be modified.  Continue? [N] y
```

Mostrara un erro es normal, debemos de especificar nuestro dominio

```shell-session
DNS ERROR resolving MX for mail.[nuestro_dominio]
It is suggested that the domain name have an MX record configured in DNS
Change domain name? [Yes] Y
Create domain: [mail.[nuestro_dominio]] [nuestro_dominio]
```

Finalizado el proceso de instalación configuramos la contraseña de `admin`

```shell-session
Address unconfigured (**) items  (? - help) 6
Select, or 'r' for previous menu [r] 4
Password for admin@ntw.nat.cu (min 6 characters): [_Hx3qcO9] [nuevo_pass]
Select, or 'r' for previous menu [r] r
```

Paso final

```She
*** CONFIGURATION COMPLETE - press 'a' to apply
Select from menu, or press 'a' to apply config (? - help) a
Save configuration data to a file? [Yes]
Save config in file: [/opt/zimbra/config.13953]
The system will be modified - continue? [No] yes

Notify Zimbra of your installation? [Yes] n
Configuration complete - press return to exit
```

Probamos el funcionamiento del servidor

Usuario normal

```url
https://mail.[nuestro_dominio]
```

Usuario administrador

```url
https://mail.[nuestro_dominio]:7071/zimbraAdmin
```

Probando el servicio

Verificando versión de instalación

```bash
$ sudo su - zimbra -c "zmcontrol -v"
```

Verificando el estado de los servicios

```bash
sudo su - zimbra -c "zmcontrol status"
```

## Certificado SSL

Instalar certbot

[Manual de instalación de Certbot](/Guias/01_Instalar_Servicios/Instalar-Certbot.md)

Generacional del certificado SSL

```bash
sudo certbot certonly --standalone --agree-tos --staple-ocsp --email admin@[mi_dominio] -d mail.[mi_dominio] -d webmail.[mi_dominio] --preferred-chain 'ISRG Root X1'
```

Instalar acl

```bash
sudo apt install acl
```

Asignacion de permisos

```bash
sudo setfacl -R -m u:zimbra:rwx /etc/letsencrypt/
```

Cambiamos al usuario zimbra

```bash
sudo su - zimbra
```

Copia de llaves generadas

```bash
cp /etc/letsencrypt/live/mail.[mi_diminio]/privkey.pem /opt/zimbra/ssl/zimbra/commercial/commercial.key
```

Descargamos el Root X1

```bash
wget -O /tmp/isrgrootx1.pem https://letsencrypt.org/certs/isrgrootx1.pem.txt
```

Combinamos los dos archivos

```bash
cat /etc/letsencrypt/live/mail.[mi_dominio]/chain.pem /tmp/isrgrootx1.pem > /opt/zimbra/ssl/zimbra/commercial/commercial_ca.crt
```

Desplegamos el certificado

```bash
/opt/zimbra/bin/zmcertmgr deploycrt comm /etc/letsencrypt/live/mail.ntw.nat.cu/cert.pem /opt/zimbra/ssl/zimbra/commercial/commercial_ca.crt
```

Verificacion del estado del certificado

```bash
/opt/zimbra/bin/zmcertmgr viewdeployedcrt
```

Reiniciamos los servicio Zimbra

```bash
zmcontrol restart
```

Salimos del usuario zimbra con `exit` o `ctrl+d`

## Configuración de mynetworks

Ejecutamos

```bash
postconf mynetworks
```

El archivo `mynetworks` solo debe contener la dirección local, tanto para IPv4 y/o IPv6 y la red a la cual pertenece al servidor Zimbra, por ejemplo:

Si la IP de nuestro servidor Zimbra es 192.168.1.100/24 entonces mynetworks debería contener

```shell-session
mynetworks = 127.0.0.0/8 [::1]/128 192.168.1.0/24.
```

## Configuraciones de Seguridad

### Suplantación de identidad

Ejecutamos el siguiente comando

```bash
sudo su - zimbra -c "zmprov mcf zimbraMtaSmtpdSenderLoginMaps proxy:ldap:/opt/zimbra/conf/ldap-slm.cf +zimbraMtaSmtpdSenderRestrictions reject_authenticated_sender_login_mismatch"### Esto evitara que  
```

Esto evitara que usuarios autenticados en el servidor no puedan enviar correos  a nombre de otros.

Editamos el archivo `smtpd_sender_restrictions.cf `

```bash
sudo vim /opt/zimbra/conf/zmconfigd/smtpd_sender_restrictions.cf
```

Insertamos en el mismo la siguiente linea

```shell-session
permit_mynetworks, reject_sender_login_mismatch
```

### Envío de correo sin autentificación o usuarios inexistentes

Ejecutamos los siguientes comandos

```bash
zmprov mcf zimbraMtaSmtpdRejectUnlistedRecipient yes
```

```bash
zmprov mcf zimbraMtaSmtpdRejectUnlistedSender yes
```

```bash
zmmtactl restart
```

```bash
zmconfigdctl restart
```

# 
