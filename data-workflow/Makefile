# Directories
RAW_DIR = ../Data/raw/csv
ANALYSED_DIR = ../Data/analysed_data

# Data file and script
RAW_DATA = $(RAW_DIR)/combined.csv
ANALYSIS_SCRIPT = analyse_weather.py

# Output files
PLOTS = $(ANALYSED_DIR)/real_time_temperature_evolution.png \
        $(ANALYSED_DIR)/real_time_weather_metrics_comparison.png \
        $(ANALYSED_DIR)/dewpoint_feelslike_temperature.png \
        $(ANALYSED_DIR)/wind_gusts.png

# Default target
all: $(PLOTS)

# Rule to generate the plots from the raw data
$(PLOTS): $(RAW_DATA)
	python3 $(ANALYSIS_SCRIPT)

# Clean up analysed data
clean:
	rm -f $(PLOTS)

.PHONY: all clean
