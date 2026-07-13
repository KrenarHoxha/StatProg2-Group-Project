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

One row in the cleaned dataset represents one country, survey year, and subsample observation. In the current cleaned data, the combination of `country`, `year`, and `subsample` uniquely identifies rows; `region` and `income_level` describe the country context for that observation.

The `subsample` variable distinguishes the population group used for each indicator. The observed categories are `All`, `Female`, `High Education`, `Low Education`, `Old`, `Rural`, `Urban`, and `Young`. This variable is central to the first research question because it allows comparisons between urban and rural populations as well as other population groups.

We restrict the analysis to surveys from 1990 onward to focus on more recent labour market patterns, improve comparability, and reduce sparse coverage in earlier years.

## Group Members
|       Name         | GitHub username |
|--------------------|-----------------|
|Krenar Hoxha        |KrenarHoxha      |
|Daniel Kling        |idxny            |
## Repository Structure

```
code/
  01_download.R  download the raw World Bank Excel file
  02_clean.R     clean raw data and create jobs_clean.csv
  03_eda.R       create exploratory summaries and figures
  04_analysis.R  create main analysis outputs
  utils.R        Shared helper functions for project scripts.

data/
  raw/            raw Excel dataset and licence file
  processed/      cleaned data, EDA summaries, and analysis CSV outputs

figures/          project-level EDA figures used in reports
docs/             rendered Quarto website output
renv/             project-local R environment files

_quarto.yml       Quarto website configuration
index.qmd         website home page
proposal.qmd      project proposal
report.qmd        final analysis report
renv.lock         recorded R package environment
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
