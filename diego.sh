#!/usr/bin/env bash
set -euo pipefail

# ------------------------ COMANDO PARA RODAR ------------------------- #
# sudo ./diego.sh |& tee -a resultados.txt                             #
# --------------------------------------------------------------------- #

# ----------------------------- VERIFICAÇÃO DE ROOT ----------------------------- #
if [[ $EUID -ne 0 ]]; then
    echo "Este script deve ser executado como root. Use: sudo $0"
    exit 1
fi

# ----------------------------- VARIÁVEIS ----------------------------- #
URL_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
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
    inxi
    menulibre
    ncdu
    fastfetch
    papirus-*
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
    io.gitlab.theevilskeleton.Upscaler
    org.audacityteam.Audacity
    org.kde.kdenlive
    org.kde.okular
    org.telegram.desktop
    org.torproject.torbrowser-launcher
    org.videolan.VLC
    org.zotero.Zotero
)

LISTA_SNAP=(
    fast
    rclone
    spotify
    steam
    utm-no
)

# --------------------------------------------------------------------- #
# ----------------------------- REQUISITOS ----------------------------- #

## Removendo travas eventuais do apt ##
echo "
REMOVENDO TRAVAS DO APT
"
# Verifica se o apt está em uso antes de remover os locks
if lsof /var/lib/dpkg/lock-frontend &>/dev/null; then
    echo "AVISO: O apt está em uso por outro processo. Aguarde e tente novamente."
    exit 1
fi
rm -f /var/lib/dpkg/lock-frontend
rm -f /var/cache/apt/archives/lock

## Criando diretório de downloads ##
mkdir -p "$DIRETORIO_DOWNLOADS"   # -p evita erro se já existir

## Atualizando o repositório ##
echo "
ATUALIZANDO OS REPOSITÓRIOS
"
apt update -y

## Atualizando os pacotes ##
echo "
ATUALIZANDO OS PACOTES
"
apt dist-upgrade -y
apt autoremove -y

## Adicionando repositórios de terceiros ##
echo "
ADICIONANDO REPOSITÓRIOS DE TERCEIROS
"
add-apt-repository ppa:papirus/papirus -y

# --------------------------------------------------------------------- #
# ----------------------------- EXECUÇÃO ----------------------------- #

## Atualizando o repositório depois da adição de novos repositórios ##
echo "
ATUALIZANDO OS REPOSITÓRIOS
"
apt update -y

## Instalar programas via apt ##
echo "
INSTALANDO PACOTES APT
"
apt -y install "${LISTA_APT[@]}"

## Download de programas externos ##
echo "
DOWNLOAD DE PACOTES EXTERNOS
"
wget -c "$URL_CHROME" -P "$DIRETORIO_DOWNLOADS"   # -P já define o destino; cd é desnecessário

## Instalando pacotes .deb baixados ##
echo "
INSTALANDO PACOTES EXTERNOS
"
dpkg -i "$DIRETORIO_DOWNLOADS"/*.deb || true   # "|| true" evita que o set -e interrompa em erros de dependência

## Corrigindo possíveis erros de dependência ##
echo "
BUSCANDO POR PACOTES AUSENTES
"
apt update -y
apt install -f -y
apt dist-upgrade -y
apt autoremove -y

## Limpando diretório temporário ##
rm -rf "$DIRETORIO_DOWNLOADS"

## Instalando pacotes Flatpak ##
echo "
INSTALANDO PACOTES FLATPAK
"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y --noninteractive flathub "${LISTA_FLATPAK[@]}"

## Instalando pacotes Snap ##
echo "
INSTALANDO PACOTES SNAP
"
snap refresh

# snap install aceita apenas um pacote por vez
for pacote in "${LISTA_SNAP[@]}"; do
    snap install "$pacote" || echo "AVISO: Falha ao instalar snap '$pacote'. Continuando..."
done

# --------------------------------------------------------------------- #
# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #

echo "
FINALIZANDO INSTALAÇÃO E LIMPANDO O SISTEMA
"
## gsettings set org.gnome.mutter center-new-windows true
## echo "fastfetch" >> .bashrc

apt update && apt dist-upgrade -y
flatpak update -y
apt autoclean
apt autoremove -y

echo "
INSTALAÇÃO CONCLUÍDA! O COMPUTADOR SERÁ REINICIADO.
"
shutdown -r now

# --------------------------------------------------------------------- #