# 🕵️ Pesquisa Técnica: O Protocolo SNMP

**Disciplina:** Administração de Redes de Computadores (ARC)
**Semana:** 11
**Professor:** Gaio

---

## 1. O Papel do SNMP

O **SNMP** (*Simple Network Management Protocol* — Protocolo Simples de Gerenciamento de Rede) é um protocolo da camada de aplicação, pertencente ao conjunto de protocolos TCP/IP, projetado para permitir que administradores de redes monitorem, gerenciem e controlem dispositivos de rede de forma centralizada. Sua finalidade principal é padronizar a troca de informações de gerência entre um sistema gerenciador e os dispositivos gerenciados — como roteadores, switches, servidores, impressoras, firewalls e outros equipamentos de infraestrutura (BASSO, 2012).

Por meio do SNMP, o administrador pode consultar o estado de interfaces de rede, verificar a utilização de CPU e memória de um roteador, receber alertas automáticos sobre falhas, alterar configurações remotamente e coletar dados históricos de desempenho — tudo a partir de uma única estação de gerência.

### Por que a Interoperabilidade é Fundamental?

Ambientes corporativos reais são compostos por equipamentos de múltiplos fabricantes: roteadores Cisco, switches HP/Aruba, servidores Dell, impressoras Brother, pontos de acesso Ubiquiti, entre outros. Sem um protocolo padronizado, cada fabricante utilizaria sua própria linguagem e interface de gerência, tornando o monitoramento centralizado inviável.

A **interoperabilidade** garantida pelo SNMP resolve este problema ao:

- Definir uma estrutura de dados comum (a MIB) que todos os fabricantes devem implementar;
- Estabelecer um conjunto padronizado de mensagens de comunicação;
- Permitir que ferramentas de gerência de terceiros dialoguem com qualquer dispositivo que implemente o protocolo, independentemente do fabricante.

Segundo Basso (2012), a padronização promovida pelo SNMP foi determinante para a consolidação do gerenciamento de redes em ambientes heterogêneos, eliminando a dependência de soluções proprietárias e facilitando a integração de novos equipamentos à infraestrutura existente.

---

## 2. Evolução e Versões (v1, v2c e v3)

O SNMP passou por três grandes revisões desde sua criação, cada uma buscando corrigir limitações da versão anterior, especialmente em relação à segurança e ao desempenho.

### Quadro Comparativo

| Característica | SNMPv1 | SNMPv2c | SNMPv3 |
|---|---|---|---|
| **Ano de publicação** | 1988 (RFC 1067) | 1993 (RFC 1901) | 1999 (RFC 3411–3418) |
| **Autenticação** | Community string (texto claro) | Community string (texto claro) | Autenticação baseada em usuário (MD5/SHA) |
| **Privacidade (Criptografia)** | Nenhuma | Nenhuma | DES / AES (opcional) |
| **Controle de acesso** | Baseado em community string | Baseado em community string | VACM (*View-based Access Control Model*) |
| **Operação GetBulk** | Não suportada | Suportada | Suportada |
| **Tratamento de erros** | Limitado | Aprimorado | Aprimorado |
| **Recomendação atual** | Legado | Legado | ✅ Recomendada |

### SNMPv1

A primeira versão, definida em 1988, introduziu os conceitos fundamentais do protocolo: gerente, agente e MIB. A autenticação era realizada exclusivamente por meio de **community strings** — sequências de texto simples (como `public` para leitura e `private` para escrita) transmitidas em texto claro no payload UDP. A ausência de criptografia tornava a interceptação trivial. Além disso, o suporte a apenas 32 bits para contadores limitava a representação de valores em interfaces de alta velocidade (BASSO, 2012).

### SNMPv2c

A versão 2c (*community-based SNMPv2*) trouxe melhorias significativas de **desempenho** com a introdução da operação **GetBulk**, que permite recuperar grandes volumes de dados da MIB em uma única requisição, reduzindo o número de trocas de mensagens necessárias. Também aprimorou o tratamento de erros e expandiu os contadores para 64 bits (tipo `Counter64`), essencial para interfaces Gigabit e superiores. No entanto, manteve o mesmo mecanismo de autenticação frágil por community string em texto claro do SNMPv1, sem qualquer criptografia de dados (BASSO, 2012).

### SNMPv3 — O Padrão Atual

O SNMPv3 representa uma reestruturação completa do modelo de segurança do protocolo, sendo a **versão recomendada para ambientes corporativos**. Seus diferenciais técnicos são:

