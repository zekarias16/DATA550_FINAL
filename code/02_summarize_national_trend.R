# 02_summarize_national_trend.R
# Summarizes national-level trends (Oceanus)

library(tidyverse)
library(here)
library(lubridate)

# Load cleaned data
clean_data <- readRDS(here("output/clean_data.rds"))

# Summarize: mean viral concentration by week across all sites
national_summary <- clean_data %>%
  group_by(week) %>%
  summarise(
    avg_ptc_15d = mean(ptc_15d, na.rm = TRUE),
    avg_detect_prop = mean(detect_prop_15d, na.rm = TRUE),
    .groups = "drop"
  )

# Save summary
saveRDS(national_summary, here("output/national_summary.rds"))

# Plot national trend
plot <- ggplot(national_summary, aes(x = week, y = avg_ptc_15d)) +
  geom_line(color = "steelblue", size = 1) +
  labs(title = "National-Level SARS-CoV-2 Concentration Over Time",
       x = "Week", y = "Average PTC (15-day rolling)") +
  theme_minimal()

ggsave(filename = here("output/national_trend_plot.png"), plot = plot, width = 8, height = 4)
