Nome: Antônio Augusto Boaventura Mariano

Prontuário: BV3054195

Disciplina: ARC3 

Semana: 12

Atividade Principal:

1) Print da sua topologia no Packet Tracer:
   
![Topologia Principal](/topologiaPrincipal.png)

2) Quais foram os valores retornados pelo comando sysDescr e sysLocation:

sysDescr:

Name/0ID: .1.3.6.1.2.1.1.1.0  (.iso.org.dod.internet.mgmt.mib-2.system.sysDescr.0)

Value:

Cisco IOS Software, C2900 Software (C2900-UNIVERSALK9-M), Version 15.1(4)M4, RELEASE SOFTWARE (fc2)
Technical Support: http://www.cisco.com/techsupport
Copyright (c) 1986-2012 by Cisco Systems, Inc.
Compiled Thurs 5-Jan-12 15:41 by pt_team

Type: OctetString

<br>

sysLocation:

Name/0ID: .1.3.6.1.2.1.1.6.0  (.iso.org.dod.internet.mgmt.mib-2.system.sysLocation.0)

Value:

Type: OctetString

3) Reflexão: Por que em uma rede real nós evitamos usar a community string public e preferimos o SNMPv3? (Dica: pense na segurança do prontuário médico!).

No SNMPv2c o uso da community string public deixa "a chave da porta da frente debaixo do tapete": qualquer um que saiba onde procurar (ou que use um scanner de rede básico) pode entrar.

Já no SNMPv3 é utilizado o modelo de segurança baseado no usuário (USM). Ele exige um nome de usuário e uma senha sejam verificados via algoritmos de hash (como SHA-256). Isso garante a Integridade (o pacote não foi alterado no caminho) e a Autenticação (você é quem diz ser).
