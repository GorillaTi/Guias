###################################################################################
GUIA DE INSTALACIOIN DNS SERVIDORES DEBIAN CORES

Versión 1.0
Nivel: Todos
Área: Data Center
Elaborado por Edmundo Cespedes
Tecnico Responsable Data Center, GAMS
Email: ed.cespedesa@gmail.com
###################################################################################
1.- Identificar la interfaz de Red
$ 
8.- 

ss -ltun | grep named

#
#

comprobar estado del registro en los DNS

```bash
nslookup -type=ns tudominio.com
```