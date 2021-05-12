# Instalar y personalizar ZSH

1. Instalando ZSH

```bash
sudo apt update
```

```
sudo apt install zsh
```

```bash
sudo apt install zsh
```

2. colocalcamo la shell por defecto

```bash
chsh -s `which zsh`
```

OPCIONAL: habilitar visualizar asteriscos en la contraseña

```
sudo nano /etc/sudoers
```

Se adiciona el  la linea

```config
Defaults    env_reset, pwfeedback
```

3. Para personalizar se necesita instalar
```
sudo apt install curl git -y
```

4. Ejecutar zsh
```
zsh
```

5. Editar perfil en el gestor de comando de su preferencia en el apartado de 
```
   orden elegir /bin/zsh
```

Reiniciar configuración de powerlevel 10k

```bash
p10k configure
```