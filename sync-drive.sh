#!/usr/bin/env bash
echo -e "\e[1;33m 
>>>>>>>>>>>>>>>>>>>>>> Sincronizando Leme. <<<<<<<<<<<<<<<<<<<<<<
\e[0m "
rclone sync ~/Documents/Leme/ 'Drive Unicamp':Leme -P
if [[ $? -gt 0 ]] 
then
   echo -e "\e[1;31m  
>>>>>>>>>>>>>>>>>>>>>>>>> Leme: Falhou. <<<<<<<<<<<<<<<<<<<<<<<<<
\e[0m    "
else
   rm -rf rm /home/pi/queue/*
   echo -e "\e[1;32m  
>>>>>>>>>>>>>>>>>>>>>>>> Leme: Sucesso. <<<<<<<<<<<<<<<<<<<<<<<<<
\e[0m    "
fi

echo -e "\e[1;34m 
Concluído em: $(date +%T). \e[0m"
echo " "