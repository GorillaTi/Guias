Guía de: 

# Hardening

## ACERCA DE:

Versión: 1.0.2

Nivel: Avanzado

Área: CPD

Elaborado por: Edmundo Céspedes Ayllón

Email: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---

## S.O. (Sistema Operativo)

### Archivo de configuración

```bash
sudo nano /etc/fstab 
```

Opciones de particiones de particiones:

- Básicas

| rw  | lectura - escritura |
|:---:|:-------------------:|
| ro  | solo lectura        |

- Avanzadas

| File Sistem | noexec             | nosuid             | nodev              | noatime            |
|:-----------:|:------------------:|:------------------:|:------------------:|:------------------:|
| `/`         | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| `/boot`     | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| `/var`      | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| `/home`     | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| `/tmp`      | :white_check_mark: | :white_check_mark: | :white_check_mark: | :white_check_mark: |
| `/usr`      |                    |                    | :white_check_mark: | :white_check_mark: |

**Nota.-** La partición `/usr` no debe de ponerse las particiones.

Pruebas de las configuraciones de las particiones.

```bash
mount -o remount,ro /home
```

Para volver la configuración por defecto ( `defaults`) en el sistema de archivos usar el comando siguiente.

```bash
mount -o remount /home
```

## SSH

La mayor parte de las configuraciones serán realizadas en el archivo:

RedHat, CentOS, Alama Linux y Rocky Linux

```bash
sudo nano etc/ssh/sshd_conf
```

Debian y Ubuntu

```bash
sudo nano etc/ssh/sshd_conf
```

### 1. Autenticación SSH siempre basada en clave pública

Se recomienda que se utilice la autenticación basada en clave pública. Para esto se  debe crear el par de claves usando el siguiente comando

```bash
ssh-keygen
```

Se tiene dos formas de enviar la clave publica al servidor

* Opción 1
  
  ```bash
  ssh-copy-id [ususario_servidor]@[ip_servidor]
  ```

* Opción 2
  
  ```bash
  cat ~/.ssh/id_rsa.pub | ssh demo@198.51.100.0 "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >>  ~/.ssh/authorized_keys"
  ```

### 2. Cambio de puerto por defecto

La mayoría de los ataques a este servicio se realiza de forma automática probando con usuarios y contraseñas comunes en el  puerto 22 (Ataque de Fuerza Bruta).

Si cambias el puerto evitarás en su gran mayoría este tipo de ataques.

```config
Port [nro_puerto]
```

**Nota** se deberá tomar en cuenta el numero de puerto al momento de realizar la conexión por ejemplo

```bash
ssh [ususario_servidor]@[IP_servidor] -p 3022
```

### 3. Limite la vinculación IP

La directiva `ListenAddress` especifica en qué direcciones IP se abrirá el  puerto para ofrecer el servicio. Si el sistema dispone de más de una  dirección IP, ya sea IPv4 o IPv6, es conveniente limitar esta escucha  únicamente a las necesarias. Por defecto viene en ALL, así que el  servicio se abrirá en todas las interfaces disponibles del sistema.

```config
ListenAddress [IP_servidor]
```

### 4. Deshabilitar el usuario ROOT para login

Fuerza a utilizar una version de protocolo se recomienda la 2

```config
Protocol 2
```

### 5. Deshabilitar el usuario ROOT para login

El usuario super administrador (root) del sistema no debería realizar la autenticación  directamente contra el equipo. Es recomendable modificar este parámetro  dejándolo en “**no**”

```config
PermitRootLogin no 
```

### 6. Limitar el acceso SSH de los usuarios del sistema

`AllowUsers` habilita qué usuarios tienen permitido el uso del servicio SSH. Puedes  colocar varios usuarios. Por defecto, permite a todos los usuarios del  sistema iniciar sesión por SSH pero es recomendable que limite el acceso solo a los que realmente necesitan utilizar este servicio.

```config
AllowUsers [user1] [user2]
```

Al igual que con `AllowUsers`, `AllowGroups` permite especificar el grupo o los grupos de usuarios a los que se les permite hacer acceder mediante SSH al sistema.

```config
AllowGroups [group1] [group2]
```

### 7. Deshabilitar inicio de sesión basado en contraseña

