### GUIA DE INSTALACION 

# DNS SERVIDORES DEBIAN CORES

---

## ACERCA DE:

Versión: 1.0

Fecha: 01-12-2020

Nivel: Todos

Área: Data Center

Elaborado por: Edmundo Cespedes Ayllon

Técnico Encargado Data Center - GAMS

Email: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---

## CONFIGURACION MEDIANTE NTP

1. Probamos si obtenemos la hora del servidor ntpd

```bash
$ sudo ntpdate hora.sucre.bo
```

2. Ver que sistema operativo se esta usando

* Debian

  ```bash
  $ cat /etc/os-release
  ```

* CentOS

  ```bash
  $ cat /etc/redhat-release
  ```

3. Instalamos ntp 

  * Debian

  ```bash
  $ sudo apt install ntp -y
  ```

  * CentOS

  ```bash
  $ sudo dnf install ntp -y (chrony)
  ```

4. Verificamos la Instalacion ntp 

  * Debian

  ```bash
  $ sudo dpkg -l ntp
  ```
  * CentOS

  ```
  $ sudo rpm -q ntp
  ```

  * Debian
    
```bash
    $ sudo nano /etc/ntp.conf 
    ```
    
    * CentOS
    
      ```bash
      $ sudo nano /etc/ntp.conf
      ```
    
      Insertamos el servidor
    
      ```bash
      server hora.sucre.bo iburst
      ```
    
      Probamos si tenemos conexion con el servidor NTP
    
      ```bash
      $ ping hora.sucre.bo -c 3
      ```
    
      Revisamos y Reiniciamos el servicio NTP
    
    * Debian
    
    ```bash
    $ sudo /etc/init.d/ntp status
    $ sudo /etc/init.d/ntp restart 
    ```
    
    * CentOS
    
      ```bash
      $ sudo systemctl status ntpd
      $ sudo systemctl restart ntpd.service
      ```
    
      Revisamos Sisisncroniza
    
      ```bash
      $ sudo ntpq -p
      ```
5. CONFIGURACION MEDIANTE COMADO

  ```bash
  $ date
  ```

  ```output
  Mon Oct 12 09:43:36 BOT 2020
  ```

  listamos zonas horias

  ```bash
  $ timedatectl list-timezones
  ```

  Ahora podemos configurar la zona horaria usando el comando siguiente:

  ```bash
  $ timedatectl set-timezone
  $ sudo timedatectl set-timezone America/La_Paz
  ```

  Establecemos la Hora y la Fecha

  ```bash
  $ date  --set "2020-10-12 12:44:00"
  ```

  