#!/usr/bin/env bash
# ------------------------ COMANDO PARA RODAR ------------------------- #
# sudo ./diego.sh |& tee -a resultados.txt --------------------------------- #

# ----------------------------- VARIÁVEIS ----------------------------- #
URL_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_FOXIT_READER="https://cdn01.foxitsoftware.com/pub/foxit/reader/desktop/linux/2.x/2.4/en_us/FoxitReader.enu.setup.2.4.4.0911.x64.run.tar.gz"
URL_GITHUB_DESKTOP="https://github.com/shiftkey/desktop/releases/download/release-2.9.15-linux1/GitHubDesktop-linux-2.9.15-linux1.deb"
URL_4K_DOWNLOADER="https://dl.4kdownload.com/app/4kvideodownloader_4.20.2-1_amd64.deb"
mkdir $HOME/temp
DIRETORIO_DOWNLOADS="$HOME/temp"

LISTA_APT=(
  audio-recorder
  cheese
  flatpak
  git-all
  gnome-software-plugin-flatpak
  gnome-tweaks
  gparted
  grsync
  inxi
  lsb
  lsb-base
  lsb-core
  lsb-invalid-mta
  lsb-printing
  lsb-release
  lsb-security
  mlocate
  ncdu
  neofetch
  nodejs
  notion-app
  papirus-icon-theme
  sl
  synaptic
  transmission-gtk
  ubuntu-restricted-extras
  xarchiver
)

LISTA_FLATPAK=(
  com.discordapp.Discord
  com.github.jeromerobert.pdfarranger
  com.github.johnfactotum.Foliate
  com.github.micahflee.torbrowser-launcher
  com.github.tchx84.Flatseal
  com.microsoft.Teams
  com.obsproject.Studio
  com.spotify.Client
  com.sweethome3d.Sweethome3d
  com.uploadedlobster.peek
  fr.handbrake.ghb
  io.typora.Typora
  org.audacityteam.Audacity
  org.bluesabre.MenuLibre
  org.kde.kdenlive
  org.videolan.VLC 
  us.zoom.Zoom
)

LISTA_SNAP=(
  indicator-sound-switcher
  photogimp
  telegram-desktop
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
sudo apt install curl

## Adicionando repositórios de terceiros##
echo " 
ADICIONANDO REPOSITÓRIOS DE TERCEIROS
 "
sudo add-apt-repository ppa:audio-recorder -y
curl -fsSL https://deb.nodesource.com/setup_12.x | sudo -E bash -
echo "deb [trusted=yes] https://apt.fury.io/notion-repackaged/ /" | sudo tee /etc/apt/sources.list.d/notion-repackaged.list
sudo add-apt-repository ppa:papirus/papirus -y

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
wget -c "$URL_FOXIT_READER"        -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GITHUB_DESKTOP"      -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_4K_DOWNLOADER"       -P "$DIRETORIO_DOWNLOADS"
tar -vzxf *.tar.gz

## Instalando pacotes .deb e .run baixados na sessão anterior ##
echo " 
INSTALANDO PACOTES EXTERNOS
 "
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb
chmod +x *.run
sudo ./*.run
## Corrigindo possíveis erros até aqui ##
echo " 
BUSCANDO POR PACOTES AUSENTES
 "
sudo apt update -y
sudo apt install -f -y
sudo apt upgrade -y
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb
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
sudo snap install ${LISTA_SNAP[@]}
sudo snap install code --classic

# ---------------------------------------------------------------------- #

# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##
echo " 
FINALIZANDO INSTALAÇÃO E LIMPANDO O SISTEMA
 "
sudo apt update && sudo apt dist-upgrade -y
flatpak update -y
sudo apt autoclean
sudo apt autoremove -y
echo " 
O COMPUTADOR SERÁ REINICIADO
 "
sudo shutdown -r
# ---------------------------------------------------------------------- #