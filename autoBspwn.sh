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

function InstallFonts(){
	cd $HOME/Documents
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CascadiaCode.zip
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Iosevka.zip 
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/NerdFontsSymbolsOnly.zip
	sudo unzip NerdFontsSymbolsOnly.zip -d /usr/local/share/fonts/
	sudo unzip CascadiaCode.zip -d /usr/local/share/fonts/
	sudo unzip Iosevka.zip -d /usr/local/share/fonts/
	wget https://github.com/lsd-rs/lsd/releases/download/v1.1.2/lsd_1.1.2_amd64.deb
	sudo dpkg -i lsd_1.1.2_amd64.deb
}
# Parte 4 --------------------------------------------- instalando herramientas y las fuentes necesarias para que todo funcione
function toolsUtils(){
  echo -e "${blueColour}[!] Instalando las fuentes para que se vea bonito :D${endColour}"
  sleep 4
  # Instalación de la herramientas que suelo usar
  sudo apt install -y rofi feh bat xclip npm bspwm fd-find ripgrep flameshot # picom
	cd 

  # sudo apt install -y --reinstall virtualbox-guest-x11 # Para instalar la virtualbox tools

  #instalacion de go 
  # cd $HOME/Documents
  # wget https://go.dev/dl/go1.22.0.linux-amd64.tar.gz
  # sudo rm -rf /usr/local/go 
  # sudo tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz

  # Instalando lo necesario para el lenguaje go
  # go install golang.org/x/tools/gopls@latest
  # go install github.com/jesseduffield/lazygit@latest

  # Instalacion de fuentes nerdfonts
  if [[ -d /usr/local/share/fonts/ ]]; then
		InstallFonts
	else
		sudo mkdir /usr/local/share/fonts/
		InstallFonts
  fi




  echo -e "${turquoiseColour}[+] Ha terminado la instalación de todo lo necesario"
  sleep 2
}

