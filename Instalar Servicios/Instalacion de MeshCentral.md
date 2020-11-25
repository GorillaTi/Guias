# Instalación de MeshCentral

Actualizamos el sistema operativo
sudo apt update && sudo apt upgrade -y
Instalamos los pre requisitos
sudo add-apt-repository universesudo 
apt update
sudo apt install nodejs -y
sudo apt install npm -y

verificamos las versiones instaladas

node –v

npm -v

## Instalamos MongoDB

Intsalamos MongoDB

sudo apt install mongodb -y

Si no instala procedemos a buscar el paquete

sudo  apt-cache search mongodb

sudo apt search mongodb

en caso de no encontrar el paquete recurrir  al manual de MongoDB

https://docs.mongodb.com/manual/tutorial/install-mongodb-on-debian/

iniciamos el servicio de MongoDB

sudo systemctl start mongod

sudo systemctl satus mongod

sudo systemctl enable mongod

Probamos para ingresar a MongoDB

mongo --host 127.0.0.1:27017

exit

