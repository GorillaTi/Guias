Guía de:

# Recuperación de Password  de Root

---

## ACERCA DE:

Versión: 1.0.0

Nivel: Todos

Área: CPD

Elaborado por: Edmundo Cespedes Ayllon

Email: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

---

1. Reiniciamos el equipo

2. Una vez en el gestor de arranque `Grub` pulsamos la tecla `e`

3. Una vez dentro del archivo de arranque buscamos la línea que comience con `linix`

4. al final de la línea insertamos el siguiente código

   ```bash
   rw init=/bin/bash
   ```

5. Luego pulsamos la tecla `F10`

6. Una vez dentro de la consola de comando procedemos a cambiar el password de root con el comando

   ```bash
   passwd
   ```

7. Introducimos el nuevo pasword

8. Reiniciamos el equipo manualmente.
