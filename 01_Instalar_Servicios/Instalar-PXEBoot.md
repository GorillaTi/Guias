Guía de:

# Instalacion PXEBoot Server

---
## ACERCA DE:
Versión: 1.0.0

Nivel: Avanzado

Área: C.P.D

Elaborado por: Edmundo Céspedes Ayllón

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---

1. Actualizamos el sistema operativo

   ```bash
   sudo dnf update
   ```

2. Instalamos los paquetes necesarios

   ```bash
   sudo dnf install dnsmasq syslinux tftpserver
   ```

3. Configuramos el servicio en `/etc/dnsmasq.conf`

   ```bash
   vim /etc/dnsmasq.conf
   ```

4. Insertamos el siguiente código

   ```bash
   interface=ens18,lo
   domain=jsti.chuquisaca.gob.bo
   dhcp-range=192.168.200.221,192.168.200.225,255.255.255.0,1h
   
   # PXE
   dhcp-boot=pxelinux.0,pxeserver,192.168.200.220
   
   # Gateway
   dhcp-option=3,192.168.200.1
   
   # DNS
   dhcp-option=6,8.8.8.8
   server=8.8.4.4
   
   # Broadcast
   dhcp-option=28,192.168.200.255
   
   # NTP
   dhcp-option=42,192.168.200.212
   
   # Set the NTP time server addresses to 192.168.0.4 and 10.10.0.5
   #dhcp-option=option:ntp-server,192.168.0.4,10.10.0.5
   
   pxe-prompt="Press F8 for menu", 10
   
   # Available boot services. for PXE.
   pxe-service=x86PC,"Instalacion de Sistemas Operativos en Red", pxelinux
   
   # Enable dnsmasq's built-in TFTP server
   enable-tftp
   
   # Set the root directory for files available via FTP.
   tftp-root=/var/lib/tftpboot
   ```

5. Copiamos el contenido de `syslinux`

   ```bash
   cp -rfv /usr/share/syslinux/* /var/lib/tfpboot/
   ```

6. Creamos un directorio la almacenar los archivos de arranque por sistema operativo

   ```bash
   mkdir /var/lib/tftpboot/[sistema_operativo]
   ```

7. Descargamos dentro de la carpeta creada los archivos necasarios

   ```bash
   cd [sistema_operativo]
   ```

   ```bash
   curl -O http://[url_reepositorio]/vmlinuz
   ```

   ```bash
   curl -O http://[url_reepositorio]/initrd.img
   ```

8. Creamos la carpeta `pxelinux.cfg`

   ```bash
   mkdir /var/lib/tftpboot/pxelinux.cfg
   ```

9. Creamos el archivo `deafult`

   ```bash
   vim /var/lib/tftpboot/pxelinux.cfg/default
   ```

10. Insertamos el siguiente código

    ```
    default menu.c32
    prompt 0
    timeout 300
    ONTIMEOUT local
    
    menu title ########## PXE Boot Menu ##########
    
    label 1
    menu label ^1) Instalar Alma Linux 8.4 desde Repositorio
    kernel almalinux8/vmlinuz
    append initrd=almalinux8/initrd.img inst.repo=http://mirror.netglobalis.net/almalinux/8.4/BaseOS/x86_64/os/ devfs=nomount ip=dhcp
    ```

11. Inicializamos el servicio `dnsmasq`

    ```bash
    systemctl enable --now dnsmasq
    ```

12. Configuramos el Firewall

    ```bash
    firewall-cmd --add-service=dns --permanent
    firewall-cmd --add-service=tftp --permanent
    firewall-cmd --add-service=dhcp --permanent
    firewall-cmd --add-port={4011/udp,69/udp} --permanent
    firewall-cmd --reload
    firewall-cmd --list-all
    ```

13. 
