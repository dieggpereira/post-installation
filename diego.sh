#!/usr/bin/env bash
# ------------------------ COMANDO PARA RODAR ------------------------- #
# sudo ./diego.sh |& tee -a resultados.txt --------------------------------- #

# ----------------------------- VARIÁVEIS ----------------------------- #
URL_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
mkdir $HOME/temp
DIRETORIO_DOWNLOADS="$HOME/temp"

LISTA_APT=(
  btop
  curl
  flatpak
  gimp
  git-all
  gnome-shell-extensions
  gnome-software-plugin-flatpak
  gnome-tweaks
  gparted
  grub-customizer
  inxi
  menulibre
  ncdu
  neofetch
  sl
  synaptic
  timeshift
  transmission
  ubuntu-restricted-extras
  xarchiver
)

LISTA_FLATPAK=(
  com.belmoussaoui.Decoder
  com.github.jeromerobert.pdfarranger
  com.github.tchx84.Flatseal
  com.obsproject.Studio
  com.poweriso.PowerISO
  com.rafaelmardojai.Blanket
  com.sweethome3d.Sweethome3d
  fr.handbrake.ghb
  io.github.shiftey.Desktop
  io.github.tobagin.scramble
  io.gitlab.theevilskeleton.Upscaler
  org.audacityteam.Audacity
  org.kde.kdenlive
  org.kde.okular
  org.telegram.desktop
  org.torproject.torbrowser-launcher
  org.videolan.VLC
  org.zotero.Zotero
  us.zoom.Zoom
)

LISTA_SNAP=(
  btop
  fast
  indicator-sound-switcher
  rclone
  spotify
  steam
  utm-no
)
# ---------------------------------------------------------------------- #

# ----------------------------- REQUISITOS ----------------------------- #

## Removendo travas eventuais do apt ##
echo " 
REMOVENDO TRAVAS DO APT
"
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Atualizando o repositório ##

echo " 
ATUALIZANDO OS REPOSITÓRIOS
"
sudo apt update -y

## Atualizando os pacotes ##
echo " 
ATUALIZANDO OS PACOTES
 "
sudo apt dist-upgrade -y
sudo apt autoremove -y

## Adicionando repositórios de terceiros##
echo " 
ADICIONANDO REPOSITÓRIOS DE TERCEIROS
"
sudo add-apt-repository ppa:papirus/papirus -y
sudo add-apt-repository ppa:danielrichter2007/grub-customizer -y

# ---------------------------------------------------------------------- #

# ----------------------------- EXECUÇÃO ----------------------------- #
## Atualizando o repositório depois da adição de novos repositórios ##
echo " 
ATUALIZANDO OS REPOSITÓRIOS
"
sudo apt update -y

# Instalar programas no apt
echo " 
INSTALANDO PACOTES APT
"
sudo apt -y install ${LISTA_APT[@]}

## Download e instalaçao de programas externos ##
echo " 
DOWNLOAD DE PACOTES EXTERNOS
"
cd      "$DIRETORIO_DOWNLOADS"
wget -c "$URL_CHROME"              -P "$DIRETORIO_DOWNLOADS"

## Instalando pacotes .deb e .run baixados na sessão anterior ##
echo " 
INSTALANDO PACOTES EXTERNOS
"
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb

## Corrigindo possíveis erros até aqui ##
echo " 
BUSCANDO POR PACOTES AUSENTES
"
sudo apt update -y
sudo apt install -f -y
sudo apt dist-upgrade -y
sudo apt autoremove -y
rm -rf $DIRETORIO_DOWNLOADS

## Instalando pacotes Flatpak ##
echo " 
INSTALANDO PACOTES FLATPAK
"
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub ${LISTA_FLATPAK[@]}

## Instalando pacotes Snap ##
echo " 
INSTALANDO PACOTES SNAP
"
sudo snap refresh
sudo snap install ${LISTA_SNAP[@]}

# ---------------------------------------------------------------------- #

# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##
echo " 
FINALIZANDO INSTALAÇÃO E LIMPANDO O SISTEMA
"
## gsettings set org.gnome.mutter center-new-windows true
## echo "neofetch" >> .bashrc
sudo apt update && sudo apt dist-upgrade -y
flatpak update -y
sudo apt autoclean
sudo apt autoremove -y
echo " 
O COMPUTADOR SERÁ REINICIADO
"
shutdown -r now
# ---------------------------------------------------------------------- #