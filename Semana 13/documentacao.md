# Histórico de Configuração: Servidor de Logs Centralizado (rsyslog)

Grupo: Antônio Mariano (BV3054195) e Marcelo de Lima (BV3054543)

Disciplina: ARC3

Professor: Gaio

## 1. Introdução e Objetivos

**Usuário:** Solicitou ajuda para configurar um servidor de logs (receptor) e um cliente (gerador) no GNU/Linux para fins de aprendizado e monitoramento.

**Gemini:** Explicou o papel do `rsyslog`, a diferença entre protocolos UDP e TCP e apresentou a estrutura básica de configuração.

---

## 2. Configuração do Zero (Cenário de Rede)

**Usuário:** Informou que não havia nada configurado e que as máquinas estavam na mesma rede.

**Gemini:** Forneceu os comandos limpos para o Servidor e o Cliente.

* **Servidor:** Habilitação do módulo `imudp` na porta 514 e criação de um `$template` para organizar logs em `/var/log/clientes/%HOSTNAME%/`.
* **Cliente:** Apontamento dos logs para o IP do servidor usando `*.* @IP_DO_SERVIDOR:514`.

---

## 3. Visualização e Permissões de Arquivo

**Usuário:** Tentou visualizar os logs usando `cat` e `ls`, mas recebeu erros de "Permissão Negada" e "Arquivo inexistente".

**Gemini:** Identificou erros de sintaxe no comando `cat` (espaços extras) e explicou que o `*` (curinga) não funciona bem diretamente com `sudo` devido à expansão do shell.

* **Comando correto sugerido:** `sudo tail -f /var/log/clientes/VM-LAB-UBUNTU/TESTE_REDE.log`

---

## 4. Depuração de Erros de Escrita e Rate-Limiting

**Usuário:** Conseguiu receber o primeiro log, mas os seguintes não chegavam e o servidor começou a exibir erros de:
`rsyslogd: error during config processing: omfile: creating parent directories... failed: Permission denied`.

**Gemini:** Diagnosticou que o usuário `syslog` não tinha permissão para criar pastas dentro de `/var/log/clientes`.

* **Solução de Permissões:**
```bash
sudo chown -R syslog:adm /var/log/clientes
sudo chmod -R 775 /var/log/clientes

```

* **Solução de Rate-Limit (Remover limite de mensagens):**
Adição das linhas no `rsyslog.conf`:

```text
    $SystemLogRateLimitInterval 0
    $SystemLogRateLimitBurst 0
    ```

---

## 5. Resumo das Ferramentas Utilizadas
*   **rsyslog:** O serviço de gerenciamento de logs.
*   **logger:** Ferramenta do cliente para gerar mensagens de teste.
*   **tail -f:** Comando para monitorar a chegada de logs em tempo real.
*   **chown/chmod:** Comandos para ajustar permissões de sistema.

---

### Guia de Consulta Rápida (Comandos Finais)

**No Cliente (Gerar log):**
`logger -t TESTE_REDE "Mensagem de Teste"`

**No Servidor (Monitorar):**
`sudo tail -f /var/log/clientes/VM-LAB-UBUNTU/TESTE_REDE.log`

--- 
*Fim do registro da conversa.*

```
