Guía de:

# Instalar InfluxDB

## ACERCA DE:

Versión: 1.0.0

Nivel: Medio

Área: C.P.D.

Elaborado por: Edmundo Céspedes Ayllón

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---

## Actualizar sistema operativo

Debian

```bash
sudo apt update 
```

RHEL

```bash
sudo dnf update
```

## Instalacion InfluxDB

Debian

```bash
sudo apt install influxdb
```

o

```bash
wget https://dl.influxdata.com/influxdb/releases/influxdb2-2.5.1-xxx.deb
```

```bash
sudo dpkg -i influxdb2-2.5.1-xxx.deb
```

RHEL

```bash
sudo dnf install influxdb
```

o

```bash
wget https://dl.influxdata.com/influxdb/releases/influxdb2-2.5.1-xxx.rpm
```

```bash
sudo yum localinstall influxdb2-2.5.1-xxx.rpm
```

### Inicializacion del servicio

```bash
sudo systemctl enable --now influxdb
```

o

```bash
sudo service influxdb start
```

> **Nota.-** mayor informe e informacion en la documentacio de pagina  de [Install InfluxDB | InfluxDB OSS 2.5 Documentation](https://docs.influxdata.com/influxdb/v2.5/install/?t=Linux)]

## Configuracion de InfluxDB

### Configurando acceso http

Editando archivo de configuracion

```bash
sudo vi /etc/influxdb/influxdb.conf
```

Habilitamos en la directoiva `http` 

```shell-session
[http]
enabled = true
bind-address = ":8086"
auth-enabled = true
log-enabled = true
write-tracing = false
pprof-enabled=true
pprof-auth-enabled=true
debug-pprof-enabled=false
ping-auth-enabled = true
```

Reinicio del servicio

```bash
sudo systemctl restart influxdb
```

o

```bash
sudo service influxdb restart
```

### Creacion del usuario para autenticacion

```bash
curl -XPOST "http://localhost:8086/query" --data-urlencode "q=CREATE USER \
username WITH PASSWORD 'strongpassword' WITH ALL PRIVILEGES"
```

- **username** reemplazar por el nobre de ususario
- **strongpassword** reemplazar por una contraseña segura

## Conexion a InfluxDB

```bash
influx -username 'username' -password 'password'
```

o

```bash
curl -G http://localhost:8086/query -u username:password --data-urlencode "q=SHOW DATABASES"
```

## Habilitacion en el firewall

Debian

```bash
sudo ufw allow 8086/tcp
```

RHEL

```bash
firewall-cmd --add-port=8086/tcp --permanent
```

```bash
firewall-cmd -reload
```

```bash
firewall-cmd --list-all
```

## Comprobacion de escucha de puerto

```bash
sudo ss -tunelp | grep 8086
```

```shell-session
tcp   LISTEN  0  128     *:8086 *:* users:(("influxd",pid=2072,fd=5)) uid:985 ino:37787 sk:6 v6only:0 <-> 
```
