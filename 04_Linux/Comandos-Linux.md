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

