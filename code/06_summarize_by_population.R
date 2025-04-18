# 06_summarize_by_population.R

# Load required libraries
library(dplyr)
library(ggplot2)
library(readr)

# Read the cleaned data (make sure the path is correct)
data <- read_csv("data/NWSS_subset.csv")

# Create population size categories
data <- data %>%
  mutate(pop_group = case_when(
    population_served < 10000 ~ "Small (<10k)",
    population_served < 100000 ~ "Medium (10k–100k)",
    TRUE ~ "Large (100k+)"
  ))

# Summarize average viral load percentile by date and population group
summary_df <- data %>%
  filter(!is.na(percentile)) %>%  # exclude missing values
  group_by(date_start, pop_group) %>%
  summarize(
    mean_percentile = mean(percentile, na.rm = TRUE),
    .groups = "drop"
  )

# Plot using updated syntax and variable

ggplot(summary_df, aes(x = date_start, y = mean_percentile, color = pop_group)) +
  geom_line(linewidth = 0.8) +
  labs(
    title = "SARS-CoV-2 Wastewater Viral Load Trends by Population Group",
    x = "Date",
    y = "Average Viral Load Percentile",
    color = "Population Group"
  ) +
  theme_minimal()
# Save the last plot to the output folder
ggsave("output/viral_load_trend_by_population.png", width = 10, height = 6, dpi = 300)

