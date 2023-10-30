Guía de: 

# PostgreSQL

------

## ACERCA DE:

Versión: 2.0.0

Nivel: Medio

Área: CPD

Elaborado por: Edmundo Céspedes Ayllón

E-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

-----

## Instalación de PostgreSQL

### RedHat / CentOS / Alma Linux / Roky Linux

#### Desde el Repositorio Local

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

#### Desde el Repositorio Oficial

- Instalar el repositorio EPEL
  
  ```shell
  dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
  ```

- Instalar el repositorio de PostgreSQL
  
  ```shell
  dnf -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-8-x86_64/pgdg-redhat-repo-latest.noarch.rpm
  ```

- Se activa el repositorio PowerTool
  
  ```shell
  dnf config-manager --set-enabled PowerTools
  ```

- Se desactiva los repositorios locales
  
  ```shell
  dnf -qy module disable postgresql
  ```

- Instalar PostgreSQL conforme a la versión requerida
  
  ```shell
  sudo dnf install -y postgresql11-server postgresql11-contrib
  ```

#### Comprobando la instalación

- Listado los paquetes instalados
  
  ```shell
  rpm -qa | grep postgresql
  ```

- Revision de la versión de PostgreSQL instalado
  
  ```shell
  postgres -V
  ```
  
  o
  
  ```shell
  postgres --version
  ```

        **Nota.-** No ejecutar con usuario root

#### Iniciando los servicios

- Iniciamos la base de datos de PostgreSQL
  
  Con repositorio local
  
  ```shell
  sudo postgresql-setup --initdb
  ```
  
  Con repositorio oficial
  
  ```shell
  /usr/pgsql-11/bin/postgresql-11-setup initdb
  ```

### Debian / Ubuntu

#### Desde el repositorio oficial

- Actualizando sistema operativo
  
  ```shell
  sudo apt update
  ```

- Instalar paquetes necesarios
  
  ```shell
  sudo apt -y install gnupg2
  ```

- Instalando la llave GPG de repositorio
  
  ```shell
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
  ```

- Agregando el repositorio oficial
  
  ```bash
  echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list
  ```

- Actualizando sistema operativo
  
  ```shell
  sudo apt update
  ```

- Instalar el servicio de PostgreSQL
  
  ```shell
  sudo apt -y install postgresql-12 postgresql-client-12
  ```

### Configuramos el Servicio

- Configuramos el inicio automático del servicio
  
  ```shell
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
  host all all 192.168.0.0/24    md5
  ```
  
  o
  
  ```
  host all all 0.0.0.0/0    md5
  ```

- Reiniciamos PostgreSQL
  
  ```bash
  systemctl restart postgresql
  ```
  
  Verificamos el estado de PostgreSQL
  
  ```bash
  systemctl status postgressql
  ```

## Cambiando password del usuario postgres

- Conectarse a PostgreSQL
  
  ```bash
  sudo su postgres
  ```

- Iniciamos la consola de PostgreSQL
  
  ```bash
  psql
  ```

- Cambiamos la contraseña del usuario `postgres`
  
  ```sql
  alter user postgres with password ‘passwd’;
  ```
  
  o
  
  ```sql
  \password
  ```

- Salir de PostgreSQL
  
  ```sql
  \q
  ```

## Configuraciones del Firewall

Configurando firewall en:

### RedHat / CentOS / Alma Linux / Roky Linux

- Configurar la política en el `firewall`
  
  ```shell
  sudo firewall-cmd --permanent --zone=public --add-port=5432/tcp
  ```
  
  o
  
  ```shell
  sudo firewall-cmd --permanent --zoone=public --add-service=postgresql
  ```

- Reiniciamos el Firewall
  
  ```bash
  sudo firewall-cmd --reload
  ```

- Verificamos el estado de la configuración
  
  ```bash
  sudo firewall-cmd --list-all
  ```

### Debian / Ubuntu

- Configurando la política en `ufw`
  
  ```shell
  sudo ufw allow 5432/tcp
  ```

- Verificamos la creación
  
  ```shell
  sudo ufw status
  ```