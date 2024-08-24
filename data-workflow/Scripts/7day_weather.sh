#!/bin/bash
# 591e17f733msh595afbbfe142928p1c8b1cjsna6b834ee0290

DIRECTORY="../Data/json/weather/"
LOCATION="Gent"

for ((i=0; i<7; i++)); do
    for ((hour=0; hour<24; hour++)); do
        # Get date and time for i days ago and current hour
        DATE=$(date -d "$i days ago" +%Y-%m-%d)
        TIME=$(printf "%02d" $hour) # Use only hour without minutes and seconds
        FILENAME="weather-$(date -d "$DATE $TIME:00:00" +%Y-%m-%d_%H-%M-%S)"

        URL="https://weatherapi-com.p.rapidapi.com/history.json?q=$LOCATION&dt=$DATE&lang=en&hour=$TIME"

        curl --request GET \
            --url "{$URL}" \
            --header 'X-RapidAPI-Host: weatherapi-com.p.rapidapi.com' \
            --header 'X-RapidAPI-Key: 226af66113df4c94ab0192158241908' >> "${DIRECTORY}/${FILENAME}.json"
    done
done