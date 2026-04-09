  GNU nano 6.2                                                       internetCheck.sh                                                                
#!/bin/bash
clear

ping -c 3 8.8.8.8 &> /dev/null

if [ $? -eq 0 ]
then
        echo "Conexão com a internet OK"
fi

