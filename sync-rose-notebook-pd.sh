#!/usr/bin/env bash
echo -e "\e[1;33m 
>>>>>>>>>>>>>>> Sincronizando Área de Trabalho. <<<<<<<<<<<<<<<<
\e[0m "
rsync -r -t -v --progress --delete -s -h --exclude=".*/" /home/rosemeire/"Área de Trabalho"/ /media/rosemeire/"Rose 8 GB"/"Área de Trabalho"/
if [[ $? -gt 0 ]] 
then
   echo -e "\e[1;31m  
>>>>>>>>>>>>>>>>>> Área de Trabalho: Falhou. <<<<<<<<<<<<<<<<<<<
\e[0m    "
else
   rm -rf rm /home/pi/queue/*
   echo -e "\e[1;32m  
>>>>>>>>>>>>>>>>> Área de Trabalho: Sucesso. <<<<<<<<<<<<<<<<<<<
\e[0m    "
fi

echo -e "\e[1;33m 
>>>>>>>>>>>>>>>>>>> Sincronizando Documentos. <<<<<<<<<<<<<<<<<<
\e[0m "
rsync -r -t -v --progress --delete -s -h --exclude=".*/" /home/rosemeire/Documentos/ /media/rosemeire/"Rose 8 GB"/Documentos/
if [[ $? -gt 0 ]] 
then
   echo -e "\e[1;31m  
>>>>>>>>>>>>>>>>>>>>>> Documentos: Falhou. <<<<<<<<<<<<<<<<<<<<<
\e[0m    "
else
   rm -rf rm /home/pi/queue/*
   echo -e "\e[1;32m  
>>>>>>>>>>>>>>>>>>>>> Documentos: Sucesso. <<<<<<<<<<<<<<<<<<<<<
\e[0m    "
fi

echo -e "\e[1;33m 
>>>>>>>>>>>>>>>>>>> Sincronizando Downloads. <<<<<<<<<<<<<<<<<<<
\e[0m "
rsync -r -t -v --progress --delete -s -h --exclude=".*/" /home/rosemeire/Downloads/ /media/rosemeire/"Rose 8 GB"/Downloads/
if [[ $? -gt 0 ]] 
then
   echo -e "\e[1;31m  
>>>>>>>>>>>>>>>>>>>>>> Downloads: Falhou. <<<<<<<<<<<<<<<<<<<<<<
\e[0m    "
else
   rm -rf rm /home/pi/queue/*
   echo -e "\e[1;32m  
>>>>>>>>>>>>>>>>>>>>> Downloads: Sucesso. <<<<<<<<<<<<<<<<<<<<<<
\e[0m    "
fi