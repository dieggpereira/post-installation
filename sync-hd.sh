#!/usr/bin/env bash
echo " 
Sincronizando Documentos.
 "
rsync -r -t -v --progress --delete -s /home/diego/Documents /media/diego/Diego 1 TB/Diego/Backup/
echo " 
Sincronizando Filmes.
 "
rsync -r -t -v --progress -s /home/diego/Vidéos/Filmes /media/diego/Diego 1 TB/Diego
echo " 
Sincronizando Imagens.
 "
rsync -r -t -v --progress -s /home/diego/Images /media/diego/Diego 1 TB/Diego/Backup