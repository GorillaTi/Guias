## Para visualizar los discos conectados

```bash
sudo fdisk -l
```

```bash
lsblk
```

## Copiar archivos en Red

### Servidor - Remoto

```bash
scp [usuari]@[servidor]:[directorio_servidor] [direccion_local]
```

```bash
rsync --partial --progress --rsh:ssh [usuari]@[servidor]:[directorio_servidor] [direccion_local]
```

### Remoto - Servidor

```bash
scp [usuari]@[servidor]:[directorio_servidor] [direccion_local]
```

```bash
rsync --partial --progress --rsh:ssh [usuari]@[servidor]:[directorio_servidor] [direccion_local]
```

## Editar Archivo de Forma Remota

```bash
vim scp://[Servidor]//[ubicacion_archivo]
```

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

## Actualizar Fuentes Tipográficas

```bash
sudo fc-cache -f -v
```

## Ver información de un dominio o un servidor

```bash
curl -I 192.168.x.x
```

o

```bash
curl -I [mi.dominio.com]
```

