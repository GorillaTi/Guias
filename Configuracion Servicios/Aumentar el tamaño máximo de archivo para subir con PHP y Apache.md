# Aumentar el tamaño máximo de archivo para subir con PHP y Apache   

Cuando desarrollamos aplicaciones web en [PHP](http://vitaminaweb.com/tema/php/), corriendo bajo [Apache](http://vitaminaweb.com/tema/apache/), existe una limitación por defecto en el tamaño de los archivos que se  pueden subir desde el cliente (el navegador del usuario), que  normalmente es de 2 MB. Es decir, si queremos subir una imagen de 3 MB,  por ejemplo, el sistema nos devolvería un error a causa de este límite.

Ésto, a la hora de desarrollar ciertas aplicaciones web, como un blog con [WordPress](http://vitaminaweb.com/tema/wordpress/) en el que tengamos que subir fotos o vídeos de más de 2 MB, o un sitio  web corporativo donde los usuarios puedan enviar documentación a través  de un formulario, etc., se convierte en un problema, con fácil solución  como vemos a continuación.

Existen varias formas de evitar este  límite impuesto en una aplicación basada en PHP y Apache. Vamos a ver 2  formas de resolver esta limitación:

**1. Modificando el fichero de configuración php.ini global**

Primero de todo tenemos que localizar el archivo de configuración (global) de PHP (**php.ini**) que puede estar ubicado en diferentes rutas dependiendo del sistema  operativo o de la distribución Linux que usemos. Y una vez localizado,  tenemos que editarlo y modificar las siguientes líneas:

```
upload_max_filesize = 10M
post_max_size = 20M
max_execution_time = 180
```

Donde:

upload_max_filesize = 10M
 Aumenta el tamaño máximo del fichero a subir a 10 MB.

post_max_size = 20M
 Indica el tamaño máximo de carga por envío, que debe ser igual o mayor  al valor anterior. En este caso podríamos enviar varios ficheros en un  sólo envío, hasta una capacidad máxima de 20 MB.

max_execution_time = 180
 Tiempo máximo (en segundos) de ejecución de los scripts, que en nuestro  ejemplo sería de 3 minutos para realizar el total de la carga (subida)  de archivos.

Ahora sólo tenemos que guardar los cambios del fichero **php.ini** y reiniciar el servidor web Apache.