CONFIGURACION MEDIANTE NTP
Probamos si obtenemos la ora del servidor ntpd
$ sudo ntpdate hora.sucre.bo
Ver que sistema operativo se esta usando
>Debian
$ cat /etc/os-release
>CentOS
$ cat /etc/redhat-release
Instalamos ntp 
>Debian
$ sudo apt install ntp -y
>CentOS
$ sudo dng install ntp -y (chrony)
Verificamos la Instalacion ntp 
>Debian
$ sudo dpkg -l ntp
>CentOS
$ sudo rpm -q ntp
Editamos la configuracion
>Debian
$ sudo nano /etc/ntp.conf
>CentOS
$ sudo nano /etc/ntp.conf
Insertamos el servidor
server hora.sucre.bo iburst
Probamos si tenemos conexion con el servidor NTP
$ ping hora.sucre.bo -c 3
Revisamos y Reiniciamos el servicio NTP
>Debian
$ sudo /etc/init.d/ntp status
$ sudo /etc/init.d/ntp restart
>CentOS
$ sudo systemctl status ntpd
$ sudo systemctl restart ntpd.service
Revisamos Sisisncroniza
$ sudo ntpq -p

CONFIGURACION MEDIANTE COMADO
$ date
Mon Oct 12 09:43:36 BOT 2020
listamos zonas horias
$ timedatectl list-timezones
Ahora podemos configurar la zona horaria usando el comando siguiente:
$ timedatectl set-timezone
$ sudo timedatectl set-timezone America/La_Paz
Establecemos la Hora y la Fecha
$ date  --set "2020-10-12 12:44:00"
