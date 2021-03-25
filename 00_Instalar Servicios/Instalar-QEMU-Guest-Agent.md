# Instalar QEMU Guest Agent

---

## Instalación en Linux

- habilitar el agente en la consola del nodo de Proxmox

  ```bash
  qm set VMID --agent 1
  ```

- Ingresamos al la VM y instalamos el agente

  Debian

  ```bash
  apt-get install qemu-guest-agent
  ```

  RedHat

  ```bash
  yum install qemu-guest-agent
  ```

- Verificamos el estado del servicio

  ```bash
  systemctl status qemu-guest-agent
  ```

- Habilitamos el levantar al iniciar el sistema operativo

  ```bash
  systemctl enable --now qemu-guest-agent
  ```
  
- iniciamos el servicio

  ```bash
  systemctl start qemu-guest-agent
  ```