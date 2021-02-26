GUIA DE INSTALACION 
# BASE DE DATOS SIGMA
---
## ACERCA DE:
Versión: 1.1
Fecha: 01-012-2020
Nivel: Todos
Área: Data Center
Elaborado por: Edmundo Cespedes Ayllon
Técnico Encargado Data Center - GAMS
Email: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---

## Tareas en DB SIGMA
### Subir servicios de la base de datos
Ingresamos al servidor  y cambiamos de usuario al usuario oracle
```bash
su - oracle
```
### Subir servicios de la base de datos

1. Ingresamos a oracle

   ```bash
   sqlplus / as sysdba
   ```

2. Montamos las bases de datos

   ```sql
   startup;
   ```

   Salimos de oracle

   ```sql
   exit
   ```

3. Iniciamos el servicio de listener

   ```bash
   lsnrctl start
   ```

### Bajar servicio de la base de datos
1. Servicios de escucha de oracle
   - Verificar el estado le servicio de escucha
     ```bash
     lsnrctl status
     ```
   - Paramos el servicio

     ```
     lsnrctl stop
     ```
2. Ingresar a oracle
   ```bash
   sqlplus / as sysdba
   ```
3. Desmontamos la base de datos oracle
   ```bash
   shutdown immediate;
   ```
### Apagamos el servidor
Salimos del usuario oracle
```bash
exit
```
Apagamos el servidor
```bash
shutdown -h now
```
