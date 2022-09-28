Comandos para Zimbra

Los comandos hay que ejecutarlo con el usuario zimbra

```bash
su - zimbra
```

### Control de servicios

| Nro. | Comando                                                                 | Descripción                                                                                       |
| ---- | ----------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| 1    | zmcontrol status                                                        | verificar el estado de todos los servicios                                                        |
| 2    | zmcontrol stop                                                          | detener todos los servicios                                                                       |
| 3    | zmcontrol start                                                         | iniciar todos los servicios                                                                       |
| 4    | zmcontrol restart                                                       | reiniciar todos los servicios                                                                     |
| 5    | zmcontrol -v                                                            | versión de zimbra                                                                                 |
| 6    | ldap start                                                              | Iniciar sólo el servicio LDAP                                                                     |
| 7    | mysql.server start                                                      | Iniciar el servicio de MySQL                                                                      |
| 8    | zmconfigdctl start                                                      | Iniciar zmconfigd                                                                                 |
| 9    | zmmtactl start                                                          | Iniciar MTA (postfix, saslauthd)                                                                  |
| 10   | zmamavisdctl start                                                      | Iniciar Amavis, Antivirus y AntiSpam (amavis, spamassassin, clamav)                               |
| 11   | zmmailboxdctl start                                                     | Iniciar Mailbox (webmail, panel de administración, servidores imap y pop3, servidores de filtros) |
| 12   | zmapachectl start`                                                      | Iniciar spell (servidor de ortografía)                                                            |
| 13   | zmswatchctl start                                                       | Iniciar monitorización                                                                            |
| 14   | zmstatctl start * Iniciar Logger (logs del sistema)zmlogswatchctl start | Iniciar estadísticas                                                                              |
| 15   | Reiniciar solo el antivirus                                             | zmantivirusctl restart                                                                            |
| 16   | zmantispamctl restart                                                   | Reiniciar solo el antispam                                                                        |

### Comando de administración

@table

| Nro. | Comando                                                                                           | Descripción                                |
| ---- | ------------------------------------------------------------------------------------------------- | ------------------------------------------ |
| 1    | zmprov help                                                                                       | Lista la ayuda general de zmprov           |
| 2    | zmprov help acount                                                                                | Listar la ayuda para gestionar las cuentas |
| 3    | zmprov`prov>` `Ver ayuda de cuentas`prov> help account`Salir de la consola interactiva`prov> quit | Consola Interactiva                        |

### Comandos para la administración certificados

| Nro. | Comando                                   | Descripción                         |
| ---- | ----------------------------------------- | ----------------------------------- |
| 1    | /opt/zimbra/bin/zmcertmgr viewdeployedcrt | Ver fecha de caducidad certificados |

### Comandos para la administración de dominios

| Nro. | Comando    | Descripción                  |
| ---- | ---------- | ---------------------------- |
| 1    | zmprov gad | Listar dominios configurados |

### Comandos para administración del servidor

| Nro. | Comando                                                                                                 | Listar dominios configurados                                     |
| ---- | ------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------- |
| 1    | zmtlsctl both (http,https,both,mixed,redirect)                                                          | Cambiar la modalidad de acceso                                   |
| 2    | zmprov ms `zmhostaname` zimbraMailPort 8081                                                             | Cambiar el puerto del webmail                                    |
| 3    | zmprov ms `zmhostname` zimbraMtaMyNetworks "127.0.0.1/32 10.0.0.1/32 192.168.1.15/32"``zmmtactl restart | Añadir equipos o segmentos de ip en las redes de confianza (mta) |

### Comandos para cuentas

| Nro. | Comando                                                                                                                                                                                           | Descripción                                                            |
| ---- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| 1    | zmprov -l gaa                                                                                                                                                                                     | Obtener listado de todas las cuentas del servidor (todos los dominios) |
| 2    | zmprov -l gaaa                                                                                                                                                                                    | Obtener todas las cuentas de administración                            |
| 3    | zmprov -l ga [usuario@midominio.com](mailto:usuario@midominio.com)                                                                                                                                | Obtener información de una sola cuenta                                 |
| 4    | zmprov -l gaa midominio.com                                                                                                                                                                       | Cuentas de un dominio específico                                       |
| 5    | zmprov -l gaa -v midominio.com                                                                                                                                                                    | Detalle de cuentas de un dominio especifico                            |
| 6    | zmprov -l gaa -v midominio.com \                                                                                                                                                                  | grep -e zimbraMailDeliveryAddress -e displayName -e zimbraMailQuota \  |
| 7    | zmprov ca [pepito@dominio.com](mailto:pepito@dominio.com) pepitopass displayName "Pepito Pérez"                                                                                                   | Crear una cuenta, con cos default                                      |
| 8    | - cos=`zmprov gc gerente \                                                                                                                                                                        | grep zimbraId:\                                                        |
| 9    | zmprov ca [windozero@dominio.com](mailto:windozero@dominio.com) passwinbugs cn 'Nombre(s) ApMaterno ApPaterno' displayName 'Nombre(s) ApMaterno ApPaterno' givenName 'Nombre(s)' zimbraCOSId $cos | Crear una cuenta con detalle                                           |
| 10   | zmprov ra [usuario@dominio.com](mailto:usuario@dominio.com) usuariorenombrado@dominio.com                                                                                                         | Renombrar cuenta                                                       |
| 11   | zmprov ma [account@domain.com](mailto:account@domain.com) zimbraAccountStatus (active,lockout,close)`                                                                                             | Modificar el estado de una cuenta                                      |
| 12   | zmprov ga [account@domain.com](mailto:account@domain.com) \                                                                                                                                       | grep Quota                                                             |
| 13   | zmprov gmi [account@domain.com](mailto:account@domain.com) \                                                                                                                                      | grep zimbraMailQuota                                                   |

### Modificar opciones de una cuenta

| Nro. | Comando                                                                                                                                | Descripción                                                                           |
| ---- | -------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| 1    | `zmprov sp usuario@midominio.com passnuevo`                                                                                            | Cambiar de password de una cuenta                                                     |
| 2    | `zmprov ma usuario@midominio.com displayName "Luser Noob 1`                                                                            | Modificar un atributo de una cuenta                                                   |
| 3    | `zmprov -l ga usuario1@midominio.com`                                                                                                  | se puede modificar cualquier atributo del usuario para la lista de atributos ejecutar |
| 4    | `zmprov ma account@domain.com zimbraPrefBccAddress account@domain2.com`                                                                | Configurar un reenvio de correos salientes                                            |
| 5    | `zmprov ma account@domain.com zimbraPrefMailForwardingAddress account2@domain2.com`                                                    | Configurar un forward                                                                 |
| 6    | `zmprov ma account@domain.com zimbraMailForwardingAddress account2@domain2.com`                                                        | Configurar un forward oculto del usuario                                              |
| 7    | `zmprov ma account@domain.com zimbraPasswordLockoutEnabled TRUE zimbraPasswordLockoutFailureLifetime 1h zimbraPasswordLockoutMaxFailu` | Configurar políticas de bloqueo de cuenta                                             |

