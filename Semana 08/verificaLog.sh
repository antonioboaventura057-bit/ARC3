  GNU nano 6.2                                                        verificaDNS.sh                                                                 
#!/bin/bash
clear
TAMANHO=$(du -s /var/log | cut -f1)

if [ $TAMANHO -gt 100000 ]
then
        echo "Alerta: o diretório de logs está cheio"
fi

