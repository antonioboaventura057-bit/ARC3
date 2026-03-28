# Atividade de Gerenciamento de Sistemas Linux

[cite_start]**Estudante:** Antônio Augusto Boaventura Mariano [cite: 1]  
[cite_start]**Prontuário:** BV3054195 [cite: 1]  
[cite_start]**Disciplina:** Administração de Redes de Computadores [cite: 1]  
[cite_start]**Professor:** Gaio [cite: 1]  
[cite_start]**Módulo:** 3º Semestre [cite: 1]  

---

## 1. Introdução
[cite_start]Nesta atividade, exploramos o uso do **shell (interpretador de comandos)** do Linux, fundamental para o gerenciamento de redes, serviços e aplicativos[cite: 1]. [cite_start]Abaixo, apresentamos a execução de comandos básicos e intermediários realizados em um terminal Bash[cite: 1].

---

## 2. Comandos de Navegação e Diretórios

### Comandos `cd` (Change Directory)
* [cite_start]**cd**: Altera o diretório atual[cite: 1].
* [cite_start]**cd ..**: Move um nível acima na estrutura de diretórios[cite: 1].
* [cite_start]**cd -**: Retorna ao diretório anterior[cite: 1].

ubuntu@ubuntu: $ pwd
/home/ubuntu
ubuntu@ubuntu: $ ls
Desktop Documents Downloads Pictures Public snap Templates Videos
ubuntu@ubuntu: $ cd Downloads/

---

## 3. Gerenciamento de Arquivos e Privilégios

### `sudo` e `mkdir`
* [cite_start]**sudo**: Executa comandos com privilégios de superusuário (root)[cite: 1].
* [cite_start]**mkdir**: Cria uma nova pasta[cite: 1].

vboxuser@ubunto2026:~/Documents$ sudo mkdir marcelo
[sudo] password for vboxuser: 
vboxuser@ubunto2026:~/Documents$ ls
marcelo

> [cite_start]**Observação sobre o comando `su`**: Utilizado para alterar o usuário atual para root, porém não foi possível executá-lo no ambiente Virtual Box User – Ubuntu[cite: 1].

---

## 4. Administração do Sistema

### `systemctl`
[cite_start]Gerencia os serviços do sistema, permitindo iniciar, parar ou verificar o status de unidades[cite: 1].

[cite_start]*(Descrição: Saída do comando systemctl listando diversos dispositivos e automounts)* [cite: 1]

vboxuser@ubunto2026:~/Documents$ systemctl
UNIT
  proc-sys-fs-binfmt_misc.automount
  sys-devices-pci0000:00-0000:00:01.1-ata1-host0-target0:0:0-0:0:0:0-block-sr0.device
  sys-devices-pci0000:00-0000:00:03.0-net-enp0s3.device
  sys-devices-pci0000:00-0000:00:05.0-sound-card0-controlC0.device
  sys-devices-platform-serial8250-serial8250:0-serial8250:0.0-tty-ttyS0.device
  sys-devices-platform-serial8250-serial8250:0-serial8250:0.1-tty-ttyS1.device
  ...

---

## 5. Gerenciamento de Pacotes (`apt`)

* [cite_start]**apt update**: Atualiza a lista de pacotes disponíveis nos repositórios[cite: 1].
* [cite_start]**apt install [pacote]**: Instala novos softwares[cite: 1].

[cite_start]*(Descrição: O terminal exibe a instalação do git e suas dependências)* [cite: 1]

vboxuser@ubunto2026:~/Documents$ sudo apt upgrade
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
Calculating upgrade... Done
The following packages will be upgraded:
  alsa-ucm-conf cloud-init coreutils gdb gdm3 gir1.2-gdm-1.0 gir1.2-gtk-4.0 ...
40 upgraded, 0 newly installed, 0 to remove and 1 not upgraded.
Need to get 23.0 MB of archives.
After this operation, 2,021 kB disk space will be freed.
Do you want to continue? [Y/n] y

vboxuser@ubunto2026:~/Documents$ sudo apt install git
[sudo] password for vboxuser: 
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following NEW packages will be installed:
  git git-man liberror-perl
0 upgraded, 3 newly installed, 0 to remove and 1 not upgraded.
Need to get 4,806 kB of archives.
After this operation, 24.5 MB of additional disk space will be used.

---

## 6. Configuração de Rede e DNS

### `ip address` (ou `ip a`)
[cite_start]Exibe as interfaces de rede e seus respectivos endereços IP[cite: 1].

[cite_start]*(Descrição: Mostra as interfaces 'lo' e 'enp0s3' com o IP 10.0.2.15)* [cite: 1]

vboxuser@ubunto2026:~/Documents$ ip address
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:8f:5e:d7 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic noprefixroute enp0s3

### `nslookup`
[cite_start]Ferramenta utilizada para verificar informações de DNS[cite: 1].

[cite_start]*(Descrição: Tentativa de consulta ao domínio marcelo6427.github.io/Projeto-SoftJr)* [cite: 1]

vboxuser@ubunto2026:~/Documents$ nslookup
> marcelo6427.github.io/Projeto-SoftJr
Server:		127.0.0.53
Address:	127.0.0.53#53

** server can't find marcelo6427.github.io/Projeto-SoftJr: NXDOMAIN

---

## 7. Gerenciamento de Usuários

### `adduser` e `passwd`
* [cite_start]**adduser**: Cria um novo usuário no sistema[cite: 1].
* [cite_start]**passwd**: Altera a senha de um usuário[cite: 1].

[cite_start]*(Descrição: O sistema solicita nova senha e informações adicionais para o novo perfil)* [cite: 1]

vboxuser@ubunto2026:~/Documents$ sudo adduser marcelo
info: Adding user `marcelo' ...
info: Selecting UID/GID from range 1000 to 59999 ...
info: Adding new group `marcelo' (1001) ...
info: Adding new user `marcelo' (1001) with group `marcelo (1001)' ...
info: Creating home directory `/home/marcelo' ...
New password: 
BAD PASSWORD: The password is shorter than 8 characters
Retype new password: 
passwd: password updated successfully
Is the information correct? [Y/n] y
info: Adding user `marcelo' to group `users' ...

vboxuser@ubuntu2026:~/Documents$ sudo passwd marcelo
New password: 
BAD PASSWORD: The password is shorter than 8 characters
Retype new password: 
passwd: password updated successfully