### Búsqueda de cuentas

| Nro. | Comando                                | Descripción                                                                 |
| ---- | -------------------------------------- | --------------------------------------------------------------------------- |
| 1    | `zmprov sa parametro=cadena`           | Búsqueda por atributos Se puede buscar las cuentas por un atributo en común |
| 2    | `zmprov sa zimbraAccountStatus=active` | Buscar todas las cuentas activas                                            |
| 3    | `zmprov sa zimbraAccountStatus=locked` | Buscar todas las cuentas bloqueadas                                         |
| 4    | `zmprov gam cuenta@midominio.com`      | Buscar en cuales listas se encuentra una cuenta                             |

### Listas de correo

| Nro. | Comando                                     | Descripción                            |
| ---- | ------------------------------------------- | -------------------------------------- |
| 1    | `zmprov gadl` <br>`zmprov gadl dominio.com` | Buscar todas las listas, y por dominio |

- Crear una lista
  
  ​ `zmprov cdl lista@dominio.com`

- Ver una lista específica
  
  ​ `zmprov gdl lista@dominio.com`

- Encontrar todas las listas de un dominio y sus miembros
  
  ​ `for i in $( zmprov gadl dominio.com | grep -v abuse | grep -v postmaster | sort ) ; do echo`` ```zmprov gdl $i | grep -e 'mail: ' -e 'zimbraMailForwardingAddress: ' | sed 's/mail/Lista/' | sed 's/zimbraMailForwardingAddress: //'` ; done ;`

