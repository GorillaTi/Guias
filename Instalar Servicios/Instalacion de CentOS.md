Instalar SO siguiendo las instrucciones del instalador

configurar la red y el nombre del equipo
#nmtui

Actulizamos el SO
#yum update
#yum -y upgrade

Repositorio de paquetes de Fedora
# yum -y install epel-release

Instalar paquetes adicionales el net-tools y para DNS bind-utils
#yum -y install net-tools bind-utils

Revisamos los Puertos abiertos
#netstat -nputa|grep :53
