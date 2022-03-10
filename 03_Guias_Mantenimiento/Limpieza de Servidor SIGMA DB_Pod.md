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
  exit
  ```
