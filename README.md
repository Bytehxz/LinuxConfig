# Linux Dotfiles

Archivos de configuración

## Entorno
- Bspwmrc
- Sxhkd
- Polybar-themes
- Lazygit


### Tested on Kali Linux

# Lo primero que debes hacer es:

```bash
mkdir -p ~/Documents/Entorno/ && cd ~/Documents/Entorno/

```

Para poder tener 2 interfaces funcionales en Virtualbox y Kali Linux 
```bash
cd /etc/network

nvim interfaces

#Host only
auto eth0
iface eth0 inet dhcp

#NAT network
auto eth1
iface eth1 inet dhcp

reboot
```

Para que se puedan compilar y tener disponibles los temas de batcat
```bash
~/.config/bat/themes/
batcat cache --build
```
