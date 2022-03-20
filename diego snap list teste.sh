#!/usr/bin/env bash
LISTA_SNAP=(
  #code --classic
  indicator-sound-switcher
  photogimp
  telegram-desktop
  visualg
)
## Instalando pacotes Snap ##
echo " 
INSTALANDO PACOTES SNAP
 "
sudo snap install ${LISTA_SNAP[@]}
# ---------------------------------------------------------------------- #