- agregar un miembro a la lista
  
  ​ `zmprov adlm lista@dominio.com cuenta@dominio.com`

- Remover un miembro de la lista
  
  ​ `zmprov rdlm lista@dominio.com cuenta@dominio.com`

- Borrar una lista
  
  ​ `zmprov ddl lista@dominio.com`

### Buzones (zmmailbox)

- Entrar a la consola interactiva
  
  ​ `$> zmmailbox``mbox>` `Ver ayuda general del comando``zmmailbox help` `Ver ayuda de las cuentas ``zmmailbox help account` `Ver ayuda de los mensajes``zmmailbox help message`

- Ver tamaño ocupado del buzón
  
  ​ `zmmailbox -z -m cuenta@dominio.com gms`

- Ver el tamaño de las quotas asignadas y ocupadas de todos los buzones
  
  ​ `zmprov gqu` zmhostname`|awk {'print " "$3" "$2" "$1'}`

- Revisar mensajes por carpetas en el buzón
  
  ​ `zmmailbox -z -m cuenta@dominio.com gaf`

- Borrar una carpeta completa de un buzón
  
  ​ `zmmailbox -z -m cuenta@dominio.com emptyFolder Junk`

- Importar mensajes de una carpeta Maildir existente en el INBOX
  
  ​ `echo addMessage /INBOX /path/to/Maildir/cur | /opt/zimbra/bin/zmmailbox -z -m cuenta@dominio.com`

- Buscar un mensaje
  
  ​ `zmmailbox -z -m cuenta@dominio.com search -t message "prueba"`

- Buscar un mensaje en todas las cuentas
  
  ​ `zmprov -l gaa |awk '{print "zmmailbox -z -m "$1" search \"cadena a buscar\" "}' |sh -v`

- Buscar correos anteriores a una fecha: (formato mes/dia/año)
  
  ​ `zmmailbox -z -m cuenta@dominio.com search -t message "in:INBOX (before: 12/19/13)"`

- Obtener contenido de un correo
  
  ​ `zmmailbox -z -m cuenta@dominio.com gm id_delmensaje`

- Ver contactos:
  
  ​ `zmmailbox -z -m cuenta@dominio.com gact | less`

- Vaciar casilla usuario:
  
  ​ `zmmailbox -z -m accoun@domain.com ef "/Inbox"`

- Ver correos de una carpeta
  
  ​ `zmmailbox -z -m cuenta@dominio.com search -l 100 "in:Inbox"`

- Ver metadata de un correo:
  
  ​ `zmmetadump -m cuenta@dominio.com -i id_mensaje`

- Borrar un mensaje
  
  ​ `zmmailbox -z -m cuenta@dominio.com dm id_mensaje`

### Referencias

- http://www.keopssoft.com/index.php/blog/zimbra/44-comandos-en-consola-en-zimbra

