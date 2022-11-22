Guía de:

# Instalación de Docker

### ACERCA DE:

Versión: 1.0.0

Nivel: Todos

Área: C.P.D.

Elaborado por: Edmundo Céspedes Ayllón

e-mail: ed.cespedesa@gmail.com

---

## Instalación de Docker en:

## Debian / Ubuntu

Remover posibles instalaciones antiguas

```bash
sudo apt-get remove docker docker-engine docker.io containerd runc
```

### Actualizar e instalar depéndencias necesarias par docker

Actualizando S.O.

```bash
sudo apt-get update
```

Instalando dependencias necesarias Docker

```bash
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
```

### Registrando repositorio de Docker

Adicionamos la Docker’s official GPG key:

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

Adicionamos el repositorio de Docker

```bash
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"
```

Actualizando S..O.

```bash
sudo apt-get update
```

### Instalando Docker

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

Prueba de funcionamiento

```bash
sudo docker run hello-world
```

Material de refencia en

https://docs.docker.com/engine/install/ubuntu/

---

## RHEL / Alma Linux

### Registrando el repositorio de de Docker

```bash
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
```

### Instalando Docker

```bash
dnf install docker-ce docker-ce-cli containerd.io
```

---

## Habilitando el servicio de Docker

```bash
sudo systemctl enable --now docker
```

## Ejecutar sin sudo

Agregamos nuestro usuario al grupo `docker`

```bash
sudo usermod -aG docker ${USER}
```

Habilitamos la configuración

```bash
sudo - ${USER}
```

Comprobamos

```bash
groups
```

---

## Habilitando politicas de firewall

Insertando la politica al firewall

```bash
firewall-cmd --zone=public --add-masquerade --permanent
```

Recargando las configura del firewall

```bash
firewall-cmd --reload
```

---

## Instalado Docker-compose

Descargando docker-composer

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

Otorgando  permisos de ejecucuin

```bash
sudo chmod +x /usr/local/bin/docker-compose
```

Revisando el funcionamiento del docker-compose

```bash
docker-compose --version
```