- **Autenticação de usuários (USM — *User-based Security Model*):** Utiliza algoritmos HMAC-MD5 ou HMAC-SHA para garantir que as mensagens realmente provêm de uma fonte confiável, eliminando o uso de community strings.
- **Criptografia (privacidade):** Suporte a DES (56 bits, considerado fraco) e AES-128 (recomendado) para cifrar o conteúdo das mensagens, protegendo os dados em trânsito contra interceptação.
- **Controle de acesso granular (VACM — *View-based Access Control Model*):** Permite definir, por usuário ou grupo, quais objetos da MIB podem ser lidos ou escritos, oferecendo controle fino sobre as permissões de gerência.
- **Proteção contra ataques de replay:** Mecanismo baseado em *engine ID* e contadores de tempo impede a reutilização de mensagens capturadas.

A escolha do SNMPv3 para ambientes corporativos é justificada pelo cumprimento de requisitos de conformidade e segurança exigidos por frameworks como ISO/IEC 27001 e regulamentações setoriais, além de eliminar as vulnerabilidades críticas de suas antecessoras (BASSO, 2012).

---

## 3. Arquitetura e Funcionamento

Um sistema de gerência SNMP é composto por três elementos fundamentais que interagem entre si: o **Gerente (NMS)**, o **Agente** e a **MIB**.

```
  ┌─────────────────────────────────┐           ┌─────────────────────┐
  │   NMS - Network Management      │           │   Dispositivo        │
  │         Station                 │           │   Gerenciado         │
  │                                 │  UDP 161  │                     │
  │  ┌──────────┐  ┌─────────────┐  │◄─────────►│  ┌───────────────┐ │
  │  │ Software │  │   Console   │  │           │  │    Agente     │ │
  │  │  de NMS  │  │  de Alarmes │  │  UDP 162  │  │    SNMP       │ │
  │  └──────────┘  └─────────────┘  │◄──────────│  └───────┬───────┘ │
  │                                 │  (Traps)  │          │         │
  └─────────────────────────────────┘           │  ┌───────▼───────┐ │
                                                │  │     MIB       │ │
                                                │  └───────────────┘ │
                                                └─────────────────────┘
```

### 3.1 Gerente — NMS (*Network Management Station*)

O **Gerente** é o elemento central do sistema de gerência, implementado como um software executado em uma estação ou servidor dedicado. Suas responsabilidades incluem (BASSO, 2012):

- **Enviar requisições** aos agentes para consultar (`GET`) ou alterar (`SET`) valores de variáveis na MIB;
- **Receber e processar notificações** (*Traps* e *Informs*) enviadas pelos agentes em caso de eventos relevantes;
- **Correlacionar e armazenar** os dados coletados em bases de dados para análise histórica;
- **Gerar alertas e relatórios** para o administrador de rede através de dashboards e sistemas de notificação.

O NMS opera como um cliente SNMP, iniciando ativamente as consultas aos agentes via **porta UDP 161** e recebendo notificações na **porta UDP 162**.

### 3.2 Agente (*Agent*)

O **Agente SNMP** é um processo de software que reside diretamente no dispositivo gerenciado (roteador, switch, servidor, impressora etc.). Ele atua como intermediário entre o NMS e os recursos internos do dispositivo, executando as seguintes funções (BASSO, 2012):

- **Responder às requisições** do gerente, lendo ou escrevendo valores nas variáveis da MIB local;
- **Monitorar continuamente** o estado do dispositivo e seus recursos;
- **Gerar notificações proativas** (*Traps*) e enviá-las ao gerente sem que haja uma requisição prévia, alertando sobre condições anômalas como falha de interface, reinicialização do equipamento ou ultrapassagem de limiar de utilização.

O agente é, portanto, o "sensor" do sistema, tendo conhecimento direto do estado real do hardware e software do dispositivo.

### 3.3 MIB — *Management Information Base*

A **MIB** é uma base de informações que define, de forma estruturada, todos os objetos gerenciáveis de um dispositivo. É importante compreender que a MIB não é um banco de dados em disco — ela é uma **especificação formal**, escrita na linguagem **SMI** (*Structure of Management Information*), que descreve quais variáveis existem, seus tipos de dados, permissões de acesso (leitura, escrita) e semântica (BASSO, 2012).

A MIB é organizada hierarquicamente como uma **árvore de objetos**, semelhante a um sistema de arquivos. Cada nó da árvore representa uma categoria ou um objeto específico. Os nós são agrupados por organização responsável pela definição:

```
raiz (.)
  └── iso (1)
        └── org (3)
              └── dod (6)
                    └── internet (1)
                          ├── mgmt (2)
                          │     └── mib-2 (1)
                          │           ├── system (1)
                          │           ├── interfaces (2)
                          │           ├── ip (4)
                          │           └── tcp (6)
                          └── enterprises (4)
                                ├── cisco (9)
                                ├── hp (11)
                                └── ...
```

A MIB-2 (padronizada pela IETF) define os objetos comuns a todos os dispositivos IP. Abaixo do nó `enterprises`, cada fabricante pode definir MIBs proprietárias com objetos específicos de seus equipamentos.

