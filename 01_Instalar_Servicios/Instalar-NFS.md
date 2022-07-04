Guía de:

# Instalación Servidor NFS

## ACERCA DE:

Versión: 1.1.0

Nivel: Intermedio

Elaborado por: Edmundo Céspedes Ayllón

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---

## Servidor

Actualizamos el sistema operativo

```bash
dnf update
```

Instalamos los paquetes necesarios

```bash
dnf ins install nfs-utils
```

Procedemos a editar la configuración

```bash
vim /etc/idmapd.conf
```

Insertamos el dominio

```
Domain = nfs.[mi_domiinio]
```

Creamos los directorios a compartir

```bash
mkdir compartido
```

Configuramos el archivo para los directorios a compartir

```bash
vim /etc/exports
```

Insertamos la configuración

```
/home/sysadmin/backup   192.168.200.0/24(rw,async,no_root_squash)
```

Comprobamos que este correcta la configuración

```bash
exportfs -rav
```

Inicializamos el servicio NFS

```bash
systemctl enable --now rpcbind nfs-server
```

Habilitar los puertos en el firewall

```bash
firewall-cmd --add-service=nfs --permanent
firewall-cmd --reload
```

## Cliente

Comprobamos los directorios compartidos por el servidor

```bash
sudo showmount -e [ip_servidor o fqdn_servidor] 
```

Creamos un directorio donde montar el directorio NFS

```bash
mkdir compartido
```

Damos permisos al directorio crado

```bash
sudo chown nobody:nogroups [directorio_destino]  
```

- Temporal

```bash
sudo mount [ip_servidor_nfs]:[directorio_compartido] [directorio_destino]
```

- Definitivo

Se edita el archivo `/etc/fstab`

```bash
sudo vim /etc/fstab
```

Insertamos al final del archivo

```shell-session
ip_servidr_nfs]:[directorio_compartido] [directorio_destino] nfs rw,async 00 
```

Montamos los directorios declararos

```bash
sudo mount -a
```

Verificamos que los directorios se montaron correctamente

```bash
df -h
```
