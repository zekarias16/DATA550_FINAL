# 07_compare_population_groups.R

# Load libraries
library(dplyr)
library(ggplot2)
library(readr)

# Read the data
data <- read_csv("data/NWSS_subset.csv")

# Create population groups
data <- data %>%
  mutate(pop_group = case_when(
    population_served < 10000 ~ "Small (<10k)",
    population_served < 100000 ~ "Medium (10k–100k)",
    TRUE ~ "Large (100k+)"
  ))

# Filter out missing and extreme percentile values (e.g., 999)
filtered_data <- data %>%
  filter(!is.na(percentile), percentile < 999)

# Create and save the stratified comparison boxplot
ggplot(filtered_data, aes(x = pop_group, y = percentile, fill = pop_group)) +
  geom_boxplot() +
  labs(
    title = "Comparison of Viral Load Percentile by Population Group",
    x = "Population Group",
    y = "Viral Load Percentile (0–100)"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

# Save the plot
ggsave("output/population_group_comparison.png", width = 8, height = 6, dpi = 300)
