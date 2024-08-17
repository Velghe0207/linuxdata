# Making request

DIRECTORY="/home/linuxmint/Documents/Data/Weather/"
TIME=$(date +"%Y-%m-%d-%H-%M-%S")


curl --request GET \
	--url 'https://weatherapi-com.p.rapidapi.com/current.json?q=Gent' \
	--header 'X-RapidAPI-Host: weatherapi-com.p.rapidapi.com' \
	--header 'X-RapidAPI-Key: 591e17f733msh595afbbfe142928p1c8b1cjsna6b834ee0290' >> "${DIRECTORY}/weather-info_${TIME}.txt"
