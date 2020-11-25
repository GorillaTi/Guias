### Obtener IP de iLo mediate VMware Exsi

1. Habitamos el servicio ssh en el hipervisor VMWare Exsi

2. Nos conectamos el servidor mediante ssh

   ```bash
   ssh root@192.168.14.0
   ```

   introducimos la contraseña del servidor 

3. Nos situamos luego en la ruta

   ```bash
   cd /opt/hp/tools
   ```

4. Ejecutamos el siguiente comando

   ```bash
   ./hponcfg -w /tmp/ilo-conf.txt
   ```

   ```ouput
   HP Lights-Out Online Configuration utility
   
   Version 4.0-13 (c) Hewlett-Packard Company, 2011
   Firmware Revision = 2.73 Device type = iLO 4 Driver name = hpilo
   iLO IP Address: 192.168.14.201 
   Management Processor configuration is successfully written to file "/tmp/ilo-conf.txt"
   ```