Todos los inicios de sesión basados en contraseñas deben estar  deshabilitados. Solo debe permitir inicios de sesión basados en claves públicas.

```config
AuthenticationMethods publickey
PubkeyAuthentication yes
```

En algunas versiones viejas de SSHD sería así:

```config
PubkeyAuthentication yes
```

**NOTA** para tal efecto ya se debe de tener habilitado el acceso al servidor por clave publica de lo contrario se perderá el acceso al servidor.

### 8. Deshabilitar contraseñas vacías

Debemos rechazar los inicios de sesión remoto, desde cuentas con contraseñas vacías.

```
PermitEmptyPasswords no
```

### 9. Limitar intentos de autenticación fallida

Con el parámetro `MaxAuthTries` se especifica el máximo número de intentos de autenticación fallida por conexión. Se recomienda su configuración a un  valor de **3**.

```config
MaxAuthTries 3 
```

### 10. Ajuste de LoginGraceTime

Con la directiva `LoginGraceTimese` especifica cuantos segundos se permite que un usuario permanezca con una conexión abierta sin haberse autenticado  correctamente. Se recomienda que este valor sea de **60.**

```conf
LoginGraceTime 60
```

### 11. Limitación conexiones simultaneas no autenticadas

La directiva **`MaxStartups`** especifica el número máximo permitido de conexiones simultaneas no autenticadas,  todos los intentos de conexión siguientes serán denegados hasta que uno  se realice correctamente el proceso autenticación.

De esta forma se protege de posibles ataques de fuerza bruta. El valor por defecto es de 10, se recomienda un valor menor, valor sugerido **3**.

```conf
MaxStartups 3
```

### 12. Habilitar un banner de advertencia para los usuarios de SSH

Banner que será mostrado antes de la autenticación de un usuario en el sistema es especificado en la directiva **`Banner`**.

```conf
Banner /etc/issue
```

### 13. Intervalo de tiempo de espera de cierre de sesión inactiva

Se debe de establecer un intervalo de tiempo de inactividad para las  sesiones SSH. De esta forma, si un usuario deja la sesión desatendida,  la misma se cierra automáticamente después de transcurrido el tiempo esto se realiza en las directivas **`ClientAliveInterval`** y **`ClientAliveCountMax`** medidas en segundos.

```conf
ClientAliveInterval 300
ClientAliveCountMax 0
```

### 14. Deshabilitar archivos .rhosts

SSH puede emular el comportamiento del comando RSH obsoleto, simplemente desactive el acceso inseguro a través de RSH.

```conf
IgnoreRhosts yes
```

### 15. Deshabilitar la autenticación basada en el host

Se debe de deshabilitar la directiva **`HostbasedAuthentication`**, ya que en principio definimos que la autenticación sería por clave pública.

```conf
HostbasedAuthentication no
```

### 16. Deshabilitar **X11forwarding**

X11, es el servidor gráfico que usan casi todas las distribuciones Linux.  Este servidor permite, entre otras cosas, forwarding a través de SSH.  Esto significa que es posible ejecutar aplicaciones gráficas de una  máquina remota exportando el display a nuestro escritorio. Es decir, la  aplicación se ejecuta en el servidor remoto, pero la interfaz gráfica la visualizamos en nuestro escritorio local.

Así que si no necesitas utilizar este servidor gráfico se debe de deshabilitar.

```config
X11forwarding no
```

### 17. Chroot (Bloquear usuarios a sus directorios de inicio)

De forma predeterminada, los usuarios pueden navegar por los directorios  del servidor, como /etc /, /bin, entre otros. Se puede proteger SSH,  usando **Chroot** para bloquear a los usuarios en sus directorios  personales.

Esta configuración se la mostraremos próximamente en un nuevo artículo.

### 18. Comprobación de configuración

Para comprobar el archivo de configuración y detectar cualquier error antes de reiniciar SSHD, ejecute:

```bash
sshd -t
```

Reiniciamos el servicio

```bash
service restart sshd
```

o

```bash
systemctl restart sshd
```

**TIP** es importante tener en cuenta que se puede limitar el acceso a este servicio solo a la LAN de la organización o a través de una VPN  para casos que se requiera un acceso externo, las redes mas utilizadas par una LAN son:

```conf
192.168.0.0/16
10.0.0.0/8
172.16.0.0/12    
```