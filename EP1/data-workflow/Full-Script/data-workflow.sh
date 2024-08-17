#!/bin/bash
# Making request for the current weather in Gent

DIRECTORY="/home/linuxmint/Documents/Data/Weather/"
TIME=$(date +"%Y-%m-%d-%H-%M-%S")


curl --request GET \
	--url 'https://weatherapi-com.p.rapidapi.com/current.json?q=Gent' \
	--header 'X-RapidAPI-Host: weatherapi-com.p.rapidapi.com' \
	--header 'X-RapidAPI-Key: 591e17f733msh595afbbfe142928p1c8b1cjsna6b834ee0290' >> "${DIRECTORY}/weather-info_${TIME}.txt"

echo "success current"

#format weathers to csv

# dir. txt files
directory="/home/linuxmint/Documents/Data/Weather"

# dir. to CSV file combined data
csv_file="/home/linuxmint/Documents/Data/Combined/combined_data.csv"

# Create CSV file, add header
echo "Date,Location,Temperature(Celcius)" > "$csv_file"

# Loop txt files in dir.
for file in "$directory"/*.txt; do

    # Extract date from filename
    filename=$(basename "$file")
    date=$(echo "$filename" | cut -d'_' -f2 | cut -d'.' -f1)

    # Read content
    mapfile -t weather_data < "$file"

    # Extracting values
    for data in "${weather_data[@]}"; do
        # Extract location:name
        location_name=$(echo "$data" | grep -o '"name":"[^"]*' | cut -d'"' -f4)
        
        # Extract current:temp_c
        temp_c=$(echo "$data" | grep -o '"temp_c":[0-9.]*' | cut -d':' -f2)
        
        echo "Date: $date"
        echo "Location Name: $location_name"
        echo "Temperature (C): $temp_c"
        echo "---------------------------"
        echo "$date,$location_name,$temp_c" >> "$csv_file"
    done
done

echo "Combined weatherdata saved to $csv_file"

# Making request for the 7 day weather in gent

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

echo "succes 7 days"

#format 7 day weather to CSV
# Directory containing the txt files
directory="/home/linuxmint/Documents/Data/Weather_7_Days"

# CSV file to store combined data
csv_file="/home/linuxmint/Documents/Data/Combined/combined_data_7_days.csv"

# Create the CSV file and add header
echo "Date,Location,Temperature(Celcius)" > "$csv_file"

# Loop through each txt file in the directory
for file in "$directory"/*.txt; do

    # Extract date from filename
    filename=$(basename "$file")
    date=$(echo "$filename" | cut -d'_' -f3 | cut -d'.' -f1)

    # Read the contents of each file into an array
    mapfile -t weather_data < "$file"

    # Extracting values for location:name and current:temp_c
    for data in "${weather_data[@]}"; do
        # Extract location:name
        location_name=$(echo "$data" | grep -o '"name":"[^"]*' | cut -d'"' -f4)
        
        # Extract current:temp_c
        temp_c=$(echo "$data" | grep -o '"temp_c":[0-9.]*' | cut -d':' -f2)
        
        echo "Date: $date"
        echo "Location Name: $location_name"
        echo "Temperature (C): $temp_c"
        echo "---------------------------"
        echo "$date,$location_name,$temp_c" >> "$csv_file"
    done
done

echo "Combined data saved to $csv_file"



#analyse formatted csv data 

function analyse_current{

python3 - <<END

import pandas as pd
import matplotlib.pyplot as plt
import csv

# Path to the CSV file
file_path = '/home/linuxmint/Documents/Data/Combined/combined_data.csv'

# Read CSV file into a DataFrame
data = pd.read_csv(file_path)

# Convert 'Date' column to datetime format
data['Date'] = pd.to_datetime(data['Date'])

# Create a line plot of Temperature(Celcius) against Date
plt.figure(figsize=(10, 6))
plt.plot(data['Date'], data['Temperature(Celcius)'], marker='o', linestyle='-')

# Set plot labels and title
plt.xlabel('Date')
plt.ylabel('Temperature(Celcius)')
plt.title('Temperature Variation Over Time')

# Rotate x-axis labels for better readability (optional)
plt.xticks(rotation=45)

# Save the plot as a JPG or PNG file
plt.tight_layout()
plt.savefig('/home/linuxmint/Documents/Data/Combined/temperature_plot.jpg')  # Change the file extension for PNG

# Show the plot (optional)
plt.show()

# Read the CSV file
with open('/home/linuxmint/Documents/Data/Combined/combined_data6.csv', newline='') as csvfile:
    reader = csv.DictReader(csvfile)
    rows = list(reader)

# Create a Markdown file and write content
with open('/home/linuxmint/Documents/Scripts/temperaturen.md', 'w') as markdown_file:
    for row in rows:
        markdown_file.write(f" {row['Date']}, ")
        markdown_file.write(f"{row['Location']}: ")
        markdown_file.write(f" Temperature: {row['Temperature(Celcius)']}\n\n")
END

}

echo "success analyse"

function analyse_7_days{

python3 - <<END

import pandas as pd
import matplotlib.pyplot as plt
import csv

# Path to the CSV file
file_path = '/home/linuxmint/Documents/Data/Combined/combined_data_7_days.csv'

# Read CSV file into a DataFrame
data = pd.read_csv(file_path)

# Convert 'Date' column to datetime format
data['Date'] = pd.to_datetime(data['Date'])

# Create a line plot of Temperature(Celcius) against Date
plt.figure(figsize=(10, 6))
plt.plot(data['Date'], data['Temperature(Celcius)'], marker='o', linestyle='-')

# Set plot labels and title
plt.xlabel('Date')
plt.ylabel('Temperature(Celcius)')
plt.title('Temperature Variation Over Time')

# Rotate x-axis labels for better readability (optional)
plt.xticks(rotation=45)

# Save the plot as a JPG or PNG file
plt.tight_layout()
plt.savefig('/home/linuxmint/Documents/Data/Combined/temperature_plot_7_days.jpg')  # Change the file extension for PNG

# Show the plot (optional)
plt.show()

import csv

# Read the CSV file
with open('/home/linuxmint/Documents/Data/Combined/combined_data_7days.csv', newline='') as csvfile:
    reader = csv.DictReader(csvfile)
    rows = list(reader)

# Create a Markdown file and write content
with open('/home/linuxmint/Documents/Scripts/temperaturen_7dagen.md', 'w') as markdown_file:
    for row in rows:
        markdown_file.write(f" {row['Date']}, ")
        markdown_file.write(f"{row['Location']}: ")
        markdown_file.write(f" Temperature: {row['Temperature(Celcius)']}\n\n")
END
}


#analyse formatted csv data current

#python3 /home/linuxmint/Documents/Scripts/analyse_data_current.py
#python3 /home/linuxmint/Documents/Scripts/tempanalyse.py

#analyse formatted csv data 7 days

#python3 /home/linuxmint/Documents/Scripts/analyse_7day_data.py
#python3 /home/linuxmint/Documents/Scripts/tempanalyse7days.py

cat analyserapport.md
