Remover posibles instalaciones antiguas
$ sudo apt-get remove docker docker-engine docker.io containerd runc
Actualizar e instalar depéndencias necesarias par docker
$ sudo apt-get update
$ sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
Adicionamos la Docker’s official GPG key:
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
Adicionamos el repositorio de Docker


$ sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
Actualizamos e instalamos Docker
$ sudo apt-get update
$ sudo apt-get install docker-ce docker-ce-cli containerd.io
Probamos
$ sudo docker run hello-world
Materialñ de refencia en
https://docs.docker.com/engine/install/ubuntu/
