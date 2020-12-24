## Liberar Memoria RAM
---
### Ver Memoria RAM y SWAP Usada en tiempo real
```bash
$> watch -n 1 free -m
```

### Comando por terminal para liberar CACHE
**Nota:** CUIDADO ELIMINA TODO CON EL PARÁMETRO 3; OPCIONAL 1(Entorno PRODUCCIÓN);2 Limpieza Media 

```bash
$> sudo sync && sudo sysctl -w vm.drop_caches=3
```

- Creación del Script

```bash
$> sudo nano /Home/usuario/limpiar
```

​	o

```bash
$> /usr/local/bin/limpiar
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
sync ; echo 1 > /proc/sys/vm/drop_caches ; echo "RAM Liberada"
```
- Dando los permisos de ejecución

```bash
$> sudo chmod a+x /usr/local/bin/limpiar
```

- Ejecutar del Script limpiar

```bash
$> sudo limpiar
```
