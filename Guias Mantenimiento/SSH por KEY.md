## Conexion por SSH por medio de KEY
- Genera la key ssh

  ```bash
  $ ssh-keygen
  ```

- Copiar la Key Publica al servidor al cual nos conectaremos

  ```bash
  $ ssh-copy-id root@1.1.1.1
  ```

  e introducimos la contraseña del servidor

  e introducimos la contraseña del servidor

- Para probar nos conectamos con el servidor

  ```bash
  $ ssh root@1.1.1.1
  ```

- Para ver la lave public SSH
  CENTOS

  ```bash
  $ cat .ssh/id_ecdsa.pub
  ```

  DEBIAN

  ```bash
  $ cat .ssh/id_rsa.pub
  ```

- Habilitar los protocolos antiguos de conexión en el archivo de configuración en el equipo cliente

  sudo nano /etc/ssh/ssh_config

  des-comentar la linea  la linea

  ```
  Ciphers 3des-cbc,blowfish-cbc,aes128-cbc,aes128-ctr,aes256-ctr
  ```
  Insertamos
  
  ```
  #Legacy changes
  KexAlgorithms diffie-hellman-group1-sha1,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group14-sha1
  ```
  
  Guardamos y reiniciamos el servicio
  
  ```bash
  service ssh restart
  ```