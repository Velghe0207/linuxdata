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