- https://soporte.itlinux.cl/hc/es/articles/200120768-Comandos-%C3%BAtiles-zimbraComandos para Zimbra
  
  Los comandos hay que ejecutarlo con el usuario zimbra
  
  ```bash
  su - zimbra
  ```
  
  ### Control de servicios
  
  | Nro. | Comando                                                                 | Descripción                                                                                       |
  | ---- | ----------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
  | 1    | zmcontrol status                                                        | verificar el estado de todos los servicios                                                        |
  | 2    | zmcontrol stop                                                          | detener todos los servicios                                                                       |
  | 3    | zmcontrol start                                                         | iniciar todos los servicios                                                                       |
  | 4    | zmcontrol restart                                                       | reiniciar todos los servicios                                                                     |
  | 5    | zmcontrol -v                                                            | versión de zimbra                                                                                 |
  | 6    | ldap start                                                              | Iniciar sólo el servicio LDAP                                                                     |
  | 7    | mysql.server start                                                      | Iniciar el servicio de MySQL                                                                      |
  | 8    | zmconfigdctl start                                                      | Iniciar zmconfigd                                                                                 |
  | 9    | zmmtactl start                                                          | Iniciar MTA (postfix, saslauthd)                                                                  |
  | 10   | zmamavisdctl start                                                      | Iniciar Amavis, Antivirus y AntiSpam (amavis, spamassassin, clamav)                               |
  | 11   | zmmailboxdctl start                                                     | Iniciar Mailbox (webmail, panel de administración, servidores imap y pop3, servidores de filtros) |
  | 12   | zmapachectl start`                                                      | Iniciar spell (servidor de ortografía)                                                            |
  | 13   | zmswatchctl start                                                       | Iniciar monitorización                                                                            |
  | 14   | zmstatctl start * Iniciar Logger (logs del sistema)zmlogswatchctl start | Iniciar estadísticas                                                                              |
  | 15   | Reiniciar solo el antivirus                                             | zmantivirusctl restart                                                                            |
  | 16   | zmantispamctl restart                                                   | Reiniciar solo el antispam                                                                        |
  
  ### Comando de administración
  
  @table
  
  | Nro. | Comando                                                                                           | Descripción                                |
  | ---- | ------------------------------------------------------------------------------------------------- | ------------------------------------------ |
  | 1    | zmprov help                                                                                       | Lista la ayuda general de zmprov           |
  | 2    | zmprov help acount                                                                                | Listar la ayuda para gestionar las cuentas |
  | 3    | zmprov`prov>` `Ver ayuda de cuentas`prov> help account`Salir de la consola interactiva`prov> quit | Consola Interactiva                        |
  
  ### Comandos para la administración certificados
  
  | Nro. | Comando                                   | Descripción                         |
  | ---- | ----------------------------------------- | ----------------------------------- |
  | 1    | /opt/zimbra/bin/zmcertmgr viewdeployedcrt | Ver fecha de caducidad certificados |
  
  ### Comandos para la administración de dominios
  
  | Nro. | Comando    | Descripción                  |
  | ---- | ---------- | ---------------------------- |
  | 1    | zmprov gad | Listar dominios configurados |
  
  ### Comandos para administración del servidor
  
  | Nro. | Comando                                                                                                 | Listar dominios configurados                                     |
  | ---- | ------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------- |
  | 1    | zmtlsctl both (http,https,both,mixed,redirect)                                                          | Cambiar la modalidad de acceso                                   |
  | 2    | zmprov ms `zmhostaname` zimbraMailPort 8081                                                             | Cambiar el puerto del webmail                                    |
  | 3    | zmprov ms `zmhostname` zimbraMtaMyNetworks "127.0.0.1/32 10.0.0.1/32 192.168.1.15/32"``zmmtactl restart | Añadir equipos o segmentos de ip en las redes de confianza (mta) |
  
  ### Comandos para cuentas
  
  | Nro. | Comando                                                                                                                                                                                           | Descripción                                                            |
  | ---- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------- |
  | 1    | zmprov -l gaa                                                                                                                                                                                     | Obtener listado de todas las cuentas del servidor (todos los dominios) |
  | 2    | zmprov -l gaaa                                                                                                                                                                                    | Obtener todas las cuentas de administración                            |
  | 3    | zmprov -l ga [usuario@midominio.com](mailto:usuario@midominio.com)                                                                                                                                | Obtener información de una sola cuenta                                 |
  | 4    | zmprov -l gaa midominio.com                                                                                                                                                                       | Cuentas de un dominio específico                                       |
  | 5    | zmprov -l gaa -v midominio.com                                                                                                                                                                    | Detalle de cuentas de un dominio especifico                            |
  | 6    | zmprov -l gaa -v midominio.com \                                                                                                                                                                  | grep -e zimbraMailDeliveryAddress -e displayName -e zimbraMailQuota \  |
  | 7    | zmprov ca [pepito@dominio.com](mailto:pepito@dominio.com) pepitopass displayName "Pepito Pérez"                                                                                                   | Crear una cuenta, con cos default                                      |
  | 8    | - cos=`zmprov gc gerente \                                                                                                                                                                        | grep zimbraId:\                                                        |
  | 9    | zmprov ca [windozero@dominio.com](mailto:windozero@dominio.com) passwinbugs cn 'Nombre(s) ApMaterno ApPaterno' displayName 'Nombre(s) ApMaterno ApPaterno' givenName 'Nombre(s)' zimbraCOSId $cos | Crear una cuenta con detalle                                           |
  | 10   | zmprov ra [usuario@dominio.com](mailto:usuario@dominio.com) usuariorenombrado@dominio.com                                                                                                         | Renombrar cuenta                                                       |
  | 11   | zmprov ma [account@domain.com](mailto:account@domain.com) zimbraAccountStatus (active,lockout,close)`                                                                                             | Modificar el estado de una cuenta                                      |
  | 12   | zmprov ga [account@domain.com](mailto:account@domain.com) \                                                                                                                                       | grep Quota                                                             |
  | 13   | zmprov gmi [account@domain.com](mailto:account@domain.com) \                                                                                                                                      | grep zimbraMailQuota                                                   |
  
  ### Modificar opciones de una cuenta
  
  | Nro. | Comando                                                                                                                                | Descripción                                                                           |
  | ---- | -------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
  | 1    | `zmprov sp usuario@midominio.com passnuevo`                                                                                            | Cambiar de password de una cuenta                                                     |
  | 2    | `zmprov ma usuario@midominio.com displayName "Luser Noob 1`                                                                            | Modificar un atributo de una cuenta                                                   |
  | 3    | `zmprov -l ga usuario1@midominio.com`                                                                                                  | se puede modificar cualquier atributo del usuario para la lista de atributos ejecutar |
  | 4    | `zmprov ma account@domain.com zimbraPrefBccAddress account@domain2.com`                                                                | Configurar un reenvio de correos salientes                                            |
  | 5    | `zmprov ma account@domain.com zimbraPrefMailForwardingAddress account2@domain2.com`                                                    | Configurar un forward                                                                 |
  | 6    | `zmprov ma account@domain.com zimbraMailForwardingAddress account2@domain2.com`                                                        | Configurar un forward oculto del usuario                                              |
  | 7    | `zmprov ma account@domain.com zimbraPasswordLockoutEnabled TRUE zimbraPasswordLockoutFailureLifetime 1h zimbraPasswordLockoutMaxFailu` | Configurar políticas de bloqueo de cuenta                                             |
  
  ### Búsqueda de cuentas
  
  | Nro. | Comando                                | Descripción                                                                 |
  | ---- | -------------------------------------- | --------------------------------------------------------------------------- |
  | 1    | `zmprov sa parametro=cadena`           | Búsqueda por atributos Se puede buscar las cuentas por un atributo en común |
  | 2    | `zmprov sa zimbraAccountStatus=active` | Buscar todas las cuentas activas                                            |
  | 3    | `zmprov sa zimbraAccountStatus=locked` | Buscar todas las cuentas bloqueadas                                         |
  | 4    | `zmprov gam cuenta@midominio.com`      | Buscar en cuales listas se encuentra una cuenta                             |
  
  ### Listas de correo
  
  | Nro. | Comando                                     | Descripción                            |
  | ---- | ------------------------------------------- | -------------------------------------- |
  | 1    | `zmprov gadl` <br>`zmprov gadl dominio.com` | Buscar todas las listas, y por dominio |
  
  - Crear una lista
    
    ​ `zmprov cdl lista@dominio.com`
  
  - Ver una lista específica
    
    ​ `zmprov gdl lista@dominio.com`
  
  - Encontrar todas las listas de un dominio y sus miembros
    
    ​ `for i in $( zmprov gadl dominio.com | grep -v abuse | grep -v postmaster | sort ) ; do echo`` ```zmprov gdl $i | grep -e 'mail: ' -e 'zimbraMailForwardingAddress: ' | sed 's/mail/Lista/' | sed 's/zimbraMailForwardingAddress: //'` ; done ;`
  
  - agregar un miembro a la lista
    
    ​ `zmprov adlm lista@dominio.com cuenta@dominio.com`
  
  - Remover un miembro de la lista
    
    ​ `zmprov rdlm lista@dominio.com cuenta@dominio.com`
  
  - Borrar una lista
    
    ​ `zmprov ddl lista@dominio.com`
  
  ### Buzones (zmmailbox)
  
  - Entrar a la consola interactiva
    
    ​ `$> zmmailbox``mbox>` `Ver ayuda general del comando``zmmailbox help` `Ver ayuda de las cuentas ``zmmailbox help account` `Ver ayuda de los mensajes``zmmailbox help message`
  
  - Ver tamaño ocupado del buzón
    
    ​ `zmmailbox -z -m cuenta@dominio.com gms`
  
  - Ver el tamaño de las quotas asignadas y ocupadas de todos los buzones
    
    ​ `zmprov gqu` zmhostname`|awk {'print " "$3" "$2" "$1'}`
  
  - Revisar mensajes por carpetas en el buzón
    
    ​ `zmmailbox -z -m cuenta@dominio.com gaf`
  
  - Borrar una carpeta completa de un buzón
    
    ​ `zmmailbox -z -m cuenta@dominio.com emptyFolder Junk`
  
  - Importar mensajes de una carpeta Maildir existente en el INBOX
    
    ​ `echo addMessage /INBOX /path/to/Maildir/cur | /opt/zimbra/bin/zmmailbox -z -m cuenta@dominio.com`
  
  - Buscar un mensaje
    
    ​ `zmmailbox -z -m cuenta@dominio.com search -t message "prueba"`
  
  - Buscar un mensaje en todas las cuentas
    
    ​ `zmprov -l gaa |awk '{print "zmmailbox -z -m "$1" search \"cadena a buscar\" "}' |sh -v`
  
  - Buscar correos anteriores a una fecha: (formato mes/dia/año)
    
    ​ `zmmailbox -z -m cuenta@dominio.com search -t message "in:INBOX (before: 12/19/13)"`
  
  - Obtener contenido de un correo
    
    ​ `zmmailbox -z -m cuenta@dominio.com gm id_delmensaje`
  
  - Ver contactos:
    
    ​ `zmmailbox -z -m cuenta@dominio.com gact | less`
  
  - Vaciar casilla usuario:
    
    ​ `zmmailbox -z -m accoun@domain.com ef "/Inbox"`
  
  - Ver correos de una carpeta
    
    ​ `zmmailbox -z -m cuenta@dominio.com search -l 100 "in:Inbox"`
  
  - Ver metadata de un correo:
    
    ​ `zmmetadump -m cuenta@dominio.com -i id_mensaje`
  
  - Borrar un mensaje
    
    ​ `zmmailbox -z -m cuenta@dominio.com dm id_mensaje`
  
  ### Referencias
  
  - [梅州市某某软件开发制造厂](http://www.keopssoft.com/index.php/blog/zimbra/44-comandos-en-consola-en-zimbra)
  - [Comandos útiles zimbra &ndash; Help Center](https://soporte.itlinux.cl/hc/es/articles/200120768-Comandos-%C3%BAtiles-zimbra)
