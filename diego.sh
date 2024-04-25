#!/usr/bin/env bash
# ------------------------ COMANDO PARA RODAR ------------------------- #
# sudo ./diego.sh |& tee -a resultados.txt --------------------------------- #

# ----------------------------- VARIÁVEIS ----------------------------- #
URL_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_FOXIT_READER="https://cdn78.foxitsoftware.com/pub/foxit/reader/desktop/linux/2.x/2.4/en_us/FoxitReader.enu.setup.2.4.5.0727.x64.run.tar.gz"
URL_4K_DOWNLOADER="https://dl.4kdownload.com/app/4kvideodownloaderplus_1.5.3-1_amd64.deb"
mkdir $HOME/temp
DIRETORIO_DOWNLOADS="$HOME/temp"

LISTA_APT=(
  ## audio-recorder
  flatpak
  gimp
  git-all
  gnome-shell-extensions
  gnome-software-plugin-flatpak
  gnome-tweaks
  gparted
  grsync
  ## grub-customizer
  inxi
  menulibre
  ## mlocate
  nala
  ncdu
  neofetch
  notion-app
  nvtop
  ## papirus-icon-theme
  sl
  synaptic
  transmission-gtk
  ## ubuntu-restricted-extras
  xarchiver
)

LISTA_FLATPAK=(
  com.belmoussaoui.Decoder
  com.bitwarden.desktop
  com.discordapp.Discord
  com.github.jeromerobert.pdfarranger
  com.github.johnfactotum.Foliate
  com.github.tchx84.Flatseal
  com.obsproject.Studio
  com.sweethome3d.Sweethome3d
  com.todoist.Todoist
  com.spotify.Client
  com.sweethome3d.Sweethome3d
  com.todoist.Todoist
  com.uploadedlobster.peek
  fr.handbrake.ghb
  fr.romainvigier.MetadataCleaner
  io.github.nate_xyz.Paleta
  io.github.shiftey.Desktop
  io.gitlab.theevilskeleton.Upscaler
  io.missioncenter.MissionCenter
  org.audacityteam.Audacity
  org.libreoffice.LibreOffice
  org.kde.kdenlive
  org.torproject.torbrowser-launcher
  org.videolan.VLC
  org.zotero.Zotero
  us.zoom.Zoom
)

LISTA_SNAP=(
  btop
  fast
  indicator-sound-switcher
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
## sudo add-apt-repository ppa:audio-recorder -y
echo "deb [trusted=yes] https://apt.fury.io/notion-repackaged/ /" | sudo tee /etc/apt/sources.list.d/notion-repackaged.list
## sudo add-apt-repository ppa:papirus/papirus -y
## sudo add-apt-repository ppa:danielrichter2007/grub-customizer -y

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
sudo snap refresh
sudo snap install ${LISTA_SNAP[@]}
sudo snap install code --classic
sudo snap install asar --classic

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
sudo shutdown -r
# ---------------------------------------------------------------------- #