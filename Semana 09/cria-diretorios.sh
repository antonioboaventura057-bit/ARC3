#!/bin/bash

# Define o nome base da disciplina
DISCIPLINA="Administracao_de_Redes"

echo "Iniciando a criação dos diretórios para $DISCIPLINA..."

# O laço for percorre de 1 a 20
# O comando seq -w garante que os números tenham o mesmo comprimento (01, 02... 20)
for i in $(seq -w 1 20); do
    NOME_PASTA="Semana_$i"
    
    # Cria o diretório. O -p evita erros caso a pasta já exista.
    mkdir -p "$NOME_PASTA"
    
    echo "Pasta criada: $NOME_PASTA"
done
