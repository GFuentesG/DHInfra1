#!/bin/bash

lista="https://raw.githubusercontent.com/olea/lemarios/master/nombres-propios-es.txt"
genderize="https://api.genderize.io/?name="
nationalize="https://api.nationalize.io/?name="

nombres_con_a=$(curl -s $lista | grep '^A' | shuf -n 5)
nombres_con_l=$(curl -s $lista | grep '^L' | shuf -n 5)
nombres_sin_al=$(curl -s $lista | grep -v '^[A|L]' | shuf -n 5)

nombres_totales="$nombres_con_a"$'\n'"$nombres_con_l"$'\n'"$nombres_sin_al"

#echo "$nombres_con_a"
#echo "$nombres_con_l"
#echo "$nombres_sin_al"
#echo "$nombres_totales"

#sin comillas dobles lo muestra en forma horizontal

for nombre in $nombres_totales; do
	url_con_nombre="$genderize$nombre" 
	resultado=$(curl -s "$url_con_nombre" | jq '.gender')
	url_con_nacionalidad="$nationalize$nombre"
	resultado2=$(curl -s "$url_con_nacionalidad" | jq '.country[0].country_id')
	echo "$nombre" 
	echo "Gender of $nombre is: $resultado"
	echo "Country of $nombre is: $resultado2"
	echo "-----------------------------------"
done
