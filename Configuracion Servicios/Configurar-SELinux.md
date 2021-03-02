Deshabilitamos SElinix

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

