GUÍA DE :

# Instalación y configuración de Proxmox VE

## Acerca de

Versión: 1.0

Fecha: 2021-04-30

Nivel: Intermedio y Avanzado

Área: Data Center

Elaborado por Edmundo Céspedes A.

e-mail: ed.cespedesa@gmail.com

---

## Instalación de Proxmox

Seguimos los pasos de instalación estándar.

## Gestión de Usuarios

### Autentificación IPAM

#### Crear

```bash
useradd [nombre del usuario]
passwd [nombre del usuario]
groupadd watchman
usermod -a -G watchman [nombre del usuario]
```

Posterior nos dirigimos a Datacentre y en permisos (Permissions) - Usuarios (User), creamos con el mismo nombre el usuario y con autentificación IPAM. 

#### Eliminar 

eliminaos el usuario dirigiéndonos a  Datacentre y en permisos (Permissions) - Usuarios (User)

luego en la consola ejecutamos el comando

```bash
deluser --remove-home [nombre del usuario]
```

## Cambio de repositorios non-free

Realizamos una copia de seguridad de los archivos de configuración del repositorio

```bash
cp -rpfv /etc/apt/sources.list /etc/apt/sources.list.orig
```

Editamos los repositorios en /etc/apt/sources.list

```bash
nano /etc/apt/sources.list
```

Reemplazamos por

```config
# Debian Repositori
deb http://ftp.debian.org/debian buster main contrib
deb http://ftp.debian.org/debian buster-updates main contrib
# PVE pve-no-subscription repository provided by proxmox.com
deb http://download.proxmox.com/debian/pve buster pve-no-subscription
# security updates
deb http://security.debian.org/debian-security buster/updates main contrib
```

Deshabilitamos e repositorio Enterprise

```bash
nano /etc/apt/sources.list.d/pve-enterprise.list
```

comentamos la línea

```config
#deb https://enterprise.proxmox.com/debian/pve buster pve-enterprise
```

Actualizamos el repositorio

```bash
apt update
```

instalamos los actualizaciones

```bash
apt upgrade
```



## Usar todo el espacio disponible

1. Revisamos el espacio disponible

   ```bash
   vgdisplay | grep Free
   ```

2. Identificamos la partición a la cual deseamos añadir el espacio disponible

   ```bash
   fdisk -l
   lvdisplay
   df -h
   ```

3. Procedemos a extender  la partición

   ```bash
   lvm lvextend -l +100%FREE /dev/pve/data
   ```

4. Registramos los cambios en el sistema de particiones

   ```bash
   resize2fs /dev/pve/data
   ```

5. Verificamos los cambios

   ```bash
   lvdisplay
   vgdisplay | grep Free
   ```

## Quitar mensaje de suscripción

Ejecutar el comando 

```bash
sed -i.bak "s/data.status !== 'Active'/false/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js && systemctl restart pveproxy.service
```

### Crear Cluster

1. Clic en Create Cluster

   - Colocamos el nombre del Cluster
   
2. interfaces de administración y clúster

   | **Servidor** | **IP**         | **Servicio** |
   | :----------- | -------------- | ------------ |
   | svm01        | 192.168.14.101 | IA           |
   | svm02        | 192.168.14.102 | IA           |
   | svm03        | 192.168.14.103 | IA           |
   | svm04        | 192.168.14.104 | IA           |
   | svm05        | 192.168.14.105 | IA           |
   | svm06        | 192.168.14.106 | IA           |
   | svm07        | 192.168.14.107 | IA           |
   | svm08        | 192.168.14.108 | IA           |
   | svm09        | 192.168.14.109 | IA           |

## Adicionar Nodo al Cluster

## Eliminar Nodo de Cluster

Listamos los nodos del Cluster

```bash
pvecm nodes
```

```output
Membership information
~~~~~~~~~~~~~~~~~~~~~~
    Nodeid      Votes Name
         1          1 hp1 (local)
         2          1 hp2
         3          1 hp3
         4          1 hp4
```

Apagamos el nodo a eliminar y procedemos a eliminamos el nodo

```bash
pvecm delnode hp4
```

```output
Killing node 4
```

o

```output
cluster not ready - no quorum?
```

en este caso ejecutamos el siguiente comando y volvemos a ejecutar e comando para remover el nodo

```bash
pvecm expected 1
```

verificamos si existe el fichero de configuración del nodo

```bash
ls -l /etc/pve/node
```

Eliminamos la configuración del nodo

```bash
rm -rv /etc/pve/node/[nombre_nodo]
```

## Eliminar Cluster



ss -ltun | grep named