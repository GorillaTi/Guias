# Instalacion de ProsgreSQL









# Habilitar acceso remoto

- Editamos el archivo

  ~~~ bash
  sudo nano /var/lib/pgsql/data/pg_hba.con
  ~~~

- Cambiamos o insertamos la línea

  ```bash
  host all all 192.168.0.0/24	md5
  ```

- Reiniciamos PostgreSQL

  ```bash
  systemctl restart postgresql
  ```

  Verificamos el estado de PostgreSQL

  ```bash
  systemctl status postgressql
  ```