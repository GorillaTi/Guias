# Guía de:

# Instalar y personalizar ZSH

## ACERCA DE:

Versión: 1.0.0

Nivel: Todos

Área: C.P.D.

Elaborado por: Edmundo Céspedes Ayllón

e-mail: [ed.cespedesa@gmail.com

---

Instalando ZSH

```bash
sudo apt update
```

```bash
sudo apt install zsh
```

```bash
sudo apt install zsh
```

2. Configuramos la terminal por defecto

```bash
chsh -s `which zsh`
```

o

```bash
usermod --shell /usr/bin/zsh [usuario]
```

Verificamos el interprete de comandos por defectos

```bash
cat /etc/passwd | grep -E "^root|^[tu_ususario]"
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

5. Instalamos oh-my-zsh  seguimos instrucciones desde su pagina
   
   https://ohmyz.sh/

6. Instalamos powerlevel10k seguimos instrucciones desde su pagina
   
   https://github.com/romkatv/powerlevel10k

7. Realizamos los pasos 5 y 6 para root y configuramos a nuestro gusto

8. Para que se replique en root las configuraciones realizadas en el usuario personal, creamos un enlace simbólico de `.zshrc` 
   
   ```bash
   ln -s -f /home/boogieman/.zshrc .zshrc
   ```

9. Reiniciar configuración de powerlevel 10k

```bash
p10k configure
```

## Instalar Plugins

Creamos la carpeta global para todos los ususrios.

```bash
sudo mkdir /usr/share/zsh-plugins
```

 Creamos el enlace simbolico desde el directorio plugins de ohmyzsh

```bash
ln -s /home/${USER}/.ohmyzsh/plugins/sudo/sudo.plugin.zsh /usr/share/
```

1. sudo.plugin sirve para insertar la etiqueta sudo precionando dos veces la tecla `esc`