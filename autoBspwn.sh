#!/usr/bin/bash
#
# Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

#Variables globales
home=$(echo $HOME)
user=$(whoami)

# Parte 4 --------------------------------------------- instalando herramientas y las fuentes necesarias para que todo funcione
function toolsUtils(){
  echo -e "${blueColour}[!] Instalando las fuentes para que se vea bonito :D${endColour}"
  sleep 2
  # Instalación de la herramientas que suelo usar
  sudo apt install -y rofi feh picom bat lsd xclip npm
  # Instalando lo necesario para el lenguaje go
  go install golang.org/x/tools/gopls@latest

  # Instalacion de fuentes nerdfonts
  if [[ -d /usr/local/share/fonts/ ]]; then
    cd ${home}/Documents
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/CascadiaCode.zip
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Iosevka.zip 
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/NerdFontsSymbolsOnly.zip
    sudo unzip NerdFontsSymbolsOnly.zip -d /usr/local/share/fonts/
    sudo unzip CascadiaCode.zip -d /usr/local/share/fonts/
    sudo unzip Iosevka.zip -d /usr/local/share/fonts/
  fi

  echo -e "${turquoiseColour}[+] Ha terminado la instalación de todo lo necesario"
  sleep 2
}

# Parte 3 ---------------------------------------------
function installOPT(){
  # Instalacion del navegador Waterfox
  echo -e "${yellowColour}[!] Instalando todo en el directorio /opt${endColour}"
  sleep 2

  echo -e "${turquoiseColour}[%] Instalando waterfox${endColour}"
  sleep 1
  sudo chown ${user}:${user} /opt
  cd /opt 
  mkdir Waterfox
  cd Waterfox
  wget https://cdn1.waterfox.net/waterfox/releases/latest/linux
  tar -xf linux
  rm linux

  # Instalando la kittyTerminal
  echo -e "${turquoiseColour}[%] Instalando kitty${endColour}"
  sleep 1
  cd /opt 
  mkdir kitty
  cd kitty
  wget https://github.com/kovidgoyal/kitty/releases/download/v0.30.1/kitty-0.30.1-x86_64.txz
  tar -xf kitty-0.30.1-x86_64.txz
  rm nvim-linux64.tar.gz

  # Requerimientos para instalar nvim
  echo -e "${turquoiseColour}[%] Instalando nvim${endColour}"
  sleep 3
  cd /opt 
  wget https://github.com/neovim/neovim/releases/download/v0.9.4/nvim-linux64.tar.gz
  tar -xf nvim-linux64.tar.gz
  rm nvim-linux64.tar.gz

  echo -e "${turquoiseColour}[%] Instalando fzf coloca en todas las opciones y${endColour}"
  sleep 3
  # Usuario normal
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
  # Para root
  sleep 3
  sudo cp -r ${home}/.fzf /root/
  sudo /root/.fzf/install   

  echo -e "${turquoiseColour}[%] Instalando powerlevel10k${endColour}"
  sleep 2
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
  # root
  sudo cp -r ${home}/powerlevel10k /root/

  echo -e "${turquoiseColour}[%] Instalando NvChad${endColour}"
  sleep 2
  git clone https://github.com/NvChad/NvChad ~/.config/nvim 
  sudo ln -s -f ${home}/.config/nvim /root/.config/nvim
  rm -rf ${home}/.config/nvim/lua/custom
  # root
  cp -r ${home}/Documents/Entorno/LinuxConfig/Neovim/custom ${home}/.config/nvim/lua

  echo -e "${purpleColour}[%] Ajustando los archivos .zshrc y .p10k.zsh${endColour}"
  sleep 2
  cp ${home}/Documents/Entorno/LinuxConfig/.zshrc ${home}/.zshrc
  # root
  sudo ln -s -f ${home}/.zshrc /root/.zshrc
  cp ${home}/Documents/Entorno/LinuxConfig/.p10k.zsh ${home}/.p10k.zsh
  # root
  sudo ln -s -f ${home}/.p10k.zsh /root/.p10k.zsh
  
  echo -e "${purpleColour}[%] Ajustando los archivos de la polybar${endColour}"
  sleep 2
  rm -rf ${home}/.config/polybar/blocks
  cp -r ${home}/Documents/Entorno/LinuxConfig/tilingW/polybar-Themes/blocks ${home}/.config/polybar/


  echo -e "${greenColour}[+] Terminado ${endColour}"
  sleep 1.5
  # Instalación final
  toolsUtils

}

