library(ggplot2)
library(tidyverse)
library(dplyr)
library(here)

# change the column name
data <- readRDS(here("output/clean_data.rds")) 

# remove the outlier
data_filtered <- data %>%
  filter(ptc_15d > 0, ptc_15d < 1e7)  

# make dot plot
data_filtered %>%
  group_by(state = reporting_jurisdiction) %>%
  mutate(median_ptc15d = median(ptc_15d, na.rm = TRUE)) %>%
  ggplot(aes(x = ptc_15d, y = reorder(state, median_ptc15d))) +
  geom_jitter(height = 0.2, alpha = 0.3, color = "grey50") +
  stat_summary(fun = median, geom = "point", color = "red", size = 2) +
  scale_x_log10() +
  labs(
    title = "Log-scaled ptc_15d Distribution per State",
    x = "ptc_15d (log10 scale)",
    y = "State"
  ) +
  theme_minimal()

# save
ggsave(here("output/regional_dotplot.png"))
