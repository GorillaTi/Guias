GUÍA DE: 
# SERVIDORES SIGMA
## ACERCA DE:
Versión: 1.1.1

Nivel: Todos

Área: CPD

Elaborado por: Edmundo Céspedes Ayllón

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---

## APP SIGMA

### Servicios de Aplicaciones

```bash
sudo - oradev
```

#### Subir servicios de Aplicaciones

   1. iniciamos los servicios de OPMNCTL

   ```bash
   opmnctl startall
   ```

   verificamos el estado del servicio

   ```bash
   opmnctl status
   ```

   resultado

   ```output
   [oradev@appprod ~]$ opmnctl status
   
   Processes in Instance: PRODUCCION.appprod.src.sigma.gob.bo
   -------------------+--------------------+---------+---------
   ias-component      | process-type       |     pid | status
   -------------------+--------------------+---------+---------
   DSA                | DSA                |     N/A | Down
   LogLoader          | logloaderd         |     N/A | Down
   HTTP_Server        | HTTP_Server        |   11185 | Alive
   dcm-daemon         | dcm-daemon         |   11189 | Alive
   WebCache           | WebCache           |   11197 | Alive
   WebCache           | WebCacheAdmin      |   11184 | Alive
   OC4J               | home               |   11190 | Alive
   OC4J               | OC4J_BI_Forms      |   11187 | Alive
   rep_approd_prod    | ReportsServer      |   11324 | Alive
   ```

   2. iniciamos servicios de reportes

   ```bash
   emctl start iasconsole
   ```

   verificamos el estado del servicio

   ```bash
   emctl status iasconsole
   ```

#### Bajar servicios de Aplicaciones

## DB SIGMA

### Servicios de la base de datos

Ingresamos al servidor  y cambiamos de usuario al usuario oracle

```bash
su - oracle
```
#### Subir servicios de la base de datos

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

   verificamos el estado del servicio

   ```bash
   lsnrctl status
   ```

#### Bajar servicio de la base de datos

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

## Apagamos el servidor
Salimos del usuario oracle
```bash
exit
```
Apagamos el servidor
```bash
shutdown -h now
```