# 03_eda.R
# Exploratory data analysis: distributions, missingness, relationships.
# Figures are saved to figures/ for inclusion in reports.

library(tidyverse)
library(here)

jobs <- read_csv(here("data", "processed", "jobs_clean.csv"), show_col_types = FALSE)

jobs <- jobs |>
  mutate(
    income_level = factor(
      income_level,
      levels = c(
        "Low income",
        "Lower middle income",
        "Upper middle income",
        "High income"
      ),
      ordered = TRUE
    )
  )

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

fig_dir <- here("figures")
dir.create(fig_dir, recursive = TRUE, showWarnings = FALSE)

summary_by_year_income <- jobs |>
  group_by(year, income_level) |>
  summarise(
    n = n(),
    mean_flfp = mean(flfp, na.rm = TRUE),
    .groups = "drop"
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
  here("figures", "eda_flfp_by_income.png"),
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
  here("figures", "eda_flfp_over_time_income.png"),
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
  here("figures", "eda_flfp_vs_unemployment.png"),
  plot = flfp_vs_unemployment,
  width = 8,
  height = 5,
  dpi = 300
)

message("EDA figures written to figures/")
