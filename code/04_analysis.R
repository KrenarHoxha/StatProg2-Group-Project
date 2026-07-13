# 04_analysis.R
# Main statistical analysis: modelling and inference.

library(tidyverse)
library(here)
library(broom)

source(here("code", "utils.R"))

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

check_required_columns(jobs, required_cols)

flfp_by_year_income <- jobs |>
  group_by(year, income_level) |>
  summarise(
    n = n(),
    mean_flfp = mean(flfp, na.rm = TRUE),
    median_flfp = median(flfp, na.rm = TRUE),
    sd_flfp = sd(flfp, na.rm = TRUE),
    .groups = "drop"
  )

flfp_by_income_subsample <- jobs |>
  group_by(income_level, subsample) |>
  summarise(
    n = n(),
    mean_flfp = mean(flfp, na.rm = TRUE),
    median_flfp = median(flfp, na.rm = TRUE),
    sd_flfp = sd(flfp, na.rm = TRUE),
    .groups = "drop"
  )

model_data <- jobs |>
  filter(
    if_all(
      c(
        flfp,
        unemployment,
        female_non_agri,
        avg_weekly_hours,
        income_level,
        subsample
      ),
      ~ !is.na(.x)
    )
  )

correlations <- tibble(
  variable = c("unemployment", "female_non_agri", "avg_weekly_hours")
) |>
  mutate(
    correlation_with_flfp = map_dbl(
      variable,
      ~ cor(model_data$flfp, model_data[[.x]], use = "complete.obs", method = "pearson")
    ),
    n_complete = map_int(
      variable,
      ~ sum(complete.cases(model_data[, c("flfp", .x)]))
    )
  )

# This model is exploratory and describes associations only.
# Coefficients should not be interpreted as causal effects.
flfp_model <- lm(
  flfp ~ unemployment + female_non_agri + avg_weekly_hours + income_level + subsample,
  data = model_data
)

model_coefficients <- tidy(flfp_model)
model_glance <- glance(flfp_model)

output_files <- c(
  here("data", "processed", "analysis_flfp_by_year_income.csv"),
  here("data", "processed", "analysis_flfp_by_income_subsample.csv"),
  here("data", "processed", "analysis_model_data.csv"),
  here("data", "processed", "analysis_flfp_correlations.csv"),
  here("data", "processed", "analysis_flfp_model_coefficients.csv"),
  here("data", "processed", "analysis_flfp_model_glance.csv")
)

write_csv(flfp_by_year_income, output_files[[1]])
write_csv(flfp_by_income_subsample, output_files[[2]])
write_csv(model_data, output_files[[3]])
write_csv(correlations, output_files[[4]])
write_csv(model_coefficients, output_files[[5]])
write_csv(model_glance, output_files[[6]])

message("Analysis outputs written:")
walk(output_files, ~ message("- ", .x))
