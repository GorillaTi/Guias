Guía de:

# Configurar Montado de Unidad NTFS

## ACERCA DE:

Versión: 1.2.0

Nivel: Medio

Área: C.P.D.

Elaborado por: Edmundo Céspedes Ayllón

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---

## Tabla de permisos

| Octal | Decimal  | Permissions            | Representation |
|:-----:|:--------:| ---------------------- |:--------------:|
| 000   | 0(0+0+0) | No Permission          | ---            |
| 001   | 1(0+0+1) | Execute                | --x            |
| 010   | 2(0+2+0) | Write                  | -w-            |
| 011   | 3(0+2+1) | Write + Execute        | -wx            |
| 100   | 4(4+0+0) | Read                   | r--            |
| 101   | 5(4+0+1) | Read + Execute         | r-x            |
| 110   | 6(4+2+0) | Read + Write           | rw-            |
| 111   | 7(4+2+1) | Read + Write + Execute | rwx            |

## Preparando para montar

Creamos el directorio de Montage

```bash
sudo mkdir /mnt/[directorio_creado]
```

Obtenemos los datos de la unidad

```bash
sudo blkid | grep "ntfs"
```

o

```bash
lsblk -f
```

Probamos montado de forma manual

```bash
sudo mount -t ntfs-3g /dev/sdaX /home/user/test-o permissions
```

> **Nota.-** Sintaxis del comando mount
> 
> ```bash
> mount -t <fstype> <device> <dir>
> ```
> 
> - **fstype**: Es el tipo de sistema de ficheros que se va a montar (ext4, ntfs, etc.).
> 
> - **device**: Hace referencia a la partición física. Lo más habitual es que sea un fichero dentro de /dev/ (como /dev/sdb1) pero también puede ser un identificador único, una etiqueta o la ruta de un recurso de red.
> 
> - **dir**: El directorio donde se incorpora el sistema de ficheros, normalmente en /media o en /mnt. Debe estar vacío, en caso contrario se sustituirá el contenido, aunque se volverá a restaurar cuando se desmonte la nueva partición.

Tipo de sistema de Ficheros

Para identificar el tipo de sistema de ficheros soportados ejecutamos

```bash
cd /lib/modules/$(uname  -r)/kernel/fs
```

Listamos el contenido y veremos los tipos de sistemas de ficheros soportados

```bash
ls -lha
```

Para mayor compatibilidad con sistemas de ficheros ntfs se intala el paquete `ntfs-3g` 

```bash
sudo apt install ntfs-3g
```

### Montado Permanente

Editamos `fstab` 

```bash
sudo vim /etc/fstab
```

#### Formato del fichero `fstab`

Se compone de una linea por cada sistema de ficheros a montar, las cuales tendrán las siguientes columnas:

- **file system**: hace referencia a una partición o recurso.
- **mount point**: es la carpeta donde estarán accesibles los datos del sistema de archivos.
- **type**: es el tipo de sistema de ficheros (ntfs, ext4, ..)
- **options**: es el lugar donde se especifican los parámetros que mount utilizará para montar el dispositivo, si son varios deben estar separadas por comas.
- **dump**: si usamos dump para hacer copias de seguridad en esta columna pondremos un 1 para indicar que copie esta partición, o un 0 para ignorarla.
- **pass**: cuando la aplicación fsck revise el sistema en busca de problemas en disco, indica la prioridad que tendrá este sistema de ficheros. A mayor número, más prioridad, si es 0 no se revisa.

Ejemplo:

```sh-session
/dev/sda1  /            ext4 errors=remount-ro             0   1
/dev/hda1 /media/win_c  vfat  iocharset=iso8859-1,umask=0  0   0
```

Las opciones son:

- **defaults**: asigna las opciones de montaje predetemrinadas, que son: rw,suid,dev,exec,auto,nouser,async.
- **auto**: el sistema de archivos se montará automáticamente en el arranque.
- **user**: Cualquier usuario puede montar este dispositivo. La orden para desmontarlo sólo podrá ser ejecutada por el usuario que lo ha montado o por el root.
- **users**: Cualquier usuario puede montar el dispositivo y cualquier usuario puede desmontarlo.
- **nouser**: Sólo el root puede montar y desmontar el dispositivo.
- **owner**: solo el propietario puede montar el sistema de archivos.
- **noauto**: El dispositivo no se monta automáticamente.
- **exec**: Permite la ejecución de ficheros de aplicación. 
- **noexec**: no permite dicha ejecución.
- **sync**: Los accesos al sistema de ficheros se efectúa en modo síncrono.
- **async** se realiza en modo asíncrono.
- **ro**: El dispositivo se monta en modo sólo lectura. Sin esta opción o con **rw** se monta en modo lectura-escritura.
- **rw**: montar el volumen en modo lectura-escritura .
- **umask**: Hace referencia a los permisos de los ficheros cuando provienen de sistemas que no utilizan esta característica, como fat y vfat.
- **dev**: puede interpretar los dispositivos especiales o determinados bloques de archivos
- **suid**: permite a usuarios normales ejecutar binarios en el volumen montado con permisos temporales (sudo)
- **nofail**: montará el dispositivo cuando esté presente e ignorará su presencia.





Incluimos el nuevo dispositivo a montar

```shell-session
UUID=6F1AA61039A123AB /home/user/test   ntfs-3g  defaults,permissions 0 0
```

o

```shell-session
/dev/sda /home/user/test   ntfs-3g  defaults,permissions 0 0
```

o

```shell-session
LABEL=OSWIN /home/user/test   ntfs-3g  defaults,permissions 0 0
```

Para ver las particiones montadas se piude revisar el archivo `/proc/self/mounts`

```bash
sudo less /proc/self/mounts
```

o

```bash
mount
```
