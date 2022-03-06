#!/usr/bin/env bash
echo -e "\e[1;33m 
>>>>>>>>>>>>>>>>>>> Sincronizando Documentos. <<<<<<<<<<<<<<<<<<<
\e[0m "
rsync -r -t -v --progress --delete -s -h /home/diego/Documents/Leme /media/diego/"Diego 8 GB"
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

echo -e "\e[1;34m 
Concluído em: $(date +%T). \e[0m"
echo " "