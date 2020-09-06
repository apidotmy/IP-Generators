#!/bin/bash
color(){
merah='\e[91m'
cyan='\e[96m'
kuning='\e[93m'
oren='\033[0;33m' 
margenta='\e[95m'
biru='\e[94m'
ijo="\e[92m"
putih="\e[97m"
normal='\033[0m'
bold='\e[1m'
labelmerah='\e[41m'
labelijo='\e[42m'
labelkuning='\e[43m'    
}
cat << "EOF"
                      .".
                     /  |
                    /  /
                   / ,"
       .-------.--- /
      "._ __.-/ o. o\
         "   (    Y  )
              )     /
             /     (
            /       Y
        .-"         |
       /  _     \    \
      /    `. ". ) /' )
     Y       )( / /(,/
    ,|      /     )
   ( |     /     /
    " \_  (__   (__        [NakoCoders - IP Grabbing + Checker LIVE]
        "-._,)--._,)
EOF
echo ""
read -p "Mau Berapa IP ? : " limit
looping=1
while [ $looping -le $limit ]
do
	echo $((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256)).$((RANDOM%256))>>ips.txt
	((looping++))
done
port80(){
	color
	# port=('80')
	# randport=${port[$RANDOM % ${#port[@]}]}
	checkip=$(curl -skL --connect-timeout 15 --max-time 15 "http://agendaxls.eu/css/openport.php?host=${1}&port=80" \
	-H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101 Firefox/80.0' \
	-H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' \
	-H 'Accept-Language: id,en-US;q=0.7,en;q=0.3' \
	-H 'Connection: keep-alive' \
	-H 'Upgrade-Insecure-Requests: 1' )
	if [[ $checkip =~ "http OPEN" ]]; then
		printf "${labelijo}-- LIVE --${normal} ${bold} ${1}:80\n"
		echo "$1">> result.txt
	elif [[ $checkip =~ "BAD" ]]; then
		printf "${labelmerah}-- DEAD --${normal} ${bold} ${1}\n"
	else
		printf "${labelmerah}-- BAD --${normal} ${bold} ${1}\n"
	fi
}
port443(){
	port80 $1
	checkip=$(curl -skL --connect-timeout 15 --max-time 15 "http://agendaxls.eu/css/openport.php?host=${1}&port=443" \
	-H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101 Firefox/80.0' \
	-H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' \
	-H 'Accept-Language: id,en-US;q=0.7,en;q=0.3' \
	-H 'Connection: keep-alive' \
	-H 'Upgrade-Insecure-Requests: 1' )
	if [[ $checkip =~ "https OPEN" ]]; then
		printf "${labelijo}-- LIVE --${normal} ${bold} ${1}:80\n"
		echo "$1">> result.txt
	elif [[ $checkip =~ "BAD" ]]; then
		printf "${labelmerah}-- DEAD --${normal} ${bold} ${1}\n"
	else
		printf "${labelmerah}-- BAD --${normal} ${bold} ${1}\n"
	fi
}
IFS=$'\r\n' GLOBIGNORE='*' command eval 'bacot=($(cat ips.txt))'
waktumulai=$(date +%s)
for (( i = 0; i <"${#bacot[@]}"; i++ )); do
	WOW="${bacot[$i]}"
	IFS='' read -r -a array <<< "$WOW"
	ipx=${array[0]}
	((cthread=cthread%50)); ((cthread++==0)) && wait
	port443 ${ipx} &
done
wait
