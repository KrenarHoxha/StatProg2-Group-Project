# Female Labor Force Participation Across Countries: Trends, Inequality, and Labour Market Context

> This project analyses female labor force participation across countries using the Global Jobs Indicators Database. We examine trends over time by income group and explore associations with unemployment, female non-agricultural employment, and working hours. The analysis is exploratory and aims to communicate global labour market patterns through reproducible R code, Quarto reporting, and clear visualisations.

## Research Questions
1. How does female labor force participation vary across some countries, income groups, urban/rural populations, over time?
2. How is female labor force participation associated with unemployment, female non-agricultural employment,
and average weekly working hours?

## Dataset

- **Source:** https://datacatalog.worldbank.org/search/dataset/0037526/global-jobs-indicators-database
- **Licence:** Creative Commons Attribution 4.0
- **Description:** The Global Jobs Indicators Database, JOIN, presents more than 100 labor market indicators for 168 countries and 1,802 surveys. The indicators cover socio-demographics, labor force status, employment type, employment composition by sector and occupation, education level completed, hours worked, earnings, and also provide information on survey quality. The indicators are nationally representative and available for different types of workers. This includes workers in urban or rural areas, men and women, younger (age 15-24) and older (age 25-64) workers, or workers with lower and higher education.

## Group Members
|       Name         | GitHub username |
|--------------------|-----------------|
|Krenar Hoxha        |KrenarHoxha      |
|Daniel Kling        |idxny            |
## Repository Structure

```
data/raw/        read-only raw data and licence documentation
data/processed/  cleaned data produced by code/02_clean.R
code/            numbered R scripts (01 download → 02 clean → 03 EDA → 04 analysis)
docs/            rendered Quarto website output (auto-generated, do not edit)
proposal.qmd     W07 project proposal
report.qmd       final analysis report
```

## How to reproduce

```r
# 1. Install dependencies
renv::restore()   # if using renv, otherwise install packages manually

# 2. Run the pipeline in order
source("code/01_download.R")
source("code/02_clean.R")
source("code/03_eda.R")
source("code/04_analysis.R")

# 3. Render the website
quarto::quarto_render()
```
