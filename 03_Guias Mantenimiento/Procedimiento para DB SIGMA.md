# Procedimiento par DB SIGMA
## Iniciar Base de Datos SIGMA
Ingresamos al servidor y cambiamos al usuario oracle

```bash
su - oracle
```

ingresamos al gestor de la base de datos

```bash
sqlplus / as sysdba
```

iniciamos la base de datos

```sql
startup;
```

Iniciamos el servicio de escucha

```bash
lsnrctl start
```

```output
LSNRCTL for Linux: Version 10.2.0.4.0 - Production on 09-NOV-2020 07:56:14
Copyright (c) 1991, 2007, Oracle.  All rights reserved.
Starting /u01/oracle/product/10.2.0/db_1/bin/tnslsnr: please wait...
TNSLSNR for Linux: Version 10.2.0.4.0 - Production
System parameter file is /u01/oracle/product/10.2.0/db_1/network/admin/listener.ora
Log messages written to /u01/oracle/product/10.2.0/db_1/network/log/listener.log
Listening on: (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=bdprod.scr.sigma.gob.bo)(PORT=1521)))
Listening on: (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC0)))
Connecting to (DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=bdprod.scr.sigma.gob.bo)(PORT=1521)))
STATUS of the LISTENER
------------------------
Alias                     LISTENER
Version                   TNSLSNR for Linux: Version 10.2.0.4.0 - Production
Start Date                09-NOV-2020 07:56:16
Uptime                    0 days 0 hr. 0 min. 0 sec
Trace Level               off
Security                  ON: Local OS Authentication
SNMP                      OFF
Listener Parameter File   /u01/oracle/product/10.2.0/db_1/network/admin/listener.ora
Listener Log File         /u01/oracle/product/10.2.0/db_1/network/log/listener.log
Listening Endpoints Summary...
  (DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=bdprod.scr.sigma.gob.bo)(PORT=1521)))
  (DESCRIPTION=(ADDRESS=(PROTOCOL=ipc)(KEY=EXTPROC0)))
Services Summary...
Service "PLSExtProc" has 1 instance(s).
  Instance "PLSExtProc", status UNKNOWN, has 1 handler(s) for this service...
The command completed successfully
```

## Detener Base de Datos SIGMA

Ingresamos al servidor y cambiamos al usuario  oracle
```bash
su - oracle
```
paramos el servicio de escucha de la base de datos
```bash
lsnrctl stop
```
ingresamos  al gestor de la base de datos
```bash
sqlplus / as sysdba
```
bajamos las bases de datos
```sql
shutdown;
```
o
```sql
shutdown immediate;
```