Guía de:

# Configuracion FirewallD

## ACERCA DE:

Versión: 1.0.0

Nivel: Avanzado

Área: C.P.D.

Elaborado por: Edmundo Céspedes Ayllón

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---

## Instalar y habilitar firewalld

`firewalld` está instalado por defecto en algunas distribuciones de Linux, instalacion de forma manual

```bash
sudo dnf install firewalld
```

se nabilita y se inicia el servicio para que arranque con el sistema opertivo

abilitancion del servicio

```bash
sudo systemctl enable firewalld
```

inicio del servicio

```bash
sudo systemctl start firewalld
```

## Verificaion del estado de firewalld

```bash
sudo firewall-cmd --state
```

```shell-session
Output
running
```

## Reglas actuales del firewall

### Explorar zonas predeterminadas

#### Ver zona predeterminada

```bash
firewall-cmd --get-default-zone
```

```shell-session
Output
public
```

#### Verificando zona predetrminada

```bash
  firewall-cmd --get-active-zones
```

```shell-session
Output
public
  interfaces: eth0 eth1
```

#### Reglas de la zona predeterminada

```bash
sudo firewall-cmd --list-all
```

```shell-session
Output
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: eth0 eth1
  sources:
  services: cockpit dhcpv6-client ssh
  ports:
  protocols:
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:
```

### Explorar zonas alternativas

#### Listar zonas disponibles

```bash
firewall-cmd --get-zones
```

```shell-session
block dmz drop external home internal nm-shared public trusted work
```

zonas predefinidas de `firewalld` ordenadas de la **menos confiable** a la **más confiable**:

- **drop**: tiene el menor nivel de confianza. Todas las 
  conexiones entrantes se descartan sin respuesta y solo se permiten 
  conexiones salientes.
- **block**: es similar a la anterior, pero en lugar de 
  simplemente descartar las conexiones, las solicitudes entrantes se 
  rechazan con un mensaje `icmp-host-prohibited` o `icmp6-adm-prohibited`.
- **public**: representa redes públicas que no son de 
  confianza. No se confía en otras computadoras, pero puede permitir 
  ciertas conexiones entrantes según cada caso individual.
- **external**: redes externas, en caso de que esté 
  usando el firewall como puerta de enlace. Está configurada para 
  enmascaramiento de NAT para que su red interna permanezca privada, pero 
  sea accesible.
- **internal**: el otro lado de la zona externa; se usa 
  para la parte interna de una puerta de enlace. Las computadoras son 
  bastante confiables y hay algunos servicios adicionales disponibles.
- **dmz**: se utiliza para computadoras ubicadas en una 
  red perimetral (equipos aislados que no tendrán acceso al resto de su 
  red).  Solo se permiten ciertas conexiones entrantes.
- **work**: se utiliza para las máquinas de trabajo. Se 
  confía en la mayoría de las computadoras de la red. Se pueden permitir 
  algunos servicios más.
- **home**: un entorno doméstico. En general, implica que
   se confía en la mayoría de las otras computadoras y que se aceptarán 
  algunos servicios más.
- **trusted**: se confía en todas las máquinas de la red. Es la más abiertade las opciones disponibles y debe usarse con moderación.

#### Ver la configuración específica asociada con una zona

```bash
sudo firewall-cmd --zone=home --list-all
```

```shell-session
Output
home
  target: default
  icmp-block-inversion: no
  interfaces:
  sources:
  services: cockpit dhcpv6-client mdns samba-client ssh
  ports:
  protocols:
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:

```

#### Ver la configuración específica asociada a todas las zona

```bash
sudo firewall-cmd --list-all-zones | less
```

> **Nota.-** paginado con `less`

## Seleccionar zonas para las interfaces

### Cambiar la zona de una interfaz

```bash
sudo firewall-cmd --zone=home --change-interface=eth0
```

> **Nota.-** Al desplazar una interfaz a una zona nueva, tenga en cuenta que probablemente modifique los servicios que funcionarán. Por ejemplo, en este caso nos desplazamos a la zona home, que tiene SSH habilitado. Esto quiere decir que nuestra conexión no debería descartarse. No todas las zonas tienen SSH habilitado de forma predeterminada, y el cambio a una de estas zonas podría causar que la conexión se descarte, lo que le impediría volver a iniciar sesión en su servidor.

se puede verificar el despalzamiento con el comando

```bash
firewall-cmd --get-active-zones
```

```shell-session
Output
home
  interfaces: eth0
public
  interfaces: eth1
```

## Ajustar la zona predeterminada

Si todas las interfaces se pueden gestionar por una sola interface se elige predeterminar una sola zona

```bash
sudo firewall-cmd --set-default-zone=home
```

## Establecer reglas para sus aplicaciones

Manera básica de definir excepciones de firewall para los servicios que desee que estén disponibles.

### Agregar un servicio a sus zonas

