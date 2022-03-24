#!/usr/bin/env bash
echo -e "\e[1;33m  
>>>>>>>>>>>>>>>>>>>>> ATUALIZANDO O SISTEMA <<<<<<<<<<<<<<<<<<<<<
\e[0m "

echo -e "\e[1;33m  
>>>>>>>>>>>>>>>>>>>> Atualizando pacotes APT <<<<<<<<<<<<<<<<<<<<
\e[0m "

sudo apt update

if [[ $? -gt 0 ]] 
then
echo -e "\e[1;31m  
>>>>>>>>>>>>>>>>>>>>> Repositórios: Falhou. <<<<<<<<<<<<<<<<<<<<<
\e[0m    "
else
rm -rf rm /home/pi/queue/*
echo -e "\e[1;32m  
>>>>>>>>>>>>>>>>>>>>> Repositórios: Sucesso. <<<<<<<<<<<<<<<<<<<<
\e[0m    "
fi

sudo apt dist-upgrade -y

if [[ $? -gt 0 ]] 
then
echo -e "\e[1;31m  
>>>>>>>>>>>>>>>>>>>>>>>>>> Apt: Falhou. <<<<<<<<<<<<<<<<<<<<<<<<<
\e[0m    "
else
rm -rf rm /home/pi/queue/*
echo -e "\e[1;32m  
>>>>>>>>>>>>>>>>>>>>>>>>> Apt: Sucesso. <<<<<<<<<<<<<<<<<<<<<<<<<
\e[0m    "
fi
# ---------------------------------------------------------------------- #
