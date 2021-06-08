# tmux atajos & cheatsheet

iniciar nuevo:

```
tmux
```

iniciar nuevo con nombre de sesión:

```
tmux new -s myname
```

agregar:

```
tmux a  #  (or at, or attach)
```

agregar nombre:

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

matar tolas sesiones de tmux:

```
tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0, length($1)-1)}' | xargs kill
```

En tmux, presione el atajo `ctrl+b` (mi atajo midificado es `ctrl+a`) y luego:

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

## 

## Copy mode:

Pressing PREFIX [ places us in Copy mode. We can then use our  movement keys to move our cursor around the screen. By default, the  arrow keys work. we set our configuration file to use Vim keys for  moving between windows and resizing panes so we wouldn’t have to take  our hands off the home row. tmux has a vi mode for working with the  buffer as well. To enable it, add this line to .tmux.conf:

```
setw -g mode-keys vi
```

With this option set, we can use h, j, k, and l to move around our buffer.

To get out of Copy mode, we just press the ENTER key. Moving around  one character at a time isn’t very efficient. Since we enabled vi mode,  we can also use some other visible shortcuts to move around the buffer.

For example, we can use "w" to jump to the next word and "b" to jump  back one word. And we can use "f", followed by any character, to jump to that character on the same line, and "F" to jump backwards on the line.

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

## 

## Misc

```
d  detach
t  big clock
?  list shortcuts
:  prompt
```

## 

## Configurations Options:

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

## 

## Resources:

- [tmux: Productive Mouse-Free Development](http://pragprog.com/book/bhtmux/tmux)
- [How to reorder windows](http://superuser.com/questions/343572/tmux-how-do-i-reorder-my-windows)

## 

## Notes:

- 

## 

## Changelog:

- 1411143833002 - Added [toggle zoom](https://gist.github.com/GorillaTi/50237d1f9cc038d111ff7589f4ad11d4#PanesSplits) under Panes (splits) section.
- 1411143833002 - [Added Sync Panes](https://gist.github.com/GorillaTi/50237d1f9cc038d111ff7589f4ad11d4#syncPanes)
- 1414276652677 - [Added Kill all tmux sessions ](https://gist.github.com/GorillaTi/50237d1f9cc038d111ff7589f4ad11d4#killAllSessions)
- 1438585211173 - [corrected create and add next and previus thanks to @justinjhendrick](https://gist.github.com/GorillaTi/50237d1f9cc038d111ff7589f4ad11d4#WindowsTabs)

## 

## Request an Update:

We Noticed that our Cheatsheet is growing and people are coloberating to add new tips and tricks, so please tweet to me what would you like  to add and let's make it better!

- Twitter: [@MohammedAlaa](http://twitter.com/MohammedAlaa)