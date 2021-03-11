GUÍA DE :

# INSTALACIÓN DE PROXMOX

Versión 1.0

Nivel: Todos

Área: Data Center

Elaborado por Edmundo Céspedes A.

Técnico Encargado Data Center, G.A.M.S.

e-mail: ed.cespedesa@gmail.com

---

## Instalación de Proxmox

Seguimos los pasos de instalación estándar.

## Usar todo el espacio disponible

1. Revisamos el espacio disponible

   ```bash
   vgdisplay | grep Free
   ```

2. Identificamos la partición a la cual deseamos añadir el espacio disponible

   ```bash
   fdisk -l
   lvdisplay
   df -h
   ```

3. Procedemos a extender  la partición

   ```bash
   lvm lvextend -l +100%FREE /dev/pve/data
   ```

4. Registramos los cambios en el sistema de particiones

   ```bash
   resize2fs /dev/pve/data
   ```

5. Verificamos los cambios

   ```bash
   lvdisplay
   vgdisplay | grep Free
   ```

## Quitar mensaje de suscripción

Ejecutar el comando 

```bash
sed -i.bak "s/data.status !== 'Active'/false/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js && systemctl restart pveproxy.service
```

### Crear Cluster

1. Clic en Create Cluster

   - Colocamos el nombre del Cluster
   
2. interfaces de administración y cluster

   | **Servidor** | **IP**          | **Servicio** |
   | :----------- | --------------- | ------------ |
   | svm01        | 192.168.14.101  | IA           |
   |              | 192.169.13.101  | Cluster      |
   |              | 192.169.100.101 | DMZ          |
   | svm02        | 192.168.14.102  | IA           |
   |              | 192.169.13.102  | Cluster      |
   |              | 192.169.100.102 | DMZ          |
   | svm03        | 192.168.14.103  | IA           |
   |              | 192.169.13.103  | Cluster      |
   |              | 192.169.100.103 | DMZ          |
   | svm04        | 192.168.14.104  | IA           |
   |              | 192.169.13.104  | Cluster      |
   |              | 192.169.100.104 | DMZ          |
   | svm05        | 192.168.14.105  | IA           |
   |              | 192.169.13.105  | Cluster      |
   |              | 192.169.100.105 | DMZ          |
   | svm06        | 192.168.14.106  | IA           |
   |              | 192.169.13.106  | Cluster      |
   |              | 192.169.100.106 | DMZ          |
   | svm07        | 192.168.14.107  | IA           |
   |              | 192.169.13.107  | Cluster      |
   |              | 192.169.100.107 | DMZ          |
   | svm08        | 192.168.14.108  | IA           |
   |              | 192.169.13.108  | Cluster      |
   |              | 192.169.100.108 | DMZ          |
   | svm09        | 192.168.14.109  | IA           |
   |              | 192.169.13.109  | Cluster      |
   |              | 192.169.100.109 | DMZ          |
   

ss -ltun | grep named