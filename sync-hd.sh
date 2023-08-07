#!/usr/bin/env bash
echo -e "\e[1;33m 
>>>>>>>>>>>>>>>>>>> Sincronizando Documentos. <<<<<<<<<<<<<<<<<<<
\e[0m "
rsync -rtvsh --progress --delete /home/diego/Documents /media/diego/"Diego 1 TB"/Diego/"Backup Diego"
if [[ $? -gt 0 ]] 
then
   echo -e "\e[1;31m  
>>>>>>>>>>>>>>>>>>>>>> Documentos: Falhou. <<<<<<<<<<<<<<<<<<<<<<
\e[0m    "
else
   rm -rf rm /home/pi/queue/*
   echo -e "\e[1;32m  
>>>>>>>>>>>>>>>>>>>>> Documentos: Sucesso. <<<<<<<<<<<<<<<<<<<<<<
\e[0m    "
fi
echo -e "\e[1;33m 
>>>>>>>>>>>>>>>>>>>>> Sincronizando Filmes. <<<<<<<<<<<<<<<<<<<<<
\e[0m "
rsync -rtvsh --progress /home/diego/Vidéos/Filmes /media/diego/"Diego 1 TB"/Diego
if [[ $? -gt 0 ]] 
then
   echo -e "\e[1;31m  
>>>>>>>>>>>>>>>>>>>>>>>> Filmes: Falhou. <<<<<<<<<<<<<<<<<<<<<<<<
\e[0m    "
else
   rm -rf rm /home/pi/queue/*
   echo -e "\e[1;32m  
>>>>>>>>>>>>>>>>>>>>>>>> Filmes: Sucesso. <<<<<<<<<<<<<<<<<<<<<<<
\e[0m    "
fi
echo -e "\e[1;33m 
>>>>>>>>>>>>>>>>>>>>> Sincronizando Imagens. <<<<<<<<<<<<<<<<<<<<
\e[0m "
rsync -rtvsh --progress --delete --exclude 'Captures d’écran' /home/diego/Images /media/diego/"Diego 1 TB"/Diego/"Backup Diego"
if [[ $? -gt 0 ]] 
then
   echo -e "\e[1;31m  
>>>>>>>>>>>>>>>>>>>>>>> Imagens: Falhou. <<<<<<<<<<<<<<<<<<<<<<<<
\e[0m    "
else
   rm -rf rm /home/pi/queue/*
   echo -e "\e[1;32m  
>>>>>>>>>>>>>>>>>>>>>>> Imagens: Sucesso. <<<<<<<<<<<<<<<<<<<<<<< 
\e[0m    "
echo -e "\e[1;33m 
>>>>>>>>>>>>>>>>>>> Finalizando transferências. <<<<<<<<<<<<<<<<< \e[0m "
sync
echo -e "\e[1;34m 
Concluído em: $(date +%T). \e[0m"
echo " "
fi
