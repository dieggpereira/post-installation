#!/usr/bin/env bash
# ------------------------ COMANDO PARA RODAR ------------------------- #
# ./diego.sh |& tee -a resultados.txt --------------------------------- #

# ----------------------------- VARIÁVEIS ----------------------------- #
URL_PROJETOS="https://www.ifch.unicamp.br/ifch/pf-ifch/webform/pos-graduacao/processo-seletivo/documentos/24461_Formulario-de-Inscricao.pdf"

mkdir $HOME/temp
DIRETORIO_DOWNLOADS="$HOME/temp"


## Download e instalaçao de programas externos ##
echo " 
DOWNLOAD DE PACOTES EXTERNOS
 "
cd "$DIRETORIO_DOWNLOADS"
wget -c "$URL_PROJETOS"       -P "$DIRETORIO_DOWNLOADS"

# ---------------------------------------------------------------------- #