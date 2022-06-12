## Para visualizar los discos conectados

```bash
sudo fdisk -l
```

```bash
lsblk
```

---

## Copiar archivos en Red

### Servidor - Remoto

```bash
scp [usuari]@[servidor]:[directorio_servidor] [direccion_local]
```

```bash
rsync --partial --progress --rsh=ssh [usuario]@[servidor]:[directorio_servidor] [direccion_local]
```

### Remoto - Servidor

```bash
scp [usuari]@[servidor]:[directorio_servidor] [direccion_local]
```

```bash
rsync -uvzhe ssh --progress [usuari]@[servidor]:[directorio_servidor] [direccion_local]
```

---

## Editar Archivo de Forma Remota

```bash
vim scp://[Servidor]//[ubicacion_archivo]
```

---

## Buscar y reemplazar en VIM

Sintaxis

```vim
:rango s/patron/reemplazo/[cgil]
```

Respecto al rango, puede ser alguno de los que indico a continuación, una combinación o ninguno de ellos. Es decir con esto que el `rango` es totalmente opcional, se puede omitir

- `numero` se refiere a la búsqueda y reemplazo en una línea concreta
- `inicio,fin` de la línea `inicio` a la línea `fin`
- `.` para la línea actual
- `$` se refiere a la última línea del archivo
- `%` se refiere a todo el archivo

Existen algunas opciones mas de las que se ha indicado, con estas, seguro que se abarca la mayor parte de los casos que se necesita.  Algunos ejemplos,

- `:5,10s/casa/caso/g` reemplaza `casa` por `caso` entre las líneas 5 y 10 del documento.
- `:%s/casa/caso/g` se comporta igual que el caso anterior, pero lo hace en todo el documento.

Por otro lado, respecto a las opciones `cgil` que aparecen en la sintaxis indicadas anteriormente,

- `c` te obliga a confirmara cada una de las sustituciones.
- `g` reemplaza todas las ocurrencias de la línea. Si no se añade esta opción solo cambiará la primera de las apariciones en la línea.
- `i` no distingue entre mayúsculas y minúsculas.
- `l` diferencia entre mayúsculas y minúsculas.

Por lo general, la forma de cambiar todas las apariciones de la palabra `casa` en un texto, es tan sencillo como `:%s/casa/caso/g` si además no se quiere hacer distinción entre mayúsculas y minúsculas `:%s/casa/caso/gi`

#### Algunos ejemplos con expresiones regulares

A continuación algunos ejemplos del potencial que tienen tanto las expresiones regulares como el uso de  reemplazar con Vim.

- `:%s/print\s*.*$/print(\1)` le pone paréntesis a todos los *print*
- `:%s/^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$//g` elimina colores en hexadecimal
- `:%s/^(?:[0-9a-f]{2}[\-:]?){6}(?<![\-:])$//g` elimina las direcciones MAC
- `:%s/<!\[CDATA\[(.*)\]\]>//g` eliminar etiquetas `CDATA`

---

## IP alias con el comando `ip`

Listar IP's asignadas del sistema

```bash
ip a
```

Adicionar IP alias

```bash
sudo ip address add 192.168.1.1/24 dev eth1
```

Remover  IP alias

```bash
sudo ip address del 192.168.1.1/24 dev eth1
```

---

## Actualizar Fuentes Tipográficas

```bash
sudo fc-cache -f -v
```

---

## Ver información de un dominio o un servidor

```bash
curl -I 192.168.x.x
```

o

```bash
curl -I [mi.dominio.com]
```

---

## Descomprimir Archivos .TAR.GZ

Descomprimir archivo

```bash
tar -xvf [nombre_archivo]
```

---

## Laravel

### Archivos de configuracion de rutas

```bash
sudo vim /var/www/html[aplicacion]/config/adminlt.php
```

```bash
sudo vim /var/www/html[aplicacion]/public/js/script.js
```

### Limpiar cache de Laravel

```bash
php artisan cache:clear
php artisan config:clear
php artisan config:cache
```

### Limpiar vistas (view)

```bash
php artisan view:clear
```

### Limpiar rutas

```bash
php artisan route:clear
php artisan route:cache
```

---

## SSH TIPOS DE CONEXIONES

### Copiar clave publica al servidor

```bash
ssh-copy-id [usuario@ip_servidor]
```

