# Pasos para crear cuenta SFTP jailed
groupadd sftponly
mkdir -p /home/chroot/$NEWUSER
 useradd -d /home/chroot/$NEWUSER -s /bin/false -G sftponly $NEWUSER
 passwd $NEWUSER
- Comentar la siguiente linea en /etc/ssh/sshd_config
 Subsystem       sftp    /usr/libexec/openssh/sftp-server
- Añadir lo siguiente al final de /etc/ssh/sshd_config
 Subsystem     sftp   internal-sftp
 Match Group sftponly
      ChrootDirectory %h
      X11Forwarding no
      AllowTCPForwarding no
      ForceCommand internal-sftp
- Revisar la configuracion
 sshd -t
  echo $?
 service sshd reload
- Ajustar el directorio de la cuenta.
 chmod 755 /home/chroot/$NEWUSER
 chown root:root /home/chroot/$NEWUSER
- El directorio home debe ser de root por lo que se crea otro directorio para que pueda escribir
 mkdir /home/chroot/$NEWUSER/uploads
 chown $NEWUSER:sftponly /home/chroot/$NEWUSER/uploads
- Agregar lo siguiente al /etc/fstab
 /var/www/html/uploads   /home/chroot/$NEWUSER/uploads        none    bind    0 0
 mount /home/chroot/$NEWUSER/uploads