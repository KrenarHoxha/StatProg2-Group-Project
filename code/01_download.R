# 01_download.R
# Downloads raw data from the source URL and saves to data/raw/.

library(here)

force_download <- FALSE

url <- "https://datacatalogfiles.worldbank.org/ddh-published/0037526/10/DR0045333/join_database_w_definitions.xlsx"
dest_dir <- here("data", "raw")
dest_file <- here(dest_dir, "join_database_w_definitions.xlsx")

dir.create(dest_dir, recursive = TRUE, showWarnings = FALSE)

if (!file.exists(dest_file) || force_download) {
  download.file(url, destfile = dest_file, mode = "wb")
  message("Downloaded raw data to: ", dest_file)
} else {
  message("Raw data already exists at: ", dest_file)
}

stopifnot(file.exists(dest_file))
stopifnot(file.info(dest_file)$size > 0)

message("Raw data ready: ", dest_file)
