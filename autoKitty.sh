#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

ctrl_c (){
  echo -e "\n\n ${redColour}[!] ${grayColour}Saliendo...${endColour}"
  exit 1
}

trap ctrl_c SIGINT


installall(){
  # Download kitty terminal
  echo -e "\n\t${greenColour}Descargando kitty...${endColour}\n"
  wget https://github.com/kovidgoyal/kitty/releases/download/v0.29.1/kitty-0.29.1-x86_64.txz &>/dev/null

  # Download CascadiaCode
  echo -e "\n\t${purpleColour}Descargando CascadiaCode...${endColour}\n"
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/CascadiaCode.zip &>/dev/null

  # Download Bat
  echo -e "\n\t${yellowColour}Descargando bat...${endColour}\n"
  wget https://github.com/sharkdp/bat/releases/download/v0.23.0/bat_0.23.0_amd64.deb &>/dev/null 

  # Download Lsd
  echo -e "\n\t${redColour}Descargando lsd...${endColour}\n"
  wget https://github.com/lsd-rs/lsd/releases/download/0.23.1/lsd_0.23.1_amd64.deb &>/dev/null

  # Download NvChadLua

}

banner (){
  figlet autoKitty
  echo -e "\n${greenColour} [&] ${grayColour} Comenzando instalación de la terminal...${endColour}"
  sleep 1 
  installall
}


# Main program
banner
