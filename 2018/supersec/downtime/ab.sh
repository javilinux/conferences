#!/bin/bash
URL="web-ab.192.168.42.204.nip.io"
V1=0
V2=0
X=${1:-10}
for ((i=1; c<$X ; c++))
do
    RESULT="$(curl -s $URL | grep div | cut -d'>' -f3 | cut -d'<' -f1)"
    if [ "$RESULT" = "v1" ]; then
	   let "V1++" 
    elif [ "$RESULT" = "v2" ]; then
	   let "V2++" 
    fi 
done

echo "Numero de Version 1 = $V1"
echo "Numero de Version 2 = $V2"
