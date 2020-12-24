Ingresar la servidor con root

### Preparando usuario para ssh ###
Crear usuario
# useradd sysadmin
Actualozamos la contraseña de sysadmin
# passwd sysadmin
-->Salida
Changing password for user sammy.
New password:
Retype new password:
passwd: all authentication tokens updated successfully.
Añarir ususario al grupo wheel
# usermod -aG wheel sammy
>De nuevo, asegúrese de sustituir sammy​​​ por el nombre de usuario al que desea conceder privilegios sudo. Por defecto, en CentOS, todos los miembros del grupo wheel tienen acceso sudo completo.
Probamos el usuario
#su - sysadmin
$ sudo ls -la /root



    Ubuntu
    Debian
    RHEL / CentOS
    Fedora
    Kali

Contact Us Write For Us Twitter Newsletter
Linux Tutorials - Learn Linux Configuration

    Linux Guides
    Linux Tutorials
    System Admin
    Programming
    Multimedia
    Linux Commands
    Linux Forums
    Linux Jobs

Install ssh server on CentOS 8 / RHEL 8

    Lubos Rendek 
    31 July 2019 

The SSH server might already be installed on your RHEL 8 / CentOS 8 system. You can check the status of your SSH server using the systemctl status sshd command. We will then install the openssh-server package below by using the dnf command.

In this tutorial you will learn:

    How to install SSH server onRHEL 8 / CentOS 8.
    How to open SSH firewall port 22 on RHEL 8 / CentOS 8.
    How to enable SSH to start after reboot on RHEL 8 / CentOS 8.

Active SSH Server Daemon on RHEL 8 Linux server/workstation.
Active SSH Server daemon on RHEL 8 Linux server/workstation.
Software Requirements and Conventions Used
Software Requirements and Linux Command Line Conventions Category 	Requirements, Conventions or Software Version Used
System 	RHEL 8 / CentOS 8
Software 	OpenSSH_7.8p1, OpenSSL 1.1.1 FIPS
Other 	Privileged access to your Linux system as root or via the sudo command.
Conventions 	# - requires given linux commands to be executed with root privileges either directly as a root user or by use of sudo command
$ - requires given linux commands to be executed as a regular non-privileged user
How to Install ssh server on RHEL 8 / CentOS 8 step by step instructions
SUBSCRIBE TO NEWSLETTER
Subscribe to Linux Career NEWSLETTER and receive latest Linux news, jobs, career advice and tutorials.

    Install the SSH server package openssh by using the dnf command:

    # dnf install openssh-server

    Start the sshd daemon and set to start after reboot:

    # systemctl start sshd
    # systemctl enable sshd

    Confirm that the sshd daemon is up and running:

    # systemctl status sshd

    Open the SSH port 22 to allow incoming traffic:

    # firewall-cmd --zone=public --permanent --add-service=ssh
    # firewall-cmd --reload

    Optionally, locate the SSH server man config file /etc/ssh/sshd_config and perform custom configuration.

    Every time you make any change to the /etc/ssh/sshd_config configuration file reload the sshd service to apply changes:

     # systemctl reload sshd