#### Lista de las definiciones de servicio disponibles

```bash
firewall-cmd --get-services
```

```shell-session
Output
RH-Satellite-6 RH-Satellite-6-capsule amanda-client amanda-k5-client amqp amqps apcupsd audit bacula bacula-client bb bgp bitcoin bitcoin-rpc bitcoin-testnet bitcoin-testnet-rpc bittorrent-lsd ceph ceph-mon cfengine cockpit collectd condor-collector ctdb dhcp dhcpv6 dhcpv6-client distcc dns dns-over-tls docker-registry docker-swarm dropbox-lansync elasticsearch etcd-client etcd-server finger foreman foreman-proxy freeipa-4 freeipa-ldap freeipa-ldaps freeipa-replication freeipa-trust ftp galera ganglia-client ganglia-master git grafana gre high-availability http https imap imaps ipp ipp-client ipsec irc ircs iscsi-target isns jenkins kadmin kdeconnect kerberos kibana klogin kpasswd kprop kshell kube-apiserver ldap ldaps libvirt libvirt-tls lightning-network llmnr managesieve matrix mdns memcache minidlna mongodb mosh mountd mqtt mqtt-tls ms-wbt mssql murmur mysql nbd nfs nfs3 nmea-0183 nrpe ntp nut openvpn ovirt-imageio ovirt-storageconsole ovirt-vmconsole plex pmcd pmproxy pmwebapi pmwebapis pop3 pop3s postgresql privoxy prometheus proxy-dhcp ptp pulseaudio puppetmaster quassel radius rdp redis redis-sentinel rpc-bind rquotad rsh rsyncd rtsp salt-master samba samba-client samba-dc sane sip sips slp smtp smtp-submission smtps snmp snmptrap spideroak-lansync spotify-sync squid ssdp ssh steam-streaming svdrp svn syncthing syncthing-gui synergy syslog syslog-tls telnet tentacle tftp tftp-client tile38 tinc tor-socks transmission-client upnp-client vdsm vnc-server wbem-http wbem-https wsman wsmans xdmcp xmpp-bosh xmpp-client xmpp-local xmpp-server zabbix-agent zabbix-server
```

> **Nota.-** Obtener más información sobre cada uno de estos servicios consultando su archivo `.xml` asociado en el directorio `/usr/lib/firewalld/services`.

#### Habilitar un servicio para una zona

```bash
sudo firewall-cmd --zone=public --add-service=http
```

Verificar la operacion realizada

```bash
 sudo firewall-cmd --zone=public --list-services
```

> **Nota.-** para volver la regla en permanate se usa el idicador `--permanent` y para adicionar las reglas actules vomo permanete se utiliza el idicador `--runtime-to-permanent`

verifiacar las reglas permanentes

```bash
sudo firewall-cmd --zone=public --list-services --permanent
```

### Habilitar un puerto por zonas

```bash
sudo firewall-cmd --zone=public --add-port=5000/tcp
```

Verificar la operacion ealizada

```bash
sudo firewall-cmd --zone=public --list-ports
```

### Habilitar intervalo de puertos por zonas

```bash
sudo firewall-cmd --zone=public --add-port=4990-4999/udp
```

### Definir un servicio

Un servicio es mas facl de administrar dado que es un cojunto de puertos, para este fin se debe de copiar `/usr/lib/firewalld/services`) al directorio `/etc/firewalld/services` donde el firewall busca definiciones no estándar.

```bash
sudo cp /usr/lib/firewalld/services/ssh.xml /etc/firewalld/services/example.xml
```

Editar la definicion del servicio

```bash
sudo vim /etc/firewalld/services/example.xml
```

```shell-session
<?xml version="1.0" encoding="utf-8"?>
<service>
  <short>SSH</short>
  <description>Secure Shell (SSH) is a protocol for logging into and executing commands on remote machines. It provides secure encrypted communications. If you plan on accessing your machine remotely via SSH over a firewalled interface, enable this option. You need the openssh-server package installed for this option to be useful.</description>
  <port protocol="tcp" port="22"/>
</service>
```

> **Nota.-** en las etiqueta:
> 
> <short> indiue el nombre del servicio.
> 
> <description> una descripcion del servicio.
> 
> <port> el protocolo y el puerto a ser habilitado, soporta varias etiquetas port.

Recargar el servico firewalld

```bash
sudo firewall-cmd --reload
```

Ya se puede utilizar como una definicion de servicio mas. 

## Crear Zonas

```bash
sudo firewall-cmd --permanent --new-zone=publicweb
```

Verificar que esten en la configuracion permanente

```bash
sudo firewall-cmd --permanent --get-zones
```

Volver a cargar en el firewall

```bash
sudo firewall-cmd --reload
```

ya se pueden asignar nuvos servicios y puertos a la nueva zona.



## Recarga  de configuracion de Firewalld

```bash
sudo firewall-cmd --reload
```

## 
