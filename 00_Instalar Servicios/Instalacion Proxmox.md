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

   | **Servidor** | **IP**          | **Servicio** |
   | :----------- | --------------- | ------------ |
   | svm01        | 192.168.14.101  | IA           |
   |              | 192.169.13.101  | Cluster      |
   |              | 192.169.100.101 | DMZ          |
   | svm02        | 192.168.14.102  | IA           |
   |              | 192.169.13.102  | Cluster      |
   |              | 192.169.100.102 | DMZ          |
   | svm03        | 192.168.14.103  | IA           |
   |              | 192.169.13.103  | Cluster      |
   |              | 192.169.100.103 | DMZ          |
   | svm04        | 192.168.14.104  | IA           |
   |              | 192.169.13.104  | Cluster      |
   |              | 192.169.100.104 | DMZ          |
   | svm05        | 192.168.14.105  | IA           |
   |              | 192.169.13.105  | Cluster      |
   |              | 192.169.100.105 | DMZ          |
   | svm06        | 192.168.14.106  | IA           |
   |              | 192.169.13.106  | Cluster      |
   |              | 192.169.100.106 | DMZ          |
   | svm07        | 192.168.14.107  | IA           |
   |              | 192.169.13.107  | Cluster      |
   |              | 192.169.100.107 | DMZ          |
   | svm08        | 192.168.14.108  | IA           |
   |              | 192.169.13.108  | Cluster      |
   |              | 192.169.100.108 | DMZ          |
   | svm09        | 192.168.14.109  | IA           |
   |              | 192.169.13.109  | Cluster      |
   |              | 192.169.100.109 | DMZ          |

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