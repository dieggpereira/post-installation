#!/bin/bash

# Defina o diretório de origem e destino
diretorio_origem="/home/diego/Documents/Adunicamp/AtoM 2023/Tabelas 2023/Boletins/Digitalizações/originais"
diretorio_destino="/home/diego/Documents/Adunicamp/AtoM 2023/Tabelas 2023/Boletins/Digitalizações/pós-ocr"
diretorio_sucesso="/home/diego/Documents/Adunicamp/AtoM 2023/Tabelas 2023/Boletins/Digitalizações/originais/arquivado"
diretorio_erro="/home/diego/Documents/Adunicamp/AtoM 2023/Tabelas 2023/Boletins/Digitalizações/originais/erro"

# Verifique se o ocrmypdf está instalado
if ! command -v ocrmypdf &> /dev/null; then
    echo "O ocrmypdf não está instalado. Por favor, instale-o antes de prosseguir."
    exit 1
fi

# Verifique se o diretório de origem existe
if [ ! -d "$diretorio_origem" ]; then
    echo "O diretório de origem não existe."
    exit 1
fi

# Crie o diretório de destino se ele não existir
mkdir -p "$diretorio_destino"

# Conte o número total de arquivos PDF na pasta de origem
cont_arquivo=1
total_arquivos=$(ls "$diretorio_origem"/*.pdf | wc -l)

# Loop através de todos os arquivos PDF no diretório de origem
for arquivo in "$diretorio_origem"/*.pdf; do
    # Verifique se o item é um arquivo PDF
    if [ -f "$arquivo" ]; then
        # Obtenha o nome do arquivo sem o diretório
        nome_arquivo=$(basename -- "$arquivo")
        # Remova a extensão do arquivo
        nome_sem_extensao="${nome_arquivo%.pdf}"
        echo -e "\e[1;33m
> Executando o OCR no arquivo $nome_arquivo.
> Este é o arquivo "$cont_arquivo"/"$total_arquivos".
        \e[0m"
# Execute o ocrmypdf para adicionar OCR ao arquivo e salve-o no diretório de destino
ocrmypdf -l por -d --title 'Boletim Adunicamp' --author 'Associação de Docentes da Unicamp - Adunicamp' "$arquivo" "$diretorio_destino/${nome_sem_extensao}.pdf"
if [[ $? -gt 0 ]] 
then
	echo -e "\e[1;31m 
> O OCR em "$nome_arquivo" falhou. Ele será movido para o diretório de erros. 
	\e[0m    "
	mv "$arquivo" "$diretorio_erro"
	else
	rm -rf rm /home/pi/queue/*
	echo -e "\e[1;32m  
> O OCR em "$nome_arquivo" foi executado com sucesso.
	\e[0m    "
	mv "$arquivo" "$diretorio_sucesso"
	fi
        let cont_arquivo++
    fi
done

echo -e "\e[1;32m
> Processamento concluído em: $(date +%T).
        \e[0m"

