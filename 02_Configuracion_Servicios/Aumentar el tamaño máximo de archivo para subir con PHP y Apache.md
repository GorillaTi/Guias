Guía de:

# Aumentar el tamaño máximo de archivo para subir con PHP y Apache

## ACERCA DE:

Versión: 1.0.1

Nivel: Medio

Área: CPD

Elaborado por: Edmundo Céspedes Ayllón

E-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---

Cuando se desarrollan aplicaciones web en PHP, corriendo bajo Apache, existe una limitación por defecto en el tamaño de los archivos que se  pueden subir desde el cliente , que normalmente es de 2 MB. Es decir, si queremos subir una imagen de 3 MB,  por ejemplo, el sistema nos devolvería un error a causa de este límite.

Esto, a la hora de desarrollar ciertas aplicaciones web, como un blog en WordPress en el que tengamos que subir fotos o vídeos de más de 2 MB, o un sitio  web corporativo donde los usuarios puedan enviar documentación a través  de un formulario, etc., se convierte en un problema, con fácil solución como vemos a continuación.

## 1. Modificando el fichero de configuración php.ini global

Localizar el archivo de configuración (global) de PHP (**php.ini**) que puede estar ubicado en diferentes rutas dependiendo del sistema  operativo o de la distribución Linux que usemos.

```bash
sudo find / -name archivo.buscado
```

Realizamos una copia de seguridad del archivo php.ini

```bash
sudo cp -pfv [ruta_encontrada]/php.ini [ruta encontrada]/php.ini.bkp
```

Editamos el archivo de configuración.

```bash
sudo vim [ruta_encontrada]/php.ini
```

Modificamos las siguientes lineas con el valor recomendado y guardamos los cambios.

```shell-session
upload_max_filesize = 10M
post_max_size = 20M
max_execution_time = 180
```

> **Nota:**

> `upload_max_filesize = 10M`  Aumenta el tamaño máximo del fichero a subir a 10 MB.

> `post_max_size = 20M`  Indica el tamaño máximo de carga por envío, que debe ser igual o mayor  al valor anterior. En este caso podríamos enviar varios ficheros en un  sólo envío, hasta una capacidad máxima de 20 MB.

> `max_execution_time = 180`  Tiempo máximo (en segundos) de ejecución de los scripts, que en nuestro  ejemplo sería de 3 minutos para realizar el total de la carga (subida)  de archivos.

Reiniciamos el servicio de Apache

Debian y derivados

```bash
sudo systemctl restart apache2
```

RHEL y derivados

```bash
sudo systemctl restart httpd
```

## 2. Utilizar .htaccess

Otra forma de ampliar el tamaño máximo de los ficheros a subir es indicándolo mediante un fichero de configuración de Apache **.htaccess** . Tenemos que crear o modificar el fichero **.htaccess** en la raíz del sitio web (lo que sería recursivo para todos los  subdirectorios de la web), o en el directorio en el que quieres que  tenga efecto (su efecto sería recursivo para los subdirectorios *hijos* de éste), y colocar las siguientes líneas:

```shell-session
php_value upload_max_filesize 10M
php_value post_max_size 20M
php_value max_execution_time 180
```