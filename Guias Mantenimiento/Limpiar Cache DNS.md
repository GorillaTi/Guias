Revisar el estado de systemd-resolve.service
$sudo systemctl isa active systemd-resolve.service

Ver las estadisticas de cache DNS
$sudo systemd-resolve --statistics

Limpiamos la cache de DNS
$sudo systemd-resolve --flush-cache

verificamos la limpíeza
$sudo sytemd-resolve --statistics

Reinicimos Nscd (name service cache daemon)
$sudo systemctl restart nscd.service
o
$sudo service nscd restart
o
$sudo /etc/init.d/nscd restart

Limpiamos BIND/named cache
$sudo systemctl restart named
o
$sudo service named reload
o
$$sudo /etc/init.d/named restart
o
$sudo rndc reload
o
$sudo rndc exec

para un sitio en especifico
sudo rndc flushname ejemplo.com

para limpiar la cache DNS dentro de una LAN o una WAN

$sudo endc flush lan
$sudo endc flush wan

limpiar Dnsmasq DNS caching service
$sudo systemctl restart dnsmasq

paradebian y otros derivados
$sudo /etc/init.d/dns-clean restart
