Guía de:

# Instalación de CentOS - Alma Linux

## Acerca de:

Versión: 1.1.1

Nivel: Medio

Área: C.P.D.

Elaborado por: Edmundo Céspedes Ayllón

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---

## Instalación

1. Instalar SO siguiendo las instrucciones del instalador.
- Instalamos CentOS 8 minimal, solo con lo necesario.
  
  - Configuramos la interfaces red
  
  - Configuramos con el servidor de hora

## Particionamiento

Creamos las particiones de acuerdo a la siguiente tabla de particiones bajo LVM con tipo de partición XFS.

| Tamaño                                                  | Tipo     | Punto de montaje |
| ------------------------------------------------------- | -------- | ---------------- |
| 512MB                                                   | ext4     | EFI              |
| 250 MB - 1024 MB                                        | Primaria | /boot            |
| 2048 MB                                                 | LVM      | swap             |
| 3 GB Minina 5 GB Completa<br/>15 GB o  espacio restante | LVM      | /                |
| min 10 GB                                               | LVM      | /home            |
| min 1 GB                                                | LVM      | /tmp             |
| min 10 GB                                               | LVM      | /var             |
| min 1GB                                                 | LVM      | /var/log         |
| min 1GB                                                 | LVM      | /var/log/audit   |
| min 1GB                                                 | LVM      | /var/tmp         |

> **Nota.-** partición basa en un HDD de 40 GB

- Colocamos  el password para root definido por el encargado de Data Center

- Creamos el usuario sysadmin, registramos su password y le damos privilegios de administrador

## SWAP recomendado

| RAM Min. | RAM Max. | Swap  |
| -------- | -------- | ----- |
| -        | 4 GB     | 2 GB  |
| 4 GB     | 16 GB    | 4 GB  |
| 16 GB    | 64 GB    | 8 GB  |
| 64 GB    | 256 GB   | 16 GB |
| 256 GB   | 512 GB   | 32 GB |

2. Iniciamos sesión con *root* y verificamos que este corriendo el servicio ssh.

3. Nos conectamos al servidor mediante ssh
   
   ```bash
   ssh [usuario]@[ipservidor]
   ```

4. Habilitamos el servicio web  de monitoreo para servidor
   
   ```bash
   systemctl enable --now cockpit.socket
   ```

5. Instalamos el repositorio de Fedora
   
   ```bash
   sudo dnf install -y epel-release
   ```

6. Actualizamos e instalamos las actualizaciones.
   
   ```bash
   sudo dnf update -y
   ```

7. Instalar  utilidades de dnf
   
   ```bash
   sudo dnf install -y dnf-utils
   ```

8. Creamos el usuario *desarrollo*
   
   ```bash
   sudo adduser desarrollo
   ```

9. Creamos contraseña de para el usuario *desarrollo*
   
   ```bash
   sudo passwd desarrollo
   ```

10. Incluimos al usuario *desarrollo* al grupo *sudoers*.
    
    ```bash
    sudo usermod -aG wheel desarrollo
    ```

11. Verificamos que el usuario desarrollo se encentra en el grupo wheel.
    
    ```bash
    sudo lid -g wheel
    ```

## Configuración de red y el nombre del equipo

```bash
sudo nmtui
```

## Verificamos versión de S.O.

```bash
cat /etc/redhat-release
```

```bash
cat /etc/os-release
```

## Actualizamos el SO

- Con yum

```bash
sudo yum update
sudo yum -y upgrade
```

- Con dnf

```bash
sudo dnf update
```

## Instalar paquetes adicionales

Mejoramos DNF

Editamos el archivo de configuración `/etc/dnf/dnf.conf`

```bash
sudo vim /etc/dnf/dnf.conf
```

Insertamos las siguientes configuraciones

```shell-session
fastestmirror=True
max_parallel_downloads=10
```

instalando paquetes adicionales de dependencias

```bash
sudo dnf install dnf-plugins-core
```

### Instalando EPEL repo en AlmaLinux/Rocky

Instalando epel release

```bash
sudo dnf install epel-release
```

Habilitando el Repositorio

```bash
sudo dnf config-manager --enable epel
```

### Habilitando PowerTools

Instalando las urilidades de yum o dnf

```bash
sudo dnf install yum-utils
```

o

```bash
sudo dnf install dnf-utils
```

Habilitamos el repositorio de las powertools

```bash
sudo dnf config-manager --set-enabled powertools
```

### Habilitando aplicativos adicionales

net-tools y DNS bind-utils

```bash
sudo yum -y install net-tools bind-utils
```

## Revisamos los Puertos abiertos

```bash
sudo netstat -nputa
```

o

```bash
sudo ss -tpan
```

## Revisamos si el sistema necesita reinicio.

```bash
dnf whatprovides needs-restarting
needs-restarting -r
```

## Interfaz de Administración

* Habilitación de Administración Web

```bash
systemctl enable --now cockpit.socket
```

* Ingreso al Interfaz de administración.

```url
https://ip-address-of-rhel8-server:9090
```
