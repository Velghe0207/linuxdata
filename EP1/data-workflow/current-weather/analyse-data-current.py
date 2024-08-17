import pandas as pd
import matplotlib.pyplot as plt

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
