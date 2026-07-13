# Shared helper functions for project scripts.

check_required_columns <- function(data, required_cols) {
  missing_cols <- setdiff(required_cols, names(data))

  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "))
  }

  invisible(TRUE)
}