# Parte 3 ---------------------------------------------
function installOPT(){
  # Instalacion del navegador Waterfox
  echo -e "${yellowColour}[!] Instalando todo en el directorio /opt${endColour}"
  sleep 3
  sudo chown kali:kali /opt

  cd $HOME/Downloads/
  wget https://github.com/swsnr/mdcat/releases/download/mdcat-2.3.1/mdcat-2.3.1-x86_64-unknown-linux-musl.tar.gz
  tar -xf mdcat-2.3.1-x86_64-unknown-linux-musl.tar.gz
  sudo mv mdcat-2.3.1-x86_64-unknown-linux-musl/mdcat /usr/bin/mdcat
	rm -rf $HOME/Downloads/*

  # echo -e "${turquoiseColour}[%] Instalando waterfox${endColour}"
  # sleep 1
  # sudo chown $USER:$USER /opt
  # cd /opt 
  # mkdir Waterfox
  # cd Waterfox
  # wget https://cdn1.waterfox.net/waterfox/releases/latest/linux
  # tar -xf linux
  # rm linux

  # Instalando la kittyTerminal
  echo -e "${turquoiseColour}[%] Instalando kitty${endColour}"
  sleep 1
  cd /opt 
  mkdir kitty
  cd kitty
  wget https://github.com/kovidgoyal/kitty/releases/download/v0.37.0/kitty-0.37.0-x86_64.txz
	wget https://github.com/kovidgoyal/kitty/releases/download/v0.39.1/kitty-0.39.1-x86_64.txz
  tar -xf kitty-0.39.1-x86_64.txz
  rm kitty-0.39.1-x86_64.txz

  # instalando Telegram
  echo -e "${turquoiseColour}[%] Instalando Telegram${endColour}"
  sleep 1
  cd /opt 
  wget https://telegram.org/dl/desktop/linux
  tar -xf linux
  rm -rf linux

  # Requerimientos para instalar nvim
  echo -e "${turquoiseColour}[%] Instalando nvim${endColour}"
  sleep 3
  cd /opt 
  wget https://github.com/neovim/neovim/releases/download/v0.10.1/nvim-linux64.tar.gz
  tar -xf nvim-linux64.tar.gz
  rm nvim-linux64.tar.gz

  # -------------------------------------------------------------------
  echo -e "${turquoiseColour}[%] Instalando fzf coloca en todas las opciones y${endColour}"
  sleep 3
  # Usuario normal
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
  # Para root
  sleep 3
  sudo cp -r $HOME/.fzf /root/
  sudo /root/.fzf/install   

  # -------------------------------------------------------------------
  echo -e "${turquoiseColour}[%] Instalando powerlevel10k${endColour}"
  sleep 2
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
  # root
  sudo cp -r $HOME/powerlevel10k /root/

  # -------------------------------------------------------------------
  echo -e "${turquoiseColour}[%] Instalando la configuracion de nvim ${endColour}"
  sleep 2
  git clone https://github.com/Bytehxz/nvim ~/.config/nvim/
  sudo ln -s -f $HOME/.config/nvim /root/.config/nvim

  # -------------------------------------------------------------------
  echo -e "${purpleColour}[%] Ajustando los archivos .zshrc y .p10k.zsh${endColour}"
  sleep 2
  cp $HOME/Documents/Entorno/LinuxConfig/.zshrc $HOME/.zshrc
  # root
  sudo ln -s -f $HOME/.zshrc /root/.zshrc
  cp $HOME/Documents/Entorno/LinuxConfig/.p10k.zsh $HOME/.p10k.zsh
  # root
  sudo ln -s -f $HOME/.p10k.zsh /root/.p10k.zsh
  
  # -------------------------------------------------------------------
  echo -e "${purpleColour}[%] Ajustando los archivos de la polybar${endColour}"
  sleep 2
  rm -rf $HOME/.config/polybar/blocks
  cp -r $HOME/Documents/Entorno/LinuxConfig/config/polybar-Themes/blocks $HOME/.config/polybar/


  # -------------------------------------------------------------------
  echo -e "${purpleColour}[%] Ajustando los archivos para poder usar ghidra de forma automática${endColour}"
  sleep 2
  cp -R $HOME/Documents/Entorno/LinuxConfig/opt/auto_ghidra /opt/
  
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

  cd $HOME/Documents
  # Clonando el repo de la polybar
  git clone --recursive https://github.com/polybar/polybar

  cd polybar/
  mkdir build
  cd build/
  cmake ..
  make -j$(nproc)
  sudo make install

  cd $HOME/Documents
  # polybar-themes
  git clone --depth=1 https://github.com/adi1090x/polybar-themes.git 
  cd polybar-themes
  chmod +x setup.sh
  echo -e "${purpleColour}Selecciona la opcion 1..${endColour}"
  sleep 5
  bash setup.sh

  echo -e "${greenColour}[+] Terminado ${endColour}"
  sleep 2
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

  cd $HOME/Documents

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
  cp -R $HOME/Documents/Entorno/LinuxConfig/config/picom $HOME/.config/
  cp -R $HOME/Documents/Entorno/LinuxConfig/config/bspwm $HOME/.config/
  cp -R $HOME/Documents/Entorno/LinuxConfig/config/sxhkd $HOME/.config/
  cp -R $HOME/Documents/Entorno/LinuxConfig/config/lsd $HOME/.config/
  cp -R $HOME/Documents/Entorno/LinuxConfig/config/kitty $HOME/.config/
  cp -R $HOME/Documents/Entorno/LinuxConfig/config/bat $HOME/.config/
  sleep 3
  sudo mkdir /root/.config
  sudo ln -s -f $HOME/.config/kitty /root/.config/kitty
  sudo ln -s -f $HOME/.config/lsd /root/.config/lsd
  sudo ln -s -f $HOME/.config/nvim /root/.config/nvim

  cp $HOME/Documents/Entorno/LinuxConfig/kali.conf/* $HOME/Documents/Entorno
  # cd $HOME/Documents/Entorno
  # touch victima
  # cp $HOME/Documents/Entorno/LinuxConfig/
	
	# ------------- Picom Install from github repositorie
	sudo apt install libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev libepoxy-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev meson ninja-build uthash-dev -y 
	
	cd $HOME/Documents
	git clone https://github.com/yshui/picom.git
	cd picom/
	meson setup --buildtype=release build
	sudo ninja -C build install






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
    sudo apt install figlet zsh -y
    figlet "Bspwm.sh"
    sleep 3
  else
    sleep 3
  fi

  if [[ $USER == 'root' ]]; then
    echo -e "${redColour}[!] No es necesario que lo ejecutes como root ${endColour}"
    exit 1
  else
    bspwm_sxhkd
  fi
}

# Main
banner
