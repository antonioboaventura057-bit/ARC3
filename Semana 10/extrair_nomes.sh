#!/bin/bash

# Arquivo de origem
ARQUIVO="/etc/passwd"

# Verificação de existência
if [ ! -f "$ARQUIVO" ]; then
    echo "[ERRO] Arquivo $ARQUIVO não encontrado!"
    exit 1
fi

echo "--- Lista de usuários do sistema ---"

# Extraindo apenas a primeira coluna (nomes de usuários)
cut -d ":" -f 1 "$ARQUIVO"

echo "--- Fim da lista ---"