### Ejecutar comando en el servidor ssh

```bash
ssh -t [usuario@ip_servidor] [comando]
```

### Conesxion usando un servidor ssh como proxy (proxy socks)

```bash
ssh -D [perto] [usuario@ip_servidor]
```

### Ejecutar aplicaiones Xserver por ssh

```bash
ssh -X [usuario@ip_servidor]
```

### Habilitando puerto local para acceder a servicio via ssh

```bash
ssh -L [puerto_local]:[ip_servidor2]:[puerto_remoto] [usuario@ip_servidor]
```

Si se te olvido realizar el forwarder de puerto puedes ejecutar en terminal para que te abra el interprete de ssh

```bash
~c
```

Luego insertar los parametros para el forward

```bash
-L [puerto_local]:[ip_servidor]:[puerto_remoto] 
```

### Tunel ssh reverso

```bash
ssh -R [puerto_local]:[ip_servidor2]:[puerto_remoto] [usuario@ip_servidor_esterno]
```

### Usar ser salto (jump) ssh

Ejecutar agente ssh

```bash
eval `ssh-agent`
```

Cargamos el id_rsa_pub

```bash
ssh-add .ssh/id_rsa
```

Ver las llaves cargadas

```bash
ssh-add -l
```

Usamos el salto}

```bash
ssh -J [server1] [server2]
```

**Nota.-** Deben de estar cargadas las llaves de autentificcacion en los servidores y configurados los servidores en el archivo .ssh/config

### Montar directorio por medio de ssh

```bash
sshf [usuario@ip_servidor]:[directorio] /mnt/[directorio_montaje]
```

### Editar archivo via ssh

```bash
vim scp://[usuario@ip_servidor]/[archivo]
```

**Nota.-** Para declarar dentro de un directorio se debe de usar `//`

---

## Cambiar ditribucion de teclado

### De forma temporal

```bash
loadkeys es 
```

o

```bash
vim /etc/vconsole.conf
```

y escribimo s en el mismo

```text
KEYMAP=es
```

---

## Eliminar paquetes obsoletos en Debian, Ubuntu y derivados

Verificaremos si tenemos paquetes obsoletos, con el siguiente comando se listara los paquetes.

```shell-session
dpkg -l | grep -i ^rc
```

Con el siguiente comando se listaran los paquetes obsoletos, para luego ser eliminados, esto debe ser ejecutado como root.

```shell-session
dpkg -l |grep -i ^rc | cut -d " " -f 3 | xargs dpkg --purge
```

---

## Migrar llaves apt-key a llaves gpg

Listamos las llaves apt-key

```bash
sudo apt-key list
```

Exportamos la llave apt-key

```bash
sudo apt-key export BE1229CF | sudo gpg --dearmour -o /usr/share/keyrings/microsoft.gpg
```

**Nota:** El valor`BE1229CF` se obtiene de los 8 ultimos caracteres del codigo `pub` .

y muestra el mensaje

```shell-session
Warning: apt-key is deprecated. Manage keyring files in trusted.gpg.d instead (see apt-key(8)).
```

Ahora Actualizamos el archivo de configuracion del repositorio (ejemplo, `/etc/apt/sources.list.d/microsoft.list`), adicionamos la etiqueta`signed-by` segudo del directorio donde se encuentra la llave `gpg`:

```bash
deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/edge/ stable main
```

Procedemos a actualizar la cache del repositorio.

```bash
sudo apt update
```

Eliminar la llave apt-key exportada

```bash
sudo apt-key del BE1229CF
```

---

## Comando Tar

### Archivos .tar.gz:

Comprimir:

```bash
tar.gz: tar -czvf empaquetado.tar.gz /carpeta/a/empaquetar/
```

Descomprimir:

```bash
tar.gz: tar -xzvf archivo.tar.gz
```

### Archivos .tar:

Empaquetar:

```bash
tar -cvf paquete.tar /dir/a/comprimir/
```

Desempaquetar:

```bash
tar -xvf paquete.tar
```

### Archivos .gz:

Comprimir:

```bash
gzip -9 index.php
```

Descomprimir:

```bash
gzip -d index.php.gz
```

### Archivos .zip:

Comprimir:

```bash
zip archivo.zip carpeta
```

Descomprimir:

```bas
unzip archivo.zip
```
