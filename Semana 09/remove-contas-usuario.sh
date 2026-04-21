#!/bin/bash

# Verifica se o script está sendo executado como root
if [[ $EUID -ne 0 ]]; then
   echo "Este script precisa ser executado como root (use sudo)."
   exit 1
fi

# Defina aqui o prefixo comum dos usuários
PREFIXO="aluno"

echo "Iniciando a remoção de usuários com o prefixo: $PREFIXO"

# 1. Filtra os usuários no /etc/passwd que começam com o prefixo seguido de números
# 2. O comando 'cut' pega apenas o primeiro campo (o nome do usuário)
USUARIOS=$(grep -E "^${PREFIXO}[0-9]+" /etc/passwd | cut -d: -f1)

if [ -z "$USUARIOS" ]; then
    echo "Nenhum usuário encontrado com o prefixo '$PREFIXO' seguido de números."
    exit 0
fi

for USUARIO in $USUARIOS; do
    echo "Removendo usuário: $USUARIO ..."
    
    # deluser com --remove-home para apagar o diretório pessoal
    # O redirecionamento &>/dev/null limpa a saída, remova se quiser ver os logs
    deluser --remove-home "$USUARIO"
    
    if [ $? -eq 0 ]; then
        echo "Usuário $USUARIO removido com sucesso."
    else
        echo "Erro ao remover o usuário $USUARIO."
    fi
done
