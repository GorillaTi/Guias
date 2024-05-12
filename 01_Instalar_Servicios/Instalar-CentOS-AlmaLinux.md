Guía de:

# Instalación de CentOS - Alma Linux

## Acerca de:

Versión: 2.0.0

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

### Particionamiento

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

- Colocamos  la contraseña para root definido por el encargado de Data Center

- Creamos un usuario, registramos su contraseña y le damos privilegios de administrador

### SWAP recomendado

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

4. Habilitamos el servicio web  de administración para servidor
   
   ```bash
   systemctl enable --now cockpit.socket
   ```

5. Actualizamos e instalamos las actualizaciones.
   
   ```bash
   sudo dnf update -y
   ```

6. Instalar  utilidades de dnf
   
   ```bash
   sudo dnf install -y dnf-utils
   ```

7. Creamos el usuario ***usuario_nuevo***
   
   ```bash
   sudo adduser usuario_nuevo
   ```

8. Asignamos una contraseña para el usuario ***usuario_nuevo***
   
   ```bash
   sudo passwd usuario_nuevo
   ```

9. Incluimos al usuario ***usuario_nuevo*** al grupo ***sudoers (wheel)***.
   
   ```bash
   sudo usermod -aG wheel usuario_nuevo
   ```

10. Verificamos que el usuario ***usuario_nuevo*** se encentra en el grupo ***wheel***.
    
    ```bash
    sudo lid -g wheel
    ```

## Configuración de red

Ejecutar asistente de configuración de red y nombre del equipo

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
sudo yum upgrade -y
```

- Con dnf

```bash
sudo dnf update -y
```

## Paquetes adicionales

### Mejoramos dnf

Editamos el archivo de configuración `/etc/dnf/dnf.conf`

```bash
sudo vim /etc/dnf/dnf.conf
```

Insertamos las siguientes configuraciones

```shell-session
fastestmirror=True
max_parallel_downloads=10
```

### Paquetes adicionales de dependencias

```bash
sudo dnf install dnf-plugins-core
```

### Instalando EPEL-RELEASE

Instalando epel-release

```bash
sudo dnf install epel-release
```

Habilitando el Repositorio

```bash
sudo dnf config-manager --enable epel
```

### Habilitando PowerTools

Instalando las utilidades de `yum` o `dnf`

```bash
sudo dnf install yum-utils
```

o

```bash
sudo dnf install dnf-utils
```

Habilitamos el repositorio de las `powertools`

```bash
sudo dnf config-manager --set-enabled powertools
```

### Aplicativos adicionales

Net-tools y DNS bind-utils

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

## Revisión si el sistema necesita reinicio.

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

## Actualización

### Dentro de la misma rama

Limpiar la cache

```bash
sudo dnf clear all
```

Actualizar las GPG key del sistema operativo

```bash
rpm --import https://repo.almalinux.org/almalinux/RPM-GPG-KEY-AlmaLinux %
```
