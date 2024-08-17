#!/bin/bash
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

echo "Combined data saved to $csv_file"
