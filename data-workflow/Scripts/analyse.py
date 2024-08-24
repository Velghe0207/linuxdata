import pandas as pd
import matplotlib.pyplot as plt

# Load the CSV file into a pandas DataFrame
df = pd.read_csv('../Data/csv/combined.csv')

# Convert 'Time' to datetime object for better time-based analysis
df['Time'] = pd.to_datetime(df['Time'])

# Example: Plotting the temperature over time
plt.figure(figsize=(12, 6))
plt.plot(df['Time'], df['Temp (C)'], marker='o', linestyle='-', color='b', label='Temperature (C)')
plt.xlabel('Time')
plt.ylabel('Temperature (°C)')
plt.title('Real-Time Temperature Evolution Throughout the Day')
plt.legend()
plt.grid(True)
plt.savefig('../docs/real_time_temperature_evolution.png')  # Save the plot as a PNG file
# plt.show()

# Additional Analysis: Comparing Temperature, Humidity, and Wind Speed
plt.figure(figsize=(12, 6))
plt.plot(df['Time'], df['Temp (C)'], marker='o', linestyle='-', color='b', label='Temperature (C)')
plt.plot(df['Time'], df['Humidity'], marker='x', linestyle='-', color='g', label='Humidity (%)')
plt.plot(df['Time'], df['Wind (kph)'], marker='s', linestyle='-', color='r', label='Wind Speed (kph)')
plt.xlabel('Time')
plt.ylabel('Value')
plt.title('Real-Time Weather Metrics Throughout the Day')
plt.legend()
plt.grid(True)
plt.savefig('../docs/real_time_weather_metrics_comparison.png')  # Save the plot as a PNG file
# plt.show()

# Further Analysis Ideas:
# 1. Plot the Dewpoint and Feels Like Temperature throughout the day.
plt.figure(figsize=(12, 6))
plt.plot(df['Time'], df['Dewpoint (C)'], marker='o', linestyle='-', color='m', label='Dewpoint (C)')
plt.plot(df['Time'], df['Feels Like (C)'], marker='x', linestyle='-', color='c', label='Feels Like (C)')
plt.xlabel('Time')
plt.ylabel('Temperature (°C)')
plt.title('Dewpoint and Feels Like Temperature Throughout the Day')
plt.legend()
plt.grid(True)
plt.savefig('../docs/dewpoint_feelslike_temperature.png')  # Save the plot as a PNG file
# plt.show()

# 2. Calculate and plot the wind gusts over time.
plt.figure(figsize=(12, 6))
plt.plot(df['Time'], df['Gust (kph)'], marker='o', linestyle='-', color='purple', label='Wind Gust (kph)')
plt.xlabel('Time')
plt.ylabel('Wind Gust (kph)')
plt.title('Wind Gusts Throughout the Day')
plt.legend()
plt.grid(True)
plt.savefig('../docs/wind_gusts.png')  # Save the plot as a PNG file
# plt.show()