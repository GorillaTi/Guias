# Servidor DB SIGMA

---

- Saber el tamaño las carpetas
  
  ```bash
  du -sh /fichero o carpeta
  ```

- Eliminar los Archivos de BackUp
  
  ```bash
  cd /u05/flash_recovery_area/PROD/PROD/backupset
  ls
  rm -rfv 2020_09_23
  ```

- Eliminar los Archivos de Logs
  
  ```bash
  cd /u05/flash_recovery_area/PROD/PROD/archivelog
  ls
  rm -rfv 2020_09_23
  ```

- Limpiar oracle de los archivos residuales de logs
  
  ```bash
  su - oracle
  ```

- Ingresamos  a RMAN
  
  ```bash
  rman target /
  ```
  
  - ejecutamos la verificación y la limpieza
  
  ```sql
  crosscheck archivelog all;
  delete expired archivelog all;
  ```
  
  - salir de
  
  ```sql
  exit;
  ```

### Limpieza de Logs de DB

Ubicar directorio donde se encuentran alojados los archivos `.trc` 

```bash
find / -type f -iname "*.trc" 
```

Mostrar el tamaño total de los archivos `.trc`

```bash
find / -type f -iname "*.trc" | wc -l
```

Borramos los archivos encontrados

```bash
find /u01 -type f -iname "*.trc" -ctime +30 -exec rm -vrf {} \;
```

> **Nota.-** Los parámetros utilizados son:
> 
> type f : solo archivos.
> 
> iname : no distingue entre minúsculas  o mayúsculas
> 
> mtime : modificado o (atime = accedido, ctime = creado)
> 
> -30 : menos de 30 días (30 exactamente 30 días, +30 más de 30 días)
> 
> -exec rm -vrf {} \; :  elimina cualquier archivo que coincida con la configuración anterior.
