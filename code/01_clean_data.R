# 01_clean_data.R
# Loads and preprocesses the raw wastewater dataset

library(tidyverse)
library(lubridate)
library(here)

# Load the data
raw_data <- read_csv(here("data/NWSS_subset.csv"))

# Convert date columns
raw_data <- raw_data %>%
  mutate(
    date_start = as.Date(date_start),
    date_end = as.Date(date_end),
    week = floor_date(date_start, unit = "week")
  ) %>%
  filter(!is.na(ptc_15d), !is.na(week)) # Remove incomplete entries

# Save cleaned data
saveRDS(raw_data, here("output/clean_data.rds"))
