#!/usr/bin/env bash
echo -e "\e[1;33m 
>>>>>>>>>>>>>>>>>>> Sincronizando Documentos. <<<<<<<<<<<<<<<<<<<
\e[0m "
rsync -r -t -v --progress --delete --size-only --modify-window=1 -s /home/diego/Documents /mnt/Arquivos
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
>>>>>>>>>>>>>>>>> Sincronizando Digitalizações. <<<<<<<<<<<<<<<<<
\e[0m "
rsync -r -t -v --progress --delete --size-only --modify-window=1 -s /home/diego/Images/Digitalizações /mnt/Arquivos
if [[ $? -gt 0 ]] 
then
   echo -e "\e[1;31m  
>>>>>>>>>>>>>>>>>>>> Digitalizações: Falhou. <<<<<<<<<<<<<<<<<<<<
\e[0m    "
else
   rm -rf rm /home/pi/queue/*
   echo -e "\e[1;32m  
>>>>>>>>>>>>>>>>>>> Digitalizações: Sucesso. <<<<<<<<<<<<<<<<<<<<
\e[0m    "
fi

echo -e "\e[1;33m 
>>>>>>>>>>>>>>>>>>> Finalizando transferências. <<<<<<<<<<<<<<<<< \e[0m "
sync
echo -e "\e[1;34m 
Concluído em: $(date +%T). \e[0m"
echo " "
