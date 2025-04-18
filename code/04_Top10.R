# get the average by the county and select top 10
county_avg <- data %>%
  filter(!is.na(ptc_15d), !is.na(county_names), !is.na(reporting_jurisdiction)) %>%
  group_by(county_names, reporting_jurisdiction) %>%
  summarise(mean_ptc_15d = mean(ptc_15d, na.rm = TRUE), .groups = "drop") %>%
  arrange(desc(mean_ptc_15d)) %>%
  slice(1:10) %>%
  select(
    County = county_names,
    State = reporting_jurisdiction,
    `Mean ptc 15d` = mean_ptc_15d
  )

# save
write_rds(county_avg, here("output/top10_counties.rds"))
