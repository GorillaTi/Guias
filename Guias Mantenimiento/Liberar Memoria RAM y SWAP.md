Guía de Configuración

# Liberar Memoria RAM y SWAP
## ACERCA DE:
Versión: 1.0
Fecha: 01-12-2020
Nivel: Todos
Área: Data Center
Elaborado por: Edmundo Cespedes Ayllon
Técnico Encargado Data Center - GAMS
Email: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---
- Ver Memoria RAM y SWAP Usada en tiempo real
```bash
watch -n 1 free -m
```
- Comando por terminal para liberar CACHE

  **Nota:** Parámetros:  1 (Entorno PRODUCCIÓN)

  ​								2 Limpieza Media 

  ​								3 Limpieza Total (no recomendado para producción)
```bash
sudo sync && sudo sysctl -w vm.drop_caches=1
```

**1.** Limpiar la caché solamente:

```bash
sync; echo 1 > /proc/sys/vm/drop_caches
```

**2.** Limpiar dentries e inodos:

```bash
sync; echo 2 > /proc/sys/vm/drop_caches
```

**3.** Limpiar caché, dentries e inodes.

```bash
sync; echo 3 > /proc/sys/vm/drop_caches 
```

* Veamos qué es cada cosa.

**sync** limpiará el búfer del sistema de archivos. El  carácter “;” se ejecuta secuencialmente. El shell espera a que cada  comando termine antes de ejecutar el siguiente comando de la secuencia.  Como se menciona en la documentación del núcleo, escribir **drop_cache** limpiará la caché sin matar ninguna aplicación/servicio, el comando **echo** está haciendo el trabajo de escribir en un archivo.

Si tienes que vaciar la caché de disco, el primer comando es el más seguro en una empresa y producción, ya que “…**echo 1 >** ….” sólo vaciará PageCache. No se recomienda utilizar la tercera opción “…**echo 3 >**” en producción hasta que sepas lo que estás haciendo, ya que borrarás PageCache, dentries e inodes.

- Creación del Script

```bash
sudo nano /Home/usuario/limpiar
```

o

```bash
sudo nano /usr/local/bin/limpiar
```

- Contenido del Script

```bash
#!/bin/bash
# Autor: Tu nombre
# Licencia: GNU GPLv3
# Limpiar es un script para limpiar la caché y liberar memoria
# Parametros: 
#	1 entorno produccion
#	2 limpieza media
#	3 limpieza profunda NO RECOMENDADA
sync;
echo 1 > /proc/sys/vm/drop_caches;
echo "RAM Liberada";
```
- Dando los permisos de ejecución

```bash
sudo chmod a+x /usr/local/bin/limpiar
```

o

```bash
sudo chmod 755 /usr/local/bin/limpiar
```

- Ejecutar del Script limpiar

```bash
sudo limpiar
```

- configurando crontab

  ```bash
  crontab -e
  ```

  añadimos la configuración para que se ejecute la limpieza

  ```bash
  0  2  *  *  *  /ruta/a/limpiarcache.sh
  ```

  Liberar memora SWAP

  ```bash
  swapoff -a && swapon -a
  ```

- Script combinada para liberar RAM y SWAP

  ```
  # echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a && printf '\n%s\n' 'Caché de RAM y Swap liberadas'
  
  O bien
  
  $ su -c "echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\n%s\n' 'Caché de RAM y Swap liberadas'" root
  ```