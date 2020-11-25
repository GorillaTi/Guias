# Instalar QEMU-KVM

---

## Instalndo QEMU

```bash
sudo apt-get install qemu-kvm qemu virt-manager virt-viewer libvirt-clients -s
```

En caso de procesador intel: 

```bash
sudo apt install intel-microcode 
```

En caso de procesador AMD: 

```bash
sudo apt install amd64-microcode
```