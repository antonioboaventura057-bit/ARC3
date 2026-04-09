GNU nano 6.2                                                         dns_check.sh                                                                  
#!/bin/bash
clear
if [ -f "/etc/bind/named.conf.local" ] 
then
        echo "Servidor DNS instalado"
else
        echo "Não há instalação DNS"
