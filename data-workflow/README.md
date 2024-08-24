# Data-workflow
# Data Workflow

This repository contains scripts and tools for automating the retrieval and analysis of weather data.

## Table of Contents

- [Current Weather](#current-weather)
- [7 Days Weather](#7-days-weather)
- [Crontab](#crontab)
- [Full Script](#full-script)

## Current Weather

This section describes the process of retrieving and analyzing the current weather data. The data is scraped periodically from the "https://www.weatherapi.com/" website using the `scrape_current_weather.sh` script. The scraped data is saved as a JSON file with the format "weather-YYYY-MM-DD_HH-MM-SS.json". The JSON data is then formatted into a CSV file.

## 7 Days Weather

If the data that was periodically scraped is for some reason not useful, you can scrape a whole week of data at once! 
This section describes the process of retrieving and analyzing the weekly weather forecast. Similar to the current weather data, the data is scraped periodically from the "https://www.weatherapi.com/" website. The scraped data is saved as JSON files and then combined into a single CSV file named "combined.csv" using the `formatting.sh` script.

## Crontab

This section explains how to automate the execution of the bash scripts using crontab. By setting up a cron job, the scripts can be scheduled to run at specific intervals, ensuring that the weather data is regularly updated.

## Full Script

The full script combines all the steps mentioned above into a single script. By executing the `Script.sh` script, the entire data workflow, including scraping, formatting, and analysis, can be performed in one go.

Please note that when new data is pushed to the `combined.csv` file, a GitHub action is triggered, which generates charts and graphs based on the updated data. These charts are then published on the GitHub Pages website.
