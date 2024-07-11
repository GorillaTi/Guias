Guía de: 

# Configuración SElinux

## ACERCA DE:

Versión: 1.0.1

Nivel: Avanzado

Área: CPD

Elaborado por: Edmundo Céspedes Ayllón

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---

:fire: :warning: **NO SE RECOMIENDA LA DESHABILITACION DE SELINUX EN SERVIDORES EN PRODUCCION**

## Deshabilitamos SElinix

revisamos el estado del servicio

```bash
sestatus
```

si esta habilitado procedemos a deshabilitar

```bash
sudo nano /etc/selinux/config
```

editamos la línea

```
SELINUX=disabled
```

reiniciamos el servidor para aplicar los cambios

```bash
sudo shutdown -r now
```

o

```bash
sudo reboot
```

revisamos el estado del servicio

```bash
sestatus
```

```output
SELinux status:                 disabled
```

```
SELinux status:                 disabled
```
