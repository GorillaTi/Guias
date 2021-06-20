# tmux atajos & cheatsheet

iniciar nuevo:

```
tmux
```

iniciar nuevo con nombre de sesión:

```
tmux new -s myname
```

Volver a la sesión por numero:

```
tmux a  #  (or at, or attach)
```

Volver a la sesión por nombre:

```
tmux a -t myname
```

listar las sesiones:

```
tmux ls
```

matar la sesión:

```
tmux kill-session -t myname
```

Matar todas sesiones de tmux:

```
tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0, length($1)-1)}' | xargs kill
```

En tmux, presione el atajo `ctrl+b` (mi atajo modificado es `ctrl+a`) y luego:

## Listado de todos los atajos

para ver todas las teclas de atajo en tmux simplemente use la `bind-key?` en mi caso sería `CTRL-B?` 

## Sesiones

```
:new<CR>  new session
s  list sessions
$  name session
```

## Windows (pestañas)

```
c  create window
w  list windows
n  next window
p  previous window
f  find window
,  name window
&  kill window
```

## Paneles (divisiones) 

```
%  vertical split
"  horizontal split
o  swap panes
q  show pane numbers
x  kill pane
+  break pane into window (e.g. to select text by mouse to copy)
-  restore pane from window
⍽  space - toggle between layouts
<prefix> q (Show pane numbers, when the numbers show up type the key to goto that pane)
<prefix> { (Move the current pane left)
<prefix> } (Move the current pane right)
<prefix> z toggle pane zoom
```

## Sincronizar Paneles

Puede hacer esto cambiando a la ventana apropiada, escribiendo su prefijo Tmux (comúnmente `Ctrl-B ` o `Ctrl-A`) y luego dos puntos para abrir una línea de comando Tmux, y escribiendo::

```
:setw synchronize-panes
```

Opcionalmente, puede agregar encendido o apagado para especificar qué estado desea; de lo contrario, la opción simplemente se alterna. Esta opción es específica de una ventana, por lo que no cambiará la forma en que operan sus otras sesiones o ventanas. Cuando haya terminado, vuelva a desactivarlo repitiendo el comando. [fuente de sugerencia] (http://blog.sanctum.geek.nz/sync-tmux-panes/)

## Cambiar el tamaño de los paneles 

También puede cambiar el tamaño de los paneles si no le gustan los valores predeterminados de diseño. Personalmente, rara vez necesito hacer esto, aunque es útil saber cómo. Aquí está la sintaxis básica para cambiar el tamaño de los paneles: 

```
PREFIX : resize-pane -D (Resizes the current pane down)
PREFIX : resize-pane -U (Resizes the current pane upward)
PREFIX : resize-pane -L (Resizes the current pane left)
PREFIX : resize-pane -R (Resizes the current pane right)
PREFIX : resize-pane -D 20 (Resizes the current pane down by 20 cells)
PREFIX : resize-pane -U 20 (Resizes the current pane upward by 20 cells)
PREFIX : resize-pane -L 20 (Resizes the current pane left by 20 cells)
PREFIX : resize-pane -R 20 (Resizes the current pane right by 20 cells)
PREFIX : resize-pane -t 2 20 (Resizes the pane with the id of 2 down by 20 cells)
PREFIX : resize-pane -t -L 20 (Resizes the pane with the id of 2 left by 20 cells)
```

## Modo de Copia:

Presionar PREFIX `[`  nos coloca en modo de copia. Luego podemos usar nuestras teclas de movimiento para mover nuestro cursor por la pantalla. De forma predeterminada, las teclas de flecha funcionan. configuramos nuestro archivo de configuración para usar las teclas Vim para moverse entre ventanas y cambiar el tamaño de los paneles para no tener que quitar las manos de la fila de inicio. Tmux también tiene un modo vi para trabajar con el búfer. Para habilitarlo, agregue esta línea a `.tmux.conf` : 

```
setw -g mode-keys vi
```

Con esta opción establecida, podemos usar h, j, k y l para movernos por nuestro búfer.

Para salir del modo Copiar, simplemente presionamos la tecla ENTER. Moverse un personaje a la vez no es muy eficiente. Dado que habilitamos el modo vi, también podemos usar algunos otros atajos visibles para movernos por el búfer.

Por ejemplo, podemos usar "w" para saltar a la siguiente palabra y "b" para saltar una palabra hacia atrás. Y podemos usar "f", seguida de cualquier carácter, para saltar a ese carácter en la misma línea, y "F" para saltar hacia atrás en la línea. 

```
   Function                vi             emacs
   Back to indentation     ^              M-m
   Clear selection         Escape         C-g
   Copy selection          Enter          M-w
   Cursor down             j              Down
   Cursor left             h              Left
   Cursor right            l              Right
   Cursor to bottom line   L
   Cursor to middle line   M              M-r
   Cursor to top line      H              M-R
   Cursor up               k              Up
   Delete entire line      d              C-u
   Delete to end of line   D              C-k
   End of line             $              C-e
   Goto line               :              g
   Half page down          C-d            M-Down
   Half page up            C-u            M-Up
   Next page               C-f            Page down
   Next word               w              M-f
   Paste buffer            p              C-y
   Previous page           C-b            Page up
   Previous word           b              M-b
   Quit mode               q              Escape
   Scroll down             C-Down or J    C-Down
   Scroll up               C-Up or K      C-Up
   Search again            n              n
   Search backward         ?              C-r
   Search forward          /              C-s
   Start of line           0              C-a
   Start selection         Space          C-Space
   Transpose chars                        C-t
```

## Misc

```
d  detach
t  big clock
?  list shortcuts
:  prompt
```

## Opciones de Configuración:

```
# Mouse support - set to on if you want to use the mouse
* setw -g mode-mouse off
* set -g mouse-select-pane off
* set -g mouse-resize-pane off
* set -g mouse-select-window off

# Set the default terminal mode to 256color mode
set -g default-terminal "screen-256color"

# enable activity alerts
setw -g monitor-activity on
set -g visual-activity on

# Center the window list
set -g status-justify centre

# Maximize and restore a pane
unbind Up bind Up new-window -d -n tmp \; swap-pane -s tmp.1 \; select-window -t tmp
unbind Down
bind Down last-window \; swap-pane -s tmp.1 \; kill-window -t tmp
```

## Recursos:

- [tmux: Productive Mouse-Free Development](http://pragprog.com/book/bhtmux/tmux)
- [How to reorder windows](http://superuser.com/questions/343572/tmux-how-do-i-reorder-my-windows)
