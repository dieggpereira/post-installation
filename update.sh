#!/usr/bin/env bash
echo -e "\e[1;33m
>>>>>>>>>>>>>>>>>>>> REMOVENDO TRAVAS DO APT <<<<<<<<<<<<<<<<<<<<
\e[0m "
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock

if [[ $? -gt 0 ]] 
then
echo -e "\e[1;31m  
>>>>>>>>>>>>>>>>>>> Remover travas: Falhou. <<<<<<<<<<<<<<<<<<<<<
\e[0m    "
else
rm -rf rm /home/pi/queue/*
echo -e "\e[1;32m  
>>>>>>>>>>>>>>>>>>> Remover travas: Sucesso. <<<<<<<<<<<<<<<<<<<<
\e[0m    "
fi

echo -e "\e[1;33m  
>>>>>>>>>>>>>>>>>>>>> ATUALIZANDO O SISTEMA <<<<<<<<<<<<<<<<<<<<<
\e[0m "

echo -e "\e[1;33m  
>>>>>>>>>>>>>>>>>>>> Atualizando pacotes APT <<<<<<<<<<<<<<<<<<<<
\e[0m "

sudo nala update

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

sudo nala upgrade -y

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
echo -e "\e[1;33m  
>>>>>>>>>>>>>>>>>>>>>>> Atualizando Snaps <<<<<<<<<<<<<<<<<<<<<<<
\e[0m "
sudo snap refresh
if [[ $? -gt 0 ]] 
then
   echo -e "\e[1;31m  
>>>>>>>>>>>>>>>>>>>>>>>> Snaps: Falhou. <<<<<<<<<<<<<<<<<<<<<<<<<
\e[0m    "
else
   rm -rf rm /home/pi/queue/*
   echo -e "\e[1;32m  
>>>>>>>>>>>>>>>>>>>>>>>> Snaps: Sucesso. <<<<<<<<<<<<<<<<<<<<<<<<
\e[0m    "
fi
echo -e "\e[1;33m  
>>>>>>>>>>>>>>>>>>>>>> Atualizando Flatpaks <<<<<<<<<<<<<<<<<<<<<
\e[0m "
flatpak update -y
if [[ $? -gt 0 ]] 
then
   echo -e "\e[1;31m  
>>>>>>>>>>>>>>>>>>>>>>> Flatpaks: Falhou. <<<<<<<<<<<<<<<<<<<<<<<
\e[0m    "
else
   rm -rf rm /home/pi/queue/*
   echo -e "\e[1;32m  
>>>>>>>>>>>>>>>>>>>>>> Flatpaks: Sucesso. <<<<<<<<<<<<<<<<<<<<<<<
\e[0m    "
fi
echo -e "\e[1;33m  
>>>>>>>>>>>>>>>>>>>>>> Limpando o sistema <<<<<<<<<<<<<<<<<<<<<<<
\e[0m "
rm /home/diego/Images/Captures\ d’écran/*.png ## Apaga as capturas de tela salvas na memória do computador
sudo nala clean
if [[ $? -gt 0 ]] 
then
   echo -e "\e[1;31m  
>>>>>>>>>>>>>>>>>>>>>> Autoclean: Falhou. <<<<<<<<<<<<<<<<<<<<<<<
\e[0m    "
else
   rm -rf rm /home/pi/queue/*
   echo -e "\e[1;32m  
>>>>>>>>>>>>>>>>>>>>> Autoclean: Sucesso. <<<<<<<<<<<<<<<<<<<<<<<
\e[0m    "
fi

sudo nala autoremove -y
if [[ $? -gt 0 ]] 
then
   echo -e "\e[1;31m  
>>>>>>>>>>>>>>>>>>>>>> Autoremove: Falhou. <<<<<<<<<<<<<<<<<<<<<<
\e[0m    "
else
   rm -rf rm /home/pi/queue/*
   echo -e "\e[1;32m  
>>>>>>>>>>>>>>>>>>>>> Autoremove: Sucesso. <<<<<<<<<<<<<<<<<<<<<<
\e[0m    "
fi
echo -e "\e[1;33m 
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Fim <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
\e[0m "
# ---------------------------------------------------------------------- #