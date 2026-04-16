#!/bin/bash

#--- 1. Verificação de Privilégios ---
if [ "$EUID" -ne 0 ]
then
    echo "Erro: Este script precisa ser executado como root (use sudo)."
    exit 1
fi

echo "---------------------------------------------------"
echo "   GERENCIADOR DE CONTAS DE USUÁRIO                "
echo "---------------------------------------------------"

# --- 2. Coleta de Dados ---
read -p "Digite o prefixo para os nomes dos novos usuários: " PREFIXO
#Uso de laço de repetição for
for i in {1..10}
do

        NOVO_USUARIO=$PREFIXO$i
        if [ -z "$NOVO_USUARIO" ]
        then
                echo "Erro: O nome do usuário não pode ser vazio."
                exit 1
        fi
        
        # --- 3. Verificação de Existência ---
        id "$NOVO_USUARIO" &> /dev/null

        if [ $? -eq 0 ]
        then
                echo "Alerta: O usuário '$NOVO_USUARIO' já existe no sistema!"
                exit 1
        fi

        # --- 4. Configuração da Senha Padrão ---
        # Definimos uma senha padrão para todos os novos usuários
        SENHA_PADRAO="Mudar@123"

        # --- 5. Criação da Conta ---
        useradd -m -s /bin/bash "$NOVO_USUARIO"

        if [ $? -eq 0 ]
        then
                # --- 6. Definindo a Senha Temporária ---
                # O comando chpasswd recebe "usuario:senha" via pipe
                echo "$NOVO_USUARIO:$SENHA_PADRAO" | chpasswd

                if [ $? -eq 0 ]
                then

                        # --- 7. Forçando a troca de senha no primeiro acesso ---
                        # chage -d 0 define que a senha expirou hoje
                        chage -d 0 "$NOVO_USUARIO"

                        echo "---------------------------------------------------"
                        echo "Sucesso: Conta '$NOVO_USUARIO' criada corretamente."
                        echo "Senha Temporária: $SENHA_PADRAO"
                        echo "AVISO: O usuário será forçado a trocar a senha no 1º login."
                        echo "---------------------------------------------------"
                else
                        echo "Erro ao definir a senha padrão."
                fi
        else
                echo "Erro crítico ao tentar criar a conta no sistema."
        fi

done



