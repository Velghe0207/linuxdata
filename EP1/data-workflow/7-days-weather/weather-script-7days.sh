#!/bin/bash
# Making request

DIRECTORY="/home/linuxmint/Documents/Data/Weather_7_Days/"
LOCATION="Gent"
BASE_URL="https://weatherapi-com.p.rapidapi.com/history.json?q=$LOCATION&lang=en&hour=12"

for ((i=0; i<7; i++)); do
    # Get date for i days ago
    DATE=$(date -d "$i days ago" +%Y-%m-%d)
    URL="https://weatherapi-com.p.rapidapi.com/history.json?q=$LOCATION&dt=$DATE&lang=en&hour=12"

    curl --request GET \
	    --url "{$URL}" \
	    --header 'X-RapidAPI-Host: weatherapi-com.p.rapidapi.com' \
	    --header 'X-RapidAPI-Key: 591e17f733msh595afbbfe142928p1c8b1cjsna6b834ee0290' >> "${DIRECTORY}/weather-info_7days_${DATE}.txt"
done

