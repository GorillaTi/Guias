Guía de:

# Instalar QEMU-KVM

---

## ACERCA DE:

Versión: 1.0.1

Nivel: Medio

Área: CPD

Elaborado por: Edmundo Céspedes Ayllón

e-mail: [ed.cespedesa@gmail.com](ed.cespedesa@gmail.com)

## Instalando QEMU - KVM

```bash
sudo apt install qemu-kvm qemu virt-manager virt-viewer libvirt-clients
```

En caso de procesador intel: 

```bash
sudo apt install intel-microcode 
```

En caso de procesador AMD: 

```bash
sudo apt install amd64-microcode
```

Para el acceso remoto instala

```bash
sudo apt-get install ssh-askpass
```

Utilizando virt-manager para conectarnos, nos dirigimos a File -> Add Connection. Seleccionamos SSH y rellenamos los distintos parámetros según corresponda

