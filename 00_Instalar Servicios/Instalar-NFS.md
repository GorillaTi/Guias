Guía de:

# Instalación Servidor NFS

## ACERCA DE:

Versión: 1.0.0

Nivel: Todos

Área: C.P.D.

Elaborado por: Edmundo Céspedes Ayllón

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---

1. Actualizamos el sistema operativo

   ```bash
   dnf update
   ```

2. Instalamos los paquetes necesarios

   ```bash
   dnf ins install nfs-utils
   ```

3. Procedemos a editar la configuración

   ```bash
   vim /etc/idmapd.conf
   ```

4. Insertamos el dominio

   ```
   Domain = nfs.[mi_domiinio]
   ```

5. Creamos los directorios a compartir

   ```bash
   mkdir compartido
   ```

6. Configuramos el archivo para los directorios a compartir

   ```bash
   vim /etc/exports
   ```

7. Insertamos la configuración

   ```
   /home/sysadmin/backup   192.168.200.0/24(rw,async,no_root_squash)
   ```

8. Comprobamos que este correcta la configuración

   ```bash
   exportfs -rav
   ```

9. Inicializamos el servicio NFS

   ```bash
   systemctl enable --now rpcbind nfs-server
   ```

10. Habilitar los puertos en el firewall

    ```bash
    firewall-cmd --add-service=nfs --permanent
    firewall-cmd --reload
    ```

11. Montando directorios NFS

    Creamos Un directorio donde montar el directorio NFS

    ```bash
    mkdir compartido
    ```

    - Temporal

    ```bash
    sudo mount [ip_servidor_nfs]:[directorio_compartido] [directorio_destino]
    ```

    - Definitivo

      Se edita el archivo `/etc/fstab`

    ```bash
    sudo vim /etc/fstab
    ```

    ​	Insertamos al final del archivo

    ```
    
    ```

12. 

13. 

14. 

15. 

