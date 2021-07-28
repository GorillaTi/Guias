Guía de:

# Instalación de Zabbix

## ACERCA DE:
Versión: 1.0.2

Nivel: Todos

Área: CPD

Elaborado por: Edmundo Cespedes Ayllon

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---

Instalamos conforme las instrucciones oficiales con todo en local.

### Instalación de base de datos en MySQL en remoto

Ingresamos al gestor de base de datos ya sea en local o en remoto y ejecutamos los siguientes comandos

* ingresamos a la gestor de base de datos

  ```bash
  mysql -uroot -p
  ```

* Creamos la base de datos

  ```mysql
  create database zabbix character set utf8 collate utf8_bin;
  ````

* creamos el usuario y le damos todos los permisos hacia la DB

  ```mysql
  create user zabbix@% identified by 'password';
  grant all privileges on zabbix.* to zabbix@localhost;
  ```

Copiamos y descomprimimos el contenido del archivo

```bash
cp -vpfv /usr/share/doc/zabbix-server-mysql*/create.sql.gz
```

```bash
gzip create.sql.gz
```

ejecutamos el script SQL en create.sql

Una vez terminado el proceso de instalación   acedemos a

```url
http://server_ip_or_name/zabbix
```

Seguimos el manual para conectarnos y terminar las configuraciones.

## Instalación de Zabbix-Agent

### Debian

Instalando el agente 

```bash
sudo apt install zabbix-agent
```

Comprobamos el estado del agente

```bash
sudo systemctl status zabbix-agent.service
```

Procedemos a habilitarlos y ponerlo en línea

```bash
sudo systemctl enable --now zabbix-agent.service
```

Comprobamos es estado del firewall




### CentOS

nos conectamos al servidor por ssh

```bash
ssh usuario@ip_servidor
```

Instalando el agente 

```bash
sudo dnf install zabbix40-agent-4.0.29-1.el8.x86_64
```

Editamos el Archivo

```bash
sudo nano /etc/zabbix_agent.conf
```

Buscamos las líneas y reemplazamos por lo requerido

```text
Server=[ip_servidor]
ServerActive=[ip_servidor]
Hostname=[nombre_host]
```

Comprobamos el estado del agente

```bash
sudo systemctl status zabbix-agent.service
```

Procedemos a habilitarlos y ponerlo en línea

```bash
sudo systemctl enable --now zabbix-agent.service
```

Comprobamos es estado del firewall

```bash
sudo firewall-cmd  --list-all
```

habilitamos el servicio en el firewall

```bash
 sudo firewall-cmd  --add-service=zabbix-agent --permanent
```

recargamos las configuraciones del firewall

```bash
sudo firewall-cmd  --reload
```

Comprobamos es estado del firewall

```bash
sudo firewall-cmd  --list-all
```

```output
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: ens18
  sources:
  services: cockpit dhcpv6-client ssh zabbix-agent
  ports: 5432/tcp
  protocols:
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:
```

## SELinux

Cambiar SElinux a modo permisivo si fuera necesario

```bash
setenforce 0 && sed -i 's/^SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config
```

 
