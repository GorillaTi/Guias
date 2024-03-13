Guía de:

# Instalación de Docker

### ACERCA DE:

Versión: 3.0.0

Nivel: Medio

Área: C.P.D.

Elaborado por: Edmundo Céspedes Ayllón

e-mail: ed.cespedesa@gmail.com

---

## Instalación de Docker en:

## Debian / Ubuntu

### Remover posibles instalaciones antiguas

```bash
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
```

### Actualizar e instalar dependencias necesarias par docker

Actualizando S.O.

```bash
sudo apt-get update
```

Instalando dependencias necesarias Docker

```bash
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
```

### Registrando repositorio de Docker

Preparando el directorio de `keyrings`

```bash
sudo install -m 0755 -d /etc/apt/keyrings
```

Adicionamos la Docker’s oficial `GPG` key:

Ubuntu

```bash
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

Debian

```bash
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
```

Configuramos el certificado `GPG`

```bash
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

Adicionamos el repositorio de Docker

Ubuntu

```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

Debian

```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

Actualizando S.O.

```bash
sudo apt-get update
```

### Instalando Docker

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

---

## RHEL / CentOS /Alma Linux / Roky Linux / Fedora

### Remover posibles instalaciones antiguas

```bash
sudo dnf remove docker \
                docker-client \
                docker-client-latest \
                docker-common \
                docker-latest \
                docker-latest-logrotate \
                docker-logrotate \
                docker-selinux \
                docker-engine-selinux \
                docker-engine
```

### Actualizar e instalar dependencias necesarias par docker

Instalando dependencias necesarias Docker

```bash
sudo yum install -y yum-utils
```

### Registrando el repositorio de Docker

RHEL / Alma Linux / Roky Linux

```bash
sudo dnf config-manager --add-repo=https://download.docker.com/linux/rhel/docker-ce.repo
```

CentOS

```bash
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
```

Fedora

```bash
sudo dnf config-manager --add-repo=https://download.docker.com/linux/fedora/docker-ce.repo
```

### Instalando Docker

```bash
dnf install docker-ce docker-ce-cli containerd.io
```

---

## Por medio de Script

### Ejecutar el script

```bash
curl https://get.docker.com | sh
```

---

## Habilitando el servicio de Docker

```bash
sudo systemctl enable --now docker
```

o

```bash
sudo systemctl enable docker && sudo systemctl start docker
```

---

## Prueba de funcionamiento

```bash
sudo docker run hello-world
```

----

## Ejecutar sin sudo

Creando el grupo docker

```bash
sudo groupadd docker
```

Agregar el usuario actual al grupo `docker`

```bash
sudo usermod -aG docker ${USER}
```

Refreccamos la configuración del usuario

```bash
sudo - ${USER}
```

o

```bash
newgrp docker
```

Comprobación

```bash
groups
```

o

```bash
id
```

---

## Habilitando políticas de firewall

Insertando la políticas al firewall

```bash
firewall-cmd --zone=public --add-masquerade --permanent
```

Recargando las configura del firewall

```bash
firewall-cmd --reload
```

---

## Instalado Docker-compose

Descargando docker-compose

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

Otorgando  permisos de ejecución

```bash
sudo chmod +x /usr/local/bin/docker-compose
```

Revisando el funcionamiento del docker-compose

```bash
docker-compose --version
```

----

Material de referencia en

https://docs.docker.com/engine/install/
