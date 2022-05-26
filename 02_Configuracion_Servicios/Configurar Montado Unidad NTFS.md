Guía de:

# Configurar Montado de Unidad NTFS

## ACERCA DE:

Versión: 1.0.0

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

Probamos montsndo de forma manual

```bash
sudo mount /dev/sda3 -t ntfs-3g -o permissions /home/user/test
```

Para que sea permante editamos `fstab` 

```bash
sudo vim /etc/fstab
```

Incluimos el nuevo dispositivo a montar

```shell-session
UUID=6F1AA61039A123AB /home/user/test   ntfs-3g  defaults,permissions 0 0
```
