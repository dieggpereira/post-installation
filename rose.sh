#!/usr/bin/env bash
# ------------------------ COMANDO PARA RODAR ------------------------- #
# sudo ./rose.sh |& tee -a resultados.txt --------------------------------- #

# ----------------------------- VARIÁVEIS ----------------------------- #
URL_EPSON_DRIVER="http://download.ebz.epson.net/dsc/op/stable/debian/dists/lsb3.2/main/binary-amd64/epson-inkjet-printer-201207w_1.0.0-1lsb3.2_amd64.deb"
URL_FOXIT_READER="https://cdn01.foxitsoftware.com/pub/foxit/reader/desktop/linux/2.x/2.4/en_us/FoxitReader.enu.setup.2.4.4.0911.x64.run.tar.gz"
URL_4K_DOWNLOADER="https://dl.4kdownload.com/app/4kvideodownloader_4.20.0-1_amd64.deb"
mkdir $HOME/temp
DIRETORIO_DOWNLOADS="$HOME/temp"

LISTA_APT=(
  anydesk
  flatpak
  gnome-software-plugin-flatpak
  gnome-tweaks
  gparted
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
  ncdu
  neofetch
  sl
  synaptic
  ubuntu-restricted-extras
)

LISTA_FLATPAK=(
  com.google.Chrome
  com.microsoft.Teams
  com.skype.Client
  org.videolan.VLC 
  us.zoom.Zoom
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

# ---------------------------------------------------------------------- #
echo " 
ADICIONANDO REPOSITÓRIOS DE TERCEIROS
 "
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list

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
wget -c "$URL_EPSON_DRIVER"        -P "$DIRETORIO_DOWNLOADS"
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