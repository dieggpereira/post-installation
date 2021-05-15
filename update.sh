#!/usr/bin/env bash

echo " 
*********** ATUALIZANDO O SISTEMA ***********
 "
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
echo " 
*********** O COMPUTADOR ESTÁ ATUALIZADO ***********
 "
# ---------------------------------------------------------------------- #