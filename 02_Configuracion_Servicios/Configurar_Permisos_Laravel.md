Guía de:

# Configurar Permisos de Laravel

## ACERCA DE:

Versión: 1.0.0

Nivel: Medio

Área: C.P.D.

Elaborado por: Edmundo Céspedes Ayllón

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---

## Servidor web como propietario (Forma General)

Suponiendo que www-data es su usuario de servidor web.

```bash
sudo chown -R www-data:www-data /path/to/your/laravel/root/directory
```

El servidor web tendra problemas para subier archivos atravez de FTP. 

Agraemamos al ususario al grupo `www-data`

```bash
sudo usermod -a -G www-data [usuario]
```

Cambiamos los permiso a los directorios (755) y archivos (644)

```bash
sudo find /path/to/your/laravel/root/directory -type d -exec chmod 755 {} \;
```

```bash
sudo find /path/to/your/laravel/root/directory -type f -exec chmod 644 {} \; 
```

## El suario como propietario

Cambiamos el propietario de los directorios

```bash
sudo chown -R $USER:www-data [path_laravel_directory]
```

Cambiamos los permiso a los directorios (755 o rwx-rx-rx ) y archivos (644 o rw-r-r)

```bash
sudo find [path_laravel_directory] -type d -exec chmod 755 {} \;
```

```bash
sudo find [path_laravel_directory] -type f -exec chmod 644 {} \;
```

Cambiamoslos derechos de ller y escribir en almacenamiento y cache

```bash
sudo chgrp -R www-data storage bootstrap/cache
```

```bash
sudo chmod -R ug+rwx storage bootstrap/cache
```

Por motivos de seguridad los directorios storage y vendor deben tener permisos 775

```bash
sudo chmod -R 775 /var/www/html/cerberus/storage/
sudo chmod -R 775 /var/www/html/cerberus/vendor
```
