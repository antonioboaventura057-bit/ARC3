#!/bin/bash

# =================================================================
# ARC - Semana 10: Automação de Usuários via CSV (Padrão Seguro)
# Prof. Gaio | IFSP
# =================================================================

ARQUIVO="rh_lista.csv"
SETOR_ALVO="ti"
SENHA_PADRAO="Mudar@123"

# Pergunta o grupo secundário
read -p "Digite o nome do grupo secundário: " GRUPO_SEC

# Verificação: o arquivo existe e temos permissão de root?
if [ ! -f "$ARQUIVO" ]; then
    echo "[ERRO] Arquivo $ARQUIVO não encontrado!"
    exit 1
fi

if [ "$EUID" -ne 0 ]; then
    echo "[ERRO] Execute como root (sudo)."
    exit 1
fi

# Verifica se o grupo existe, senão cria
if ! getent group "$GRUPO_SEC" > /dev/null; then
    echo "[INFO] Grupo $GRUPO_SEC não existe. Criando..."
    groupadd "$GRUPO_SEC"
fi

echo "--- Iniciando provisionamento para o setor: $SETOR_ALVO ---"

# -----------------------------------------------------------------
# FLUXO DE DADOS
# -----------------------------------------------------------------

grep "$SETOR_ALVO" "$ARQUIVO" | cut -d ";" -f 1 | while read LOGIN; do

    # Verificação de existência
    if id "$LOGIN" &> /dev/null; then
        echo "[PULANDO] O usuário $LOGIN já existe."
    else
        # Criação do usuário
        useradd -m -s /bin/bash "$LOGIN"
        
        # Define senha padrão
        echo "$LOGIN:$SENHA_PADRAO" | chpasswd
        chage -d 0 "$LOGIN"

        # Adiciona ao grupo secundário
        usermod -aG "$GRUPO_SEC" "$LOGIN"
        
        echo "[SUCESSO] Usuário $LOGIN criado e adicionado ao grupo $GRUPO_SEC."
    fi

done

echo "--- Processamento finalizado! ---"
