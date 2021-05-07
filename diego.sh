#!/usr/bin/env bash
# ------------------------ COMANDO PARA RODAR ------------------------- #
# ./diego.sh |& tee -a resultados.txt ---------------------------------- #

# ----------------------------- VARIÁVEIS ----------------------------- #
URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_EPSON_DRIVER="http://download.ebz.epson.net/dsc/op/stable/debian/dists/lsb3.2/main/binary-amd64/epson-inkjet-printer-201207w_1.0.0-1lsb3.2_amd64.deb"
URL_FOXIT_READER="https://cdn01.foxitsoftware.com/pub/foxit/reader/desktop/linux/2.x/2.4/en_us/FoxitReader.enu.setup.2.4.4.0911.x64.run.tar.gz"
URL_GITHUB_DESKTOP="https://github.com/shiftkey/desktop/releases/download/release-2.8.1-linux1/GitHubDesktop-linux-2.8.1-linux1.deb"
DIRETORIO_DOWNLOADS="$HOME/"

PROGRAMAS_PARA_INSTALAR=(

  cheese
  flatpak
  git-all
  gnome-software-plugin-flatpak
  gnome-tweaks
  gparted
  grsync
  grub-customizer
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
# ---------------------------------------------------------------------- #

# ----------------------------- REQUISITOS ----------------------------- #

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

## Removendo travas eventuais do apt ##
echo " 
REMOVENDO TRAVAS DO APT
 "
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

## Adicionando repositórios de terceiros##
echo " 
ADICIONANDO REPOSITÓRIOS DE TERCEIROS
 "
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
for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    sudo apt-get install "$nome_do_programa" -y
    echo "[INSTALADO] - $nome_do_programa"
  else
    echo "[JÁ ESTAVA INSTALADO] - $nome_do_programa"
  fi
done

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

## Instalando pacotes Flatpak ##
echo " 
INSTALANDO PACOTES FLATPAK
 "
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install flathub com.spotify.Client -y
sudo flatpak install flathub org.videolan.VLC -y
sudo flatpak install flathub com.discordapp.Discord -y
## sudo flatpak install flathub com.valvesoftware.Steam -y
sudo flatpak install flathub us.zoom.Zoom -y
sudo flatpak install flathub com.github.micahflee.torbrowser-launcher -y
sudo flatpak install flathub org.telegram.desktop -y
sudo flatpak install flathub com.obsproject.Studio -y
sudo flatpak install flathub org.kde.kdenlive -y
sudo flatpak install flathub org.onlyoffice.desktopeditors -y 
sudo flatpak install flathub com.skype.Client -y
sudo flatpak install flathub com.github.johnfactotum.Foliate -y
sudo flatpak install flathub io.typora.Typora -y
sudo flatpak install flathub fr.handbrake.ghb -y
sudo flatpak install flathub org.audacityteam.Audacity -y 


## Instalando pacotes Snap ##
echo " 
INSTALANDO PACOTES SNAP
 "
sudo snap install photogimp
sudo snap install visualg
sudo snap install code --classic
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