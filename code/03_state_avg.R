# average by state
state_avg <- data %>%
  filter(!is.na(ptc_15d), !is.na(reporting_jurisdiction)) %>%
  group_by(State = reporting_jurisdiction) %>%
  summarise(`Mean ptc 15d` = mean(ptc_15d, na.rm = TRUE), .groups = "drop") %>%
  arrange(desc(`Mean ptc 15d`))

# save
write_rds(state_avg, here("output/state_avg.rds"))