### 3.4 OID — *Object Identifier*

O **OID** é o mecanismo de endereçamento universal que identifica de forma única e inequívoca cada objeto dentro da hierarquia da MIB. É representado como uma sequência numérica de inteiros separados por pontos, onde cada número corresponde a um nó na árvore da MIB (BASSO, 2012).

**Exemplo prático:**

| OID Numérico | Nome do Objeto | Significado |
|---|---|---|
| `.1.3.6.1.2.1.1.1.0` | `sysDescr.0` | Descrição textual do sistema |
| `.1.3.6.1.2.1.1.3.0` | `sysUpTime.0` | Tempo de funcionamento do dispositivo |
| `.1.3.6.1.2.1.2.2.1.10.1` | `ifInOctets.1` | Bytes recebidos na interface 1 |

O número `0` ao final de um OID indica que se trata de uma instância escalar (objeto com valor único). Para tabelas, o último número identifica o índice da linha.

Quando o NMS envia uma requisição `GET`, ele especifica o OID do objeto desejado; o agente localiza a variável correspondente em sua MIB local e retorna o valor atual.

---

## 4. Ecossistema de Softwares de Gerência SNMP

O SNMP coleta os dados, mas ferramentas especializadas são necessárias para armazená-los, visualizá-los e transformá-los em informações úteis ao administrador. A seguir, são apresentadas algumas das principais soluções profissionais do mercado.

### 4.1 Zabbix

O **Zabbix** é uma plataforma de monitoramento de código aberto, amplamente adotada em ambientes corporativos. Oferece suporte nativo a SNMP v1, v2c e v3, permitindo a descoberta automática de dispositivos (*auto-discovery*), coleta de métricas via polling e recebimento de *Traps*. Possui dashboards altamente customizáveis, sistema de alertas com escalonamento, geração de relatórios e gráficos históricos. É distribuído sob licença GPL e não requer pagamento de licenças (BASSO, 2012).

**Casos de uso:** Monitoramento de roteadores, switches, servidores físicos e virtuais, serviços de rede e aplicações.

### 4.2 Nagios

O **Nagios** é uma das ferramentas de monitoramento de redes mais consolidadas do mercado open source, existente desde 1999. Monitora disponibilidade de hosts e serviços, com suporte a SNMP para coleta de dados de dispositivos de rede. Sua arquitetura baseada em plugins permite alta extensibilidade. Disponível na versão *Nagios Core* (gratuita e open source) e *Nagios XI* (versão comercial com interface web aprimorada e suporte empresarial) (BASSO, 2012).

**Casos de uso:** Monitoramento de disponibilidade (*uptime*), detecção de falhas e envio de notificações por e-mail ou SMS.

### 4.3 SolarWinds Network Performance Monitor (NPM)

O **SolarWinds NPM** é uma solução comercial amplamente utilizada em grandes corporações e provedores de serviços. Oferece funcionalidades avançadas de gerência SNMP, como descoberta automática da topologia de rede, mapeamento visual de infraestrutura, análise de desempenho com *baselining* automático e correlação de eventos. Integra-se nativamente com outros módulos da suíte SolarWinds para gerência unificada (BASSO, 2012).

**Casos de uso:** NOCs (*Network Operations Centers*), ambientes com centenas ou milhares de dispositivos gerenciados, análise de causa raiz de incidentes.

### 4.4 PRTG Network Monitor

O **PRTG** (*Paessler Router Traffic Grapher*) é uma solução comercial da Paessler AG, com modelo de licenciamento baseado em número de sensores monitorados. Suporta SNMP, WMI, NetFlow, sFlow e outros protocolos de monitoramento em uma única interface. Destaca-se pela facilidade de configuração, interface web responsiva e aplicativo móvel para acompanhamento de alertas (BASSO, 2012).

**Casos de uso:** Empresas de médio porte que necessitam de uma ferramenta all-in-one de fácil implantação.

### 4.5 Cacti

O **Cacti** é uma ferramenta open source focada na coleta e visualização de dados de desempenho via SNMP, utilizando o **RRDtool** como backend para armazenamento circular de dados e geração de gráficos. Embora menos completo que o Zabbix em termos de alertas, é altamente eficiente para análise de tendências de utilização de banda, CPU e memória ao longo do tempo (BASSO, 2012).

**Casos de uso:** Análise gráfica de tendências de desempenho, complementação de outras ferramentas de monitoramento.

---

## 📚 Referência Bibliográfica (ABNT)

BASSO, Douglas Eduardo. **Administração de Redes de Computadores**. Curitiba: InterSaberes, 2012.

---

*Pesquisa elaborada com base na obra indicada para a disciplina de Administração de Redes de Computadores (ARC), Semana 11.*
