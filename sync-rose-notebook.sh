#!/usr/bin/env bash
echo -e "\e[1;33m 
>>>>>>>>>>>>>>>>>>> Sincronizando Pasta pessoal. <<<<<<<<<<<<<<<<<<<
\e[0m "
rsync -r -t -v --progress --delete -s -h --exclude=".*/" /home/rosemeire/ /media/rosemeire/"Diego 1 TB"/Diego/Backup/Rose/"Ubuntu Notebook"/
if [[ $? -gt 0 ]] 
then
   echo -e "\e[1;31m  
>>>>>>>>>>>>>>>>>>>>>> Pasta pessoal: Falhou. <<<<<<<<<<<<<<<<<<<<<<
\e[0m    "
else
   rm -rf rm /home/pi/queue/*
   echo -e "\e[1;32m  
>>>>>>>>>>>>>>>>>>>>> Pasta pessoal: Sucesso. <<<<<<<<<<<<<<<<<<<<<<
\e[0m    "
fi
