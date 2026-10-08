#!/usr/bin/env bash
set -euo pipefail

# --- Comprobaciones iniciales ---------------------------------------------
if [[ $EUID -eq 0 ]]; then
  echo "[!] Ejecuta este script como tu usuario normal (sin sudo)." >&2
  exit 1
fi

# Directorio donde está el script (para las rutas relativas de los dotfiles)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

NF_VER="v3.5.1"
KITTY_VER="0.49.2"
NVIM_VER="v0.12.5"
MDCAT_VER="2.3.1"

# --- Paquetes base --------------------------------------------------------
echo "[+] Installing basic tools"
sudo apt update
sudo apt install -y \
  rofi bat lsd xclip npm fd-find ripgrep flameshot \
  unzip wget git fontconfig

# En Debian/Kali: bat -> batcat, fd -> fdfind
command -v bat >/dev/null || sudo ln -sfn /usr/bin/batcat /usr/local/bin/bat
command -v fd  >/dev/null || sudo ln -sfn /usr/bin/fdfind /usr/local/bin/fd

# --- Nerd Fonts -----------------------------------------------------------
echo "[+] Installing Nerd Fonts"
for font in CascadiaCode Iosevka NerdFontsSymbolsOnly; do
  wget -q -O "$TMP_DIR/$font.zip" \
    "https://github.com/ryanoasis/nerd-fonts/releases/download/$NF_VER/$font.zip"
  sudo mkdir -p "/usr/local/share/fonts/$font"
  sudo unzip -oq "$TMP_DIR/$font.zip" -d "/usr/local/share/fonts/$font"
done
sudo fc-cache -f

# --- Kitty ----------------------------------------------------------------
echo "[+] Installing kitty"
wget -q -O "$TMP_DIR/kitty.txz" \
  "https://github.com/kovidgoyal/kitty/releases/download/v$KITTY_VER/kitty-$KITTY_VER-x86_64.txz"
sudo rm -rf /opt/kitty
sudo mkdir -p /opt/kitty
sudo tar -xf "$TMP_DIR/kitty.txz" -C /opt/kitty
sudo ln -sfn /opt/kitty/bin/kitty  /usr/local/bin/kitty
sudo ln -sfn /opt/kitty/bin/kitten /usr/local/bin/kitten

# --- Neovim ---------------------------------------------------------------
echo "[+] Installing Neovim"
wget -q -O "$TMP_DIR/nvim.tar.gz" \
  "https://github.com/neovim/neovim/releases/download/$NVIM_VER/nvim-linux-x86_64.tar.gz"
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -xzf "$TMP_DIR/nvim.tar.gz" -C /opt
sudo ln -sfn /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim

# --- fzf ------------------------------------------------------------------
echo "[+] Installing fzf"
if [[ ! -d "$HOME/.fzf" ]]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
fi
"$HOME/.fzf/install" --key-bindings --completion --no-update-rc

sudo rm -rf /root/.fzf
sudo cp -r "$HOME/.fzf" /root/
sudo /root/.fzf/install --key-bindings --completion --no-update-rc

# --- mdcat ----------------------------------------------------------------
echo "[+] Installing mdcat"
MDCAT_PKG="mdcat-$MDCAT_VER-x86_64-unknown-linux-musl"
wget -q -O "$TMP_DIR/mdcat.tar.gz" \
  "https://github.com/swsnr/mdcat/releases/download/mdcat-$MDCAT_VER/$MDCAT_PKG.tar.gz"
tar -xzf "$TMP_DIR/mdcat.tar.gz" -C "$TMP_DIR"
sudo install -m 755 "$TMP_DIR/$MDCAT_PKG/mdcat" /usr/local/bin/mdcat

# --- Configuración de nvim ------------------------------------------------
echo "[+] Instalando la configuracion de nvim"
mkdir -p "$HOME/.config"
if [[ ! -d "$HOME/.config/nvim" ]]; then
  git clone https://github.com/Bytehxz/nvim "$HOME/.config/nvim"
else
  echo "[!] ~/.config/nvim ya existe, se omite el clone"
fi

# --- powerlevel10k --------------------------------------------------------
echo "[+] Installing powerlevel10k"
if [[ ! -d "$HOME/powerlevel10k" ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/powerlevel10k"
fi
sudo rm -rf /root/powerlevel10k
sudo cp -r "$HOME/powerlevel10k" /root/

# --- Dotfiles -------------------------------------------------------------
echo "[+] Ajustando los archivos .zshrc y .p10k.zsh"
cp "$SCRIPT_DIR/.zshrc"    "$HOME/.zshrc"
cp "$SCRIPT_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
sudo ln -sfn "$HOME/.zshrc"    /root/.zshrc
sudo ln -sfn "$HOME/.p10k.zsh" /root/.p10k.zsh

cp -R "$SCRIPT_DIR/config/lsd"   "$HOME/.config/"
cp -R "$SCRIPT_DIR/config/kitty" "$HOME/.config/"
# cp -R "$SCRIPT_DIR/config/bat"   "$HOME/.config/"

# --- Enlaces para root ----------------------------------------------------
sudo mkdir -p /root/.config
for d in nvim kitty lsd; do
  sudo rm -rf "/root/.config/$d"
  sudo ln -sfn "$HOME/.config/$d" "/root/.config/$d"
done

echo "[+] Done ✔"
