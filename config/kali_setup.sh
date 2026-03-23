#!/usr/bin/env bash

set -e

echo "[+] Installing basic tools"
sudo apt update
sudo apt install -y \
  rofi bat lsd xclip npm fd-find ripgrep flameshot \
  unzip wget git

echo "[+] Installing Nerd Fonts"
cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CascadiaCode.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Iosevka.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/NerdFontsSymbolsOnly.zip

sudo mkdir -p /usr/local/share/fonts
sudo unzip CascadiaCode.zip -d /usr/local/share/fonts
sudo unzip Iosevka.zip -d /usr/local/share/fonts
sudo unzip NerdFontsSymbolsOnly.zip -d /usr/local/share/fonts

fc-cache -fv

sudo chown $USER:$USER /opt
echo "[+] Installing kitty"
cd /opt
sudo mkdir -p kitty
sudo chown $USER:$USER kitty
cd kitty
wget https://github.com/kovidgoyal/kitty/releases/download/v0.45.0/kitty-0.45.0-x86_64.txz
tar -xf kitty-0.45.0-x86_64.txz
rm kitty-0.45.0-x86_64.txz

echo "[+] Installing Neovim"
cd /opt
wget https://github.com/neovim/neovim/releases/download/v0.10.1/nvim-linux64.tar.gz
tar -xf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz

echo "[+] Installing fzf"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install 

sudo cp -r $HOME/.fzf /root/
sudo /root/.fzf/install 

echo "[+] Installing Mdcat"
wget https://github.com/swsnr/mdcat/releases/download/mdcat-2.3.1/mdcat-2.3.1-x86_64-unknown-linux-musl.tar.gz
tar -xf mdcat-2.3.1-x86_64-unknown-linux-musl.tar.gz
sudo mv mdcat-2.3.1-x86_64-unknown-linux-musl/mdcat /usr/bin/mdcat

echo -e "[+] Instalando la configuracion de nvim "
sleep 2
git clone https://github.com/Bytehxz/nvim ~/.config/nvim/
sudo ln -s -f $HOME/.config/nvim /root/.config/nvim

echo "[+] Installing powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
sudo cp -r $HOME/powerlevel10k /root/
# -------------------------------
echo -e "[+] Ajustando los archivos .zshrc y .p10k.zsh"
cp ./.zshrc $HOME/.zshrc
sudo ln -s -f $HOME/.zshrc /root/.zshrc

cp ./.p10k.zsh $HOME/.p10k.zsh
sudo ln -s -f $HOME/.p10k.zsh /root/.p10k.zsh

echo -e "[+] Ajustando los archivos para poder usar ghidra de forma automática"
cp -R ./opt/auto_ghidra /opt/

# ------------------------------------
cp -R ./config/lsd $HOME/.config/
cp -R ./config/kitty $HOME/.config/
cp -R ./config/bat $HOME/.config/
sleep 3
sudo mkdir /root/.config
sudo ln -s -f $HOME/.config/kitty /root/.config/kitty
sudo ln -s -f $HOME/.config/lsd /root/.config/lsd
sudo ln -s -f $HOME/.config/nvim /root/.config/nvim


echo "[+] Done ✔"
