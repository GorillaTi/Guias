Guía de:

# Instalación de Rclone

## ACERCA DE:
Versión: 1.0.0

Nivel: Todos

Área: C.P.D.

Elaborado por: Edmundo Céspedes Ayllón

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---

Instalamos `fuse` par montar directorios

```bash
sudo apt install fuse
```

Montando directorio remoto

```bash
rclone mount  --allow-other --allow-non-empty -v GoogleDrive:GADH /media/Micelanea/Users/edces/Mi\ unidad/GACH/ &
```

