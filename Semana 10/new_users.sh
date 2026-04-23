#!/bin/bash

# =================================================================
# ARC - Semana 10: Automação de Usuários via CSV (Padrão Seguro)
# Prof. Gaio | IFSP
# =================================================================

ARQUIVO="rh_lista.csv"
SETOR_ALVO="ti"
SENHA_PADRAO="Mudar@123"

# Verificação: o arquivo existe e temos permissão de root?
if [ ! -f "$ARQUIVO" ]; then
    echo "[ERRO] Arquivo $ARQUIVO não encontrado!"
    exit 1
fi

if [ "$EUID" -ne 0 ]; then
    echo "[ERRO] Execute como root (sudo)."
    exit 1
fi

echo "--- Iniciando provisionamento para o setor: $SETOR_ALVO ---"

# -----------------------------------------------------------------
# FLUXO DE DADOS:
# 1. 'grep' filtra as linhas do setor alvo
# 2. 'cut' isola a primeira coluna (nome_sobrenome)
# 3. 'while' processa cada nome resultante
# -----------------------------------------------------------------

grep "$SETOR_ALVO" "$ARQUIVO" | cut -d ";" -f 1 | while read LOGIN; do

    # Verificação de existência
    if id "$LOGIN" &> /dev/null; then
        echo "[PULANDO] O usuário $LOGIN já existe."
    else
        # Criação seguindo as boas práticas
        useradd -m -s /bin/bash "$LOGIN"
        
        # Senha padrão com expiração imediata para o 1º login
        echo "$LOGIN:$SENHA_PADRAO" | chpasswd
        chage -d 0 $LOGIN
        
        echo "[SUCESSO] Usuário $LOGIN criado (Setor: $SETOR_ALVO)."
    fi

done

echo "--- Processamento finalizado! ---"
