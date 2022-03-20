#!/usr/bin/env bash
# ------------------------ COMANDO PARA RODAR ------------------------- #
# sudo ./diego.sh |& tee -a resultados.txt --------------------------------- #

# ----------------------------- VARIÁVEIS ----------------------------- #

LISTA_SNAP=(
  code --classic
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