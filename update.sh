#!/usr/bin/env bash

echo -e "\e[1;33m  
*********** ATUALIZANDO O SISTEMA ***********
\e[0m "
sudo apt-get update
echo ""
sudo apt-get dist-upgrade -y
echo ""
sudo snap refresh
echo ""
flatpak update -y
echo ""
sudo apt-get autoclean
echo ""
sudo apt-get autoremove -y
echo -e "\e[1;32m 
*********** O COMPUTADOR ESTÁ ATUALIZADO ***********
\e[0m "
# ---------------------------------------------------------------------- #