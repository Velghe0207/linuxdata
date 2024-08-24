#!/bin/bash

# Directory containing the JSON files
directory="../Data/json/weather"

# CSV file to store combined data
combined_csv="../Data/csv/combined.csv"

# Create the CSV file and add headers
echo "Date,Location,Country,Latitude,Longitude,Timezone ID,Localtime Epoch,Localtime,Max Temp (C),Max Temp (F),Min Temp (C),Min Temp (F),Avg Temp (C),Avg Temp (F),Max Wind (mph),Max Wind (kph),Total Precip (mm),Total Precip (in),Total Snow (cm),Avg Visibility (km),Avg Visibility (miles),Avg Humidity,Daily Will it Rain,Daily Chance of Rain,Daily Will it Snow,Daily Chance of Snow,Condition Text,Condition Icon,Condition Code,UV,Sunrise,Sunset,Moonrise,Moonset,Moon Phase,Moon Illumination,Time,Temp (C),Temp (F),Is Day,Condition Text Hour,Condition Icon Hour,Condition Code Hour,Wind (mph),Wind (kph),Wind Degree,Wind Direction,Pressure (mb),Pressure (in),Precip (mm),Precip (in),Snow (cm),Humidity,Cloud,Feels Like (C),Feels Like (F),Windchill (C),Windchill (F),Heat Index (C),Heat Index (F),Dewpoint (C),Dewpoint (F),Will it Rain,Chance of Rain,Will it Snow,Chance of Snow,Visibility (km),Visibility (miles),Gust (mph),Gust (kph),UV Hour" > "$combined_csv"

for file in "$directory"/*.json; do

  # Extract date from filename
  filename=$(basename "$file")
  date=$(echo "$filename" | cut -d'-' -f2 | cut -d'_' -f1)
  formatted_date=$(date -d "$date" +"%Y-%m-%d")

  echo "Processing file: $filename"

  # Read the contents of each file into a variable
  json_data=$(cat "$file")

  # Extracting values for location attributes
  location_name=$(echo "$json_data" | jq -r '.location.name')
  # region=$(echo "$json_data" | jq -r '.location.region') --usally empty
  country=$(echo "$json_data" | jq -r '.location.country')
  lat=$(echo "$json_data" | jq -r '.location.lat')
  lon=$(echo "$json_data" | jq -r '.location.lon')
  tz_id=$(echo "$json_data" | jq -r '.location.tz_id')
  localtime_epoch=$(echo "$json_data" | jq -r '.location.localtime_epoch')
  localtime=$(echo "$json_data" | jq -r '.location.localtime')

  # Extracting values for forecastday attributes
  maxtemp_c=$(echo "$json_data" | jq -r '.forecast.forecastday[0].day.maxtemp_c')
  maxtemp_f=$(echo "$json_data" | jq -r '.forecast.forecastday[0].day.maxtemp_f')
  mintemp_c=$(echo "$json_data" | jq -r '.forecast.forecastday[0].day.mintemp_c')
  mintemp_f=$(echo "$json_data" | jq -r '.forecast.forecastday[0].day.mintemp_f')
  avgtemp_c=$(echo "$json_data" | jq -r '.forecast.forecastday[0].day.avgtemp_c')
  avgtemp_f=$(echo "$json_data" | jq -r '.forecast.forecastday[0].day.avgtemp_f')
  maxwind_mph=$(echo "$json_data" | jq -r '.forecast.forecastday[0].day.maxwind_mph')
  maxwind_kph=$(echo "$json_data" | jq -r '.forecast.forecastday[0].day.maxwind_kph')
  totalprecip_mm=$(echo "$json_data" | jq -r '.forecast.forecastday[0].day.totalprecip_mm')
  totalprecip_in=$(echo "$json_data" | jq -r '.forecast.forecastday[0].day.totalprecip_in')
  totalsnow_cm=$(echo "$json_data" | jq -r '.forecast.forecastday[0].day.totalsnow_cm')
  avgvis_km=$(echo "$json_data" | jq -r '.forecast.forecastday[0].day.avgvis_km')
  avgvis_miles=$(echo "$json_data" | jq -r '.forecast.forecastday[0].day.avgvis_miles')
  avghumidity=$(echo "$json_data" | jq -r '.forecast.forecastday[0].day.avghumidity')
  daily_will_it_rain=$(echo "$json_data" | jq -r '.forecast.forecastday[0].day.daily_will_it_rain')
  daily_chance_of_rain=$(echo "$json_data" | jq -r '.forecast.forecastday[0].day.daily_chance_of_rain')
  daily_will_it_snow=$(echo "$json_data" | jq -r '.forecast.forecastday[0].day.daily_will_it_snow')
  daily_chance_of_snow=$(echo "$json_data" | jq -r '.forecast.forecastday[0].day.daily_chance_of_snow')
  condition_text=$(echo "$json_data" | jq -r '.forecast.forecastday[0].day.condition.text')
  condition_icon=$(echo "$json_data" | jq -r '.forecast.forecastday[0].day.condition.icon')
  condition_code=$(echo "$json_data" | jq -r '.forecast.forecastday[0].day.condition.code')
  uv=$(echo "$json_data" | jq -r '.forecast.forecastday[0].day.uv')

  # Extracting values for astro attributes
  sunrise=$(echo "$json_data" | jq -r '.forecast.forecastday[0].astro.sunrise')
  sunset=$(echo "$json_data" | jq -r '.forecast.forecastday[0].astro.sunset')
  moonrise=$(echo "$json_data" | jq -r '.forecast.forecastday[0].astro.moonrise')
  moonset=$(echo "$json_data" | jq -r '.forecast.forecastday[0].astro.moonset')
  moon_phase=$(echo "$json_data" | jq -r '.forecast.forecastday[0].astro.moon_phase')
  moon_illumination=$(echo "$json_data" | jq -r '.forecast.forecastday[0].astro.moon_illumination')

  # Extracting values for hour attributes
  time=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].time')
  temp_c=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].temp_c')
  temp_f=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].temp_f')
  is_day=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].is_day')
  condition_text_hour=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].condition.text')
  condition_icon_hour=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].condition.icon')
  condition_code_hour=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].condition.code')
  wind_mph=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].wind_mph')
  wind_kph=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].wind_kph')
  wind_degree=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].wind_degree')
  wind_dir=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].wind_dir')
  pressure_mb=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].pressure_mb')
  pressure_in=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].pressure_in')
  precip_mm=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].precip_mm')
  precip_in=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].precip_in')
  snow_cm=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].snow_cm')
  humidity=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].humidity')
  cloud=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].cloud')
  feelslike_c=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].feelslike_c')
  feelslike_f=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].feelslike_f')
  windchill_c=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].windchill_c')
  windchill_f=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].windchill_f')
  heatindex_c=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].heatindex_c')
  heatindex_f=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].heatindex_f')
  dewpoint_c=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].dewpoint_c')
  dewpoint_f=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].dewpoint_f')
  will_it_rain=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].will_it_rain')
  chance_of_rain=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].chance_of_rain')
  will_it_snow=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].will_it_snow')
  chance_of_snow=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].chance_of_snow')
  vis_km=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].vis_km')
  vis_miles=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].vis_miles')
  gust_mph=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].gust_mph')
  gust_kph=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].gust_kph')
  uv_hour=$(echo "$json_data" | jq -r '.forecast.forecastday[0].hour[0].uv')

  # Append the extracted data to the combined CSV file
  echo "$formatted_date,$location_name,$country,$lat,$lon,$tz_id,$localtime_epoch,$localtime,$maxtemp_c,$maxtemp_f,$mintemp_c,$mintemp_f,$avgtemp_c,$avgtemp_f,$maxwind_mph,$maxwind_kph,$totalprecip_mm,$totalprecip_in,$totalsnow_cm,$avgvis_km,$avgvis_miles,$avghumidity,$daily_will_it_rain,$daily_chance_of_rain,$daily_will_it_snow,$daily_chance_of_snow,\"$condition_text\",\"$condition_icon\",$condition_code,$uv,\"$sunrise\",\"$sunset\",\"$moonrise\",\"$moonset\",\"$moon_phase\",$moon_illumination,\"$time\",$temp_c,$temp_f,$is_day,\"$condition_text_hour\",\"$condition_icon_hour\",$condition_code_hour,$wind_mph,$wind_kph,$wind_degree,\"$wind_dir\",$pressure_mb,$pressure_in,$precip_mm,$precip_in,$snow_cm,$humidity,$cloud,$feelslike_c,$feelslike_f,$windchill_c,$windchill_f,$heatindex_c,$heatindex_f,$dewpoint_c,$dewpoint_f,$will_it_rain,$chance_of_rain,$will_it_snow,$chance_of_snow,$vis_km,$vis_miles,$gust_mph,$gust_kph,$uv_hour" >> "$combined_csv"

  echo "Data extracted from file: $filename"
done

echo "Combined data saved to $combined_csv"
