#!/usr/bin/env bash
# ------------------------ COMANDO PARA RODAR ------------------------- #
# ./diego-autoremove.sh |& tee -a resultados.txt ---------------------------------- #

# ----------------------------- VARIÁVEIS ----------------------------- #
URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_EPSON_DRIVER="http://download.ebz.epson.net/dsc/op/stable/debian/dists/lsb3.2/main/binary-amd64/epson-inkjet-printer-201207w_1.0.0-1lsb3.2_amd64.deb"
URL_FOXIT_READER="https://cdn01.foxitsoftware.com/pub/foxit/reader/desktop/linux/2.x/2.4/en_us/FoxitReader.enu.setup.2.4.4.0911.x64.run.tar.gz"
URL_GITHUB_DESKTOP="https://github.com/shiftkey/desktop/releases/download/release-2.8.1-linux1/GitHubDesktop-linux-2.8.1-linux1.deb"
DIRETORIO_DOWNLOADS="$HOME/temp"

LISTA_APT=(
  cheese
  flatpak
  git-all
  gnome-software-plugin-flatpak
  gnome-tweaks
  gparted
  grsync
  grub-customizer
  indicator-sound-switcher
  inxi
  lsb
  lsb-base
  lsb-core
  lsb-invalid-mta
  lsb-printing
  lsb-release
  lsb-security
  mlocate
  neofetch
  notion-desktop
  sl
  synaptic
  transmission-gtk
  ubuntu-restricted-extras
  virtualbox
)
LISTA_FLATPAK=(
  com.spotify.Client
  org.videolan.VLC
  com.discordapp.Discord
  us.zoom.Zoom
  com.github.micahflee.torbrowser-launcher
  org.telegram.desktop
  com.obsproject.Studio
  org.kde.kdenlive
  org.onlyoffice.desktopeditors
  com.skype.Client
  com.github.johnfactotum.Foliate
  io.typora.Typora
  fr.handbrake.ghb
  org.audacityteam.Audacity
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
sudo apt-get update -y

## Atualizando os pacotes ##
echo " 
ATUALIZANDO OS PACOTES
 "
sudo apt-get upgrade -y
sudo apt autoremove -y

## Ajustando tema ##
echo " 
AJUSTANDO TEMA
 "
gsettings set org.gnome.desktop.interface gtk-theme "Yaru-dark"
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 30
gsettings set org.gnome.shell.extensions.dash-to-dock autohide 'true'
gsettings set org.gnome.desktop.interface show-battery-percentage 'true'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 0
gsettings set org.gnome.desktop.session idle-delay 0

## Adicionando repositórios de terceiros##
echo " 
ADICIONANDO REPOSITÓRIOS DE TERCEIROS
 "
sudo apt-add-repository ppa:yktooo/ppa -y  
wget https://notion.davidbailey.codes/notion-linux.list
sudo mv notion-linux.list /etc/apt/sources.list.d/notion-linux.list

# ---------------------------------------------------------------------- #

# ----------------------------- EXECUÇÃO ----------------------------- #
## Atualizando o repositório depois da adição de novos repositórios ##
echo " 
ATUALIZANDO OS REPOSITÓRIOS
 "
sudo apt-get update -y

# Instalar programas no apt
echo " 
INSTALANDO PACOTES APT
 "
sudo apt -y install ${LISTA_APT[@]}
sudo apt -y autoremove ${LISTA_APT[@]}

## Download e instalaçao de programas externos ##
echo " 
DOWNLOAD DE PACOTES EXTERNOS
 "
cd "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME"       -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_EPSON_DRIVER"        -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_FOXIT_READER"        -P "$DIRETORIO_DOWNLOADS"
wget -c "$URL_GITHUB_DESKTOP"      -P "$DIRETORIO_DOWNLOADS"
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
sudo apt-get update -y
sudo apt-get install -f -y
sudo apt-get upgrade -y
sudo dpkg -i $DIRETORIO_DOWNLOADS/*.deb
sudo apt autoremove -y
rm -rf $DIRETORIO_DOWNLOADS

## Instalando pacotes Flatpak ##
echo " 
INSTALANDO PACOTES FLATPAK
 "
sudo apt install flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub ${LISTA_FLATPAK[@]}

flatpak remove ${LISTA_FLATPAK[@]}

## Instalando pacotes Snap ##
echo " 
INSTALANDO PACOTES SNAP
 "
sudo snap install photogimp visualg && sudo snap install code --classic
sudo snap remove photogimp visualg && sudo snap remove code 

# ---------------------------------------------------------------------- #

# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##
echo " 
FINALIZANDO INSTALAÇÃO E LIMPANDO O SISTEMA
 "
sudo apt-get update && sudo apt-get dist-upgrade -y
flatpak update -y
sudo apt-get autoclean
sudo apt-get autoremove -y
echo " 
O COMPUTADOR SERÁ REINICIADO
 "
sudo shutdown -r
# ---------------------------------------------------------------------- #