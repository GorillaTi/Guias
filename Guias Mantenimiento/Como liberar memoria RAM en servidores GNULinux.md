1. Limpiar la caché solamente:

# sync; echo 1 > /proc/sys/vm/drop_caches

2. Limpiar dentries e inodos:

# sync; echo 2 > /proc/sys/vm/drop_caches

3. Limpiar caché, dentries e inodes.

# sync; echo 3 > /proc/sys/vm/drop_caches

Veamos qué es cada cosa.
sync limpiará el búfer del sistema de archivos.
El carácter “;” se ejecuta secuencialmente. El shell espera a que cada comando termine antes de ejecutar el siguiente comando de la secuencia.
Como se menciona en la documentación del núcleo, escribir drop_cache limpiará la caché sin matar ninguna aplicación/servicio
echo está haciendo el trabajo de escribir en un archivo.
Si tienes que vaciar la caché de disco, el primer comando es el más seguro en una empresa y producción, ya que “…echo 1 > ….” sólo vaciará PageCache. No se recomienda utilizar la tercera opción “…echo 3 >” en producción hasta que sepas lo que estás haciendo, ya que borrarás PageCache, dentries e inodes.
¿Es una buena idea liberar Buffer y Cache en GNU/Linux que pueda ser usado por el Kernel de Linux?
Cuando estés aplicando varias configuraciones y quieras comprobar si están implementadas especialmente en el benchmark I/O-extensivo, es posible que necesites borrar la caché del búfer. Puedes dejar caer la caché como se explicó anteriormente sin reiniciar el sistema, es decir, sin necesidad de tiempo de inactividad.
GNU/Linux está diseñado de tal manera que mira en la caché del disco antes de mirar en el disco. Si encuentra el recurso en la caché, la petición no llega al disco. Si limpiamos la caché, la caché de disco será menos útil ya que el S.O. buscará el recurso en el disco.
Además, también ralentizará el sistema durante unos segundos mientras se limpia la caché y todos los recursos requeridos por el sistema operativo se cargan de nuevo en la caché de disco.

//SCRIPT//
Ahora vamos a crear un script de shell para borrar automáticamente la caché de RAM diariamente a las 2:00 a través de una tarea de cron.

Crea un archivo de comandos de shell limpiarcache.sh y añade las siguientes líneas:

#!/bin/sh
# Autor: ECA
# Licencia: GNU GPLv3
# Limpiar es un script para limpiar la caché y liberar memoria
# Parametros: 
#	1 entorno produccion
#	2
#	3 limpieza profunda NO RECOMENDADA
sync ; echo 1 > /proc/sys/vm/drop_caches ; echo "RAM Liberada"

Establece el permiso de ejecución en el archivo limpiarcache.sh.

# chmod 755 limpiarcache.sh

Ahora puedes llamar al script siempre que lo necesites para borrar la caché de RAM.
Ahora configura un cron para que borre la caché de RAM todos los días a las 2:00. Abre la pestaña crontab para editar.

# crontab -e

Añade la línea de abajo, guarda y sal para ejecutarla a las 2:00 diariamente.

0  2  *  *  *  /ruta/a/limpiarcache.sh

¿Es buena idea borrar automáticamente la caché de RAM en el servidor de producción?
¡No! No lo es. Piensa en una situación en la que hayas programado el script para borrar la caché de memoria RAM todos los días a las 2 de la mañana. Todos los días a las 2 de la mañana se ejecuta el script y se vacía la caché de RAM. Un día, por la razón que sea, puede haber más usuarios de los esperados en línea en tu sitio web gastando recursos en tu servidor.
Al mismo tiempo, el script se ejecuta y borra todo en la caché. Ahora todos los usuarios están obteniendo datos del disco. Esto resultará en un fallo del servidor y dañará la base de datos. Así que limpia la caché de memoria RAM sólo cuando sea necesario.
Ahora bien, ¿cómo hacemos para liberar la memoria swap?

# swapoff -a && swapon -a

También puedes añadir el comando anterior a un script cron anterior, después de entender todo el riesgo asociado.
Ahora combinaremos los dos comandos anteriores en un solo comando para crear un script adecuado para borrar la caché de RAM y el espacio de intercambio.

# echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a && printf '\n%s\n' 'Caché de RAM y Swap liberadas'
O bien
$ su -c "echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\n%s\n' 'Caché de RAM y Swap liberadas'" root

Después de probar ambos comandos, ejecutaremos el comando “free -h” antes y después de ejecutar el script y comprobaremos la caché.
