Guía de:

# Configuracion de Fail2ban

## ACERCA DE:

Versión: 1.0.0

Nivel: Todos

Área: C.P.D.

Elaborado por: Edmundo Céspedes Ayllón

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---

## Instalación de Fail2ban en CentOS / RHEL 8

El paquete **fail2ban** no está en los repositorios oficiales pero está disponible en el repositorio **EPEL**. Los cargamos haciendo:

```bash
dnf install epel-release
```

o

```bash
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
```

Luego, instalamos el paquete **Fail2ban** ejecutando el siguiente comando.

```bash
dnf install fail2ban
```

## Configuración de Fail2ban para proteger SSH

Los archivos de configuración de **fail2ban** se encuentran en **/etc/fail2ban/** y los filtros se almacenan en el directorio  **/etc/fail2ban/filter.d/** (el archivo de filtro para sshd es  **/etc/fail2ban/filter.d/sshd.conf** ).

El archivo de configuración global para el servidor fail2ban esta en **/etc/fail2ban/jail.conf**, sin embargo, no se recomienda modificar este  archivo directamente, ya que probablemente se sobrescribirá o  mejorará en caso de una actualización del paquete en el futuro.

Como alternativa, se recomienda crear y agregar sus configuraciones en un archivo **jail.local** o archivos `.conf` separados en el directorio **/etc/fail2ban/jail.d/**.

Cuidado con esto porque los parámetros de  configuración establecidos en **jail.local anularán** lo que esté definido en **jail.conf**.

### Crear archivo de configuracion jail.local

```bash
sudo vim /etc/fail2ban/jail.local
```

Ahora insertamos la siguiente configuración en la sección `[DEFAULT]` que contiene opciones globales y `[sshd]` que contiene parámetros para la «cárcel»(jail) de sshd.

```shell-session
[DEFAULT] 
ignoreip = 192.168.23.139/24
bantime = 21600
findtime = 300
maxretry = 3
banaction = iptables-multiport
backend = systemd
[sshd] 
enabled = true
```

Expliquemos brevemente las opciones en la configuración anterior:

- **ignoreip** : especifica la lista de direcciones IP o nombres de host que no se prohibirán.
- **bantime** : especificó el número de segundos que un host está prohibido (es decir, la duración efectiva de la prohibición).
- **maxretry** : especifica el número de fallas antes de que se **bloquee** un host.
- **findtime** : fail2ban prohibirá un host si ha generado  **maxretry**  durante los últimos segundos **findtime**.
- **banaction** : acción de prohibición.
- **backend** : especifica el backend utilizado para obtener la modificación del archivo de registro.

> **Nota.-** La configuración anterior, significa que si una IP ha intentado conectarse por ssh y ha fallado **3** veces en los últimos **5** minutos, va a prohibir por **6** horas e ignore la dirección IP **192.168.23.139**.

### Habilitar el servicio fail2ban

```bash
systemctl start fail2ban
```

```bash
systemctl enable fail2ban
```

```bash
systemctl status fail2ban
```

## Probando fail2ban-client

Para ver el estado actual del servidor fail2ban, ejecute el siguiente comando.

```bash
fail2ban-client status
```

Para monitorear la «cárcel» **sshd** hacemos

```bash
fail2ban-client status sshd
```

Para des-banear una dirección IP en fail2ban (en todas las cárceles y bases de datos), ejecutamos el siguiente comando.

```bash
fail2ban-client unban 192.168.23.1
```

Para obtener más información sobre fail2ban, podemos hacer uso del manual.

```bash
man jail.conf
```

```bash
man fail2ban-client
```