# Parte 2 instalacion de bspwm_sxhkd ----------------------------------------------
function polybarConf(){
  # Dependencias de la polybar
  echo -e "${turquoiseColour}[!] Instalando dependencias de la polybar ${endColour}"
  sleep 3
  sudo apt install -y cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python3-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev libjsoncpp-dev libmpdclient-dev libuv1-dev libnl-genl-3-dev

  cd ${home}/Documents
  # Clonando el repo de la polybar
  git clone --recursive https://github.com/polybar/polybar

  cd polybar/
  mkdir build
  cd build/
  cmake ..
  make -j$(nproc)
  sudo make install

  cd $home/Documents
  # polybar-themes
  git clone --depth=1 https://github.com/adi1090x/polybar-themes.git 
  cd polybar-themes
  chmod +x setup.sh
  echo -e "${purpleColour}Selecciona la opcion 1..${endColour}"
  sleep 3
  bash setup.sh

  echo -e "${greenColour}[+] Terminado ${endColour}"
  sleep 1.5
  # Se empieza a instalar todo lo que va en opt
  installOPT

}

# Requerimientos para instalar bspwm y sxhkd
# Parte 1 --------------------------------------------
function bspwm_sxhkd(){
  echo -e "${yellowColour}[!] Instalando dependencias y clonando repositorios${endColour}"
  sleep 3
  # Dependencias necesarias
  sudo apt install -y build-essential git vim libxcb-util0-dev libxcb-ewmh-dev libxcb-randr0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-xinerama0-dev libasound2-dev libxcb-xtest0-dev libxcb-shape0-dev

  cd ${home}/Documents

  # Clonación de los repos de bspwm y sxhkd
  git clone https://github.com/baskerville/bspwm.git 
  git clone https://github.com/baskerville/sxhkd.git

  # Instalando con make bspwm y sxhkd
  cd bspwm
  make
  sudo make install
  cd ..
  cd sxhkd
  make
  sudo make install
  cd ..

  # Configuración de las carpetas .config
  cp -R ${home}/Documents/Entorno/LinuxConfig/tilingW/picom ${home}/.config/
  cp -R ${home}/Documents/Entorno/LinuxConfig/tilingW/bspwm ${home}/.config/
  cp -R ${home}/Documents/Entorno/LinuxConfig/tilingW/sxhkd ${home}/.config/
  cp -R ${home}/Documents/Entorno/LinuxConfig/tilingW/lsd ${home}/.config/
  cp -R ${home}/Documents/Entorno/LinuxConfig/kitty ${home}/.config/

  cp ${home}/Documents/Entorno/LinuxConfig/kaliConf/* ${home}/Documents/Entorno
  # cd ${home}/Documents/Entorno
  # touch victima
  # cp ${home}/Documents/Entorno/LinuxConfig/

  echo -e "${greenColour}[+] Terminado ${endColour}"
  sleep 1.5

  # Se pasa a la configuracion de la polybar
  polybarConf

}

# Banner principal
# Parte 0 ------------------------------------
function banner (){
  figlet "Bspwm.sh" 2>/dev/null
  if [[ ! $? -eq 0 ]]; then
    sudo apt install figlet -y
    figlet "Bspwm.sh"
  fi

  if [[ $user == 'root' ]]; then
    echo -e "${redColour}[!] No es necesario que lo ejecutes como root ${endColour}"
    exit 1
  else

    bspwm_sxhkd
  fi
}

# Main
banner
