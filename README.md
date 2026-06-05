# Project Title
<!--  TODO Titel    -->

> Replace this with a short description of your project and dataset.

## Research Questions
<!--  TODO Forschungsfragen einbauen    -->
1. <!-- Your first research question -->
2. <!-- Your second research question -->

## Dataset

- **Source:** https://datacatalog.worldbank.org/search/dataset/0037526/global-jobs-indicators-database
- **Licence:** Creative Commons Attribution 4.0
- **Description:** The Global Jobs Indicators Database, JOIN, presents more than 100 labor market indicators for 168 countries and 1,802 surveys. The indicators cover socio-demographics, labor force status, employment type, employment composition by sector and occupation, education level completed, hours worked, earnings, and also provide information on survey quality. The indicators are nationally representative and available for different types of workers. This includes workers in urban or rural areas, men and women, younger (age 15-24) and older (age 25-64) workers, or workers with lower and higher education.

<!--    Habe hier einfach die beschreibung von der website kopiert, TODO prüfen ob ok    -->

## Group Members
<!--  TODO Prüfen ob namen korrekt und github namen ergänzen  -->
|       Name         | GitHub username |
|--------------------|-----------------|
|Krenar Hoxha        |KrenarHoxha      |
|Thomas Killinger    |                 |
|Victoria Jodl       |vmj1611                 |
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
