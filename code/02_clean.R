# 02_clean.R
# Reads raw data, applies cleaning steps, writes to data/processed/.

library(tidyverse)
library(here)
library(readxl)

raw <- read_excel(
  here("data", "raw", "join_database_w_definitions.xlsx"),
  skip = 3
)

cleaned <- raw |>
  select(
    country = `Country Name`,
    region = `Region Code`,
    income_level = `Income Level Name`,
    subsample = Subsample,
    year = `Year of survey`,
    flfp = `Female Labor Force Participation Rate, aged 15-64`,
    unemployment = `Unemployment Rate, aged 15-64`,
    female_non_agri = `Female in non-agricultural employment, aged 15-64`,
    avg_weekly_hours = `Average weekly working hours`
  ) |>
  filter(!is.na(flfp), !is.na(year), year >= 1990) |>
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

dir.create(here("data", "processed"), showWarnings = FALSE, recursive = TRUE)
write_csv(cleaned, here("data", "processed", "jobs_clean.csv"))
message("Wrote data/processed/jobs_clean.csv")
