#!/bin/bash

DIRECTORY="../Data/json/current/"
LOCATION="Gent"

# Get current date and time
DATE=$(date +%Y-%m-%d)
TIME=$(date +%H-%M-%S)

FILENAME="weather-${DATE}_${TIME}"

URL="https://weatherapi-com.p.rapidapi.com/history.json?q=$LOCATION&dt=$DATE&lang=en&hour=$TIME"

# Log the start of the script
echo "Script started at $(date)" >> "${DIRECTORY}/log.txt"

# Log the URL being used
echo "Fetching weather data from: $URL" >> "${DIRECTORY}/log.txt"

# Perform the API request and save the response
curl --request GET \
	--url "{$URL}" \
	--header 'X-RapidAPI-Host: weatherapi-com.p.rapidapi.com' \
	--header 'X-RapidAPI-Key: 591e17f733msh595afbbfe142928p1c8b1cjsna6b834ee0290' >> "${DIRECTORY}/${FILENAME}.json"

# Log the completion of the script
echo "Script completed at $(date)" >> "${DIRECTORY}/log.txt"
