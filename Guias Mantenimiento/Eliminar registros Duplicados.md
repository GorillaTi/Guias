Como vemos, tenemos repetido «**love**» y «**asdasd**«, este último 3 veces. **¿cómo eliminar las líneas duplicadas?**

Para hacerlo es simple, con este comando:

```
cat pass.txt | sort | uniq > pass-listos.txt
```

Lo que hace el comando es MUY simple…

1. **cat pass.txt** -» Lista el contenido del archivo.
2. [**sort**](https://blog.desdelinux.net/con-la-terminal-ordenar-alfabeticamente-el-contenido-lineas-de-un-archivo/) -» Ordena el contenido alfabéticamente.
3. **uniq** -» Elimina las líneas duplicadas.
4. **> pass-listos.txt** -» El resultado de los comandos anteriores, ponlo en el archivo pass-listos.txt (*que, como no existe, lo creará*)