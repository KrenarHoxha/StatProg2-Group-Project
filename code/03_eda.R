# 03_eda.R
# Exploratory data analysis: distributions, missingness, relationships.
# Figures are saved to docs/figures/ for inclusion in reports.

library(tidyverse)
library(here)

jobs <- read_csv(here("data", "processed", "jobs_clean.csv"), show_col_types = FALSE)

required_cols <- c(
  "country",
  "region",
  "income_level",
  "subsample",
  "year",
  "flfp",
  "unemployment",
  "female_non_agri",
  "avg_weekly_hours"
)

missing_cols <- setdiff(required_cols, names(jobs))
if (length(missing_cols) > 0) {
  stop("Missing required columns: ", paste(missing_cols, collapse = ", "))
}

glimpse(jobs)
print(summary(jobs$flfp))
print(count(jobs, income_level))
print(count(jobs, subsample))

fig_dir <- here("docs", "figures")
dir.create(fig_dir, recursive = TRUE, showWarnings = FALSE)

summary_by_income <- jobs |>
  group_by(income_level) |>
  summarise(
    n = n(),
    mean_flfp = mean(flfp, na.rm = TRUE),
    median_flfp = median(flfp, na.rm = TRUE),
    sd_flfp = sd(flfp, na.rm = TRUE),
    .groups = "drop"
  )

summary_by_subsample <- jobs |>
  group_by(subsample) |>
  summarise(
    n = n(),
    mean_flfp = mean(flfp, na.rm = TRUE),
    median_flfp = median(flfp, na.rm = TRUE),
    sd_flfp = sd(flfp, na.rm = TRUE),
    .groups = "drop"
  )

summary_by_year_income <- jobs |>
  group_by(year, income_level) |>
  summarise(
    n = n(),
    mean_flfp = mean(flfp, na.rm = TRUE),
    .groups = "drop"
  )

write_csv(
  summary_by_income,
  here("data", "processed", "eda_summary_by_income.csv")
)
write_csv(
  summary_by_subsample,
  here("data", "processed", "eda_summary_by_subsample.csv")
)
write_csv(
  summary_by_year_income,
  here("data", "processed", "eda_summary_by_year_income.csv")
)

flfp_by_income <- ggplot(jobs, aes(x = income_level, y = flfp)) +
  geom_boxplot(fill = "#4E79A7", alpha = 0.8, na.rm = TRUE) +
  labs(
    title = "Female Labor Force Participation by Income Level",
    x = "Income level",
    y = "Female labor force participation rate",
    caption = "Source: World Bank Jobs Database; cleaned project dataset."
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 25, hjust = 1))

ggsave(
  here("docs", "figures", "eda_flfp_by_income.png"),
  plot = flfp_by_income,
  width = 8,
  height = 5,
  dpi = 300
)

flfp_over_time_income <- ggplot(
  summary_by_year_income,
  aes(x = year, y = mean_flfp, color = income_level)
) +
  geom_line(linewidth = 1, na.rm = TRUE) +
  labs(
    title = "Mean Female Labor Force Participation Over Time",
    x = "Survey year",
    y = "Mean female labor force participation rate",
    color = "Income level",
    caption = "Source: World Bank Jobs Database; cleaned project dataset."
  ) +
  theme_minimal()

ggsave(
  here("docs", "figures", "eda_flfp_over_time_income.png"),
  plot = flfp_over_time_income,
  width = 8,
  height = 5,
  dpi = 300
)

flfp_vs_unemployment <- ggplot(
  jobs,
  aes(x = unemployment, y = flfp, color = income_level)
) +
  geom_point(alpha = 0.45, na.rm = TRUE) +
  geom_smooth(method = "lm", se = FALSE, color = "black", na.rm = TRUE) +
  labs(
    title = "Female Labor Force Participation and Unemployment",
    x = "Unemployment rate",
    y = "Female labor force participation rate",
    color = "Income level",
    caption = "Source: World Bank Jobs Database; cleaned project dataset."
  ) +
  theme_minimal()

ggsave(
  here("docs", "figures", "eda_flfp_vs_unemployment.png"),
  plot = flfp_vs_unemployment,
  width = 8,
  height = 5,
  dpi = 300
)

message("EDA outputs written to data/processed/ and docs/figures/")
