Guía de: 

# PostgreSQL

------

## ACERCA DE:

Versión: 1.1.0

Nivel: Medio

Área: CPD

Elaborado por: Edmundo Céspedes Ayllón

E-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

-----

## Instalación de PostgreSQL
- Actualizamos el sistema operativo
  ```bash
  sudo dnf update
  ```
  
- Buscamos  el paquete a instalar
  ```bash
  dnf search postgresql-server
  ```
  
- Instalamos PostgreSQL
  ```bash
  sudo dnf install -y postgresql-server postgresql-contrib
  ```
  
- Verificamos la Instalación
  ```bash
  postgres -V
  ```
  
  o
  
  ```bash
  poatgres --version
  ```
  
  **Nota.-** No ejecutar con usuario root
  
- Iniciamos la base de datos de PostgreSQL
  
  ```bash
  sudo postgresql-setup --initdb --unit postgresql
  ```
  
- Configuramos el inicio automático del servicio
  ```bash
  systemctl enable postgresql
  ```
  
- Iniciamos el servicio
  ```bash
  systemctl start postgresql
  ```
  
- Verificamos el estado del servicio
  ```bash
  systemctl status postgresql
  ```
  
- Configuramos el inicio automático del servicio
  ```bash
  systemctl enable postgresql
  ```

## Habilitar acceso remoto

- Buscamos el archivo de configuración
  ```bash
  sudo find / -name postgresql.conf
  ```
- Editamos el archivo postgresql.conf
    ```bash
  sudo nano /var/lib/pgsql/data/postgresql.conf
  ```
- Buscamos y des-comentamos la linea que sigue
  ```
  listen_addresses = '*'
  ```
  o
  ```
  listen_addresses = '0.0.0.0'
  ```
- Editamos el archivo
  ```bash
  sudo nano /var/lib/pgsql/data/pg_hba.conf
  ```
- Cambiamos o insertamos la línea
  ```
  host all all 192.168.0.0/24	md5
  ```
  o
  ```
  host all all 0.0.0.0/0	md5
  ```
- Reiniciamos PostgreSQL
  ```bash
  systemctl restart postgresql
  ```
  Verificamos el estado de PostgreSQL
  ```bash
  systemctl status postgressql
  ```

## Conectarse a PostgreSQL

- Conectarse a PostgreSQL

  ```bash
  sudo su postgres
  ```
  
- Iniciamos la consola de PostgreSQL

  ```bash
  psql
  ```

- Cambiamos la contraseña del usuario postgres

  ```sql
  alter user postgres with password ‘passwd’;
  ```

  o

  ```sql
  \password
  ```

- salimos de PostgreSQL

  ```sql
  \q
  ```
  
- Habilitamos la salida por el Firewall
  
  ```bash
  sudo firewall-cmd --permanent --zone=public --add-port=5432/tcp
  ```

- Reiniciamos el Firewall

  ```bash
  sudo firewall-cmd --reload
  ```

- Verificamos el estado de la configuración

  ```bash
  sudo firewall-cmd --list-all
  ```