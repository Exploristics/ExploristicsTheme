# Non-exportable functions


#' @title Clean Labels for use in plots
#' @author Amy McCorry
#' @details
#'   Function to remove "as.factor()" or "as.character(as.numeric())" from labels
#'   e.g. "as.factor(cyl)" becomes "cyl"
#' @noRd

clean_label <- function(x) {
  x <- sub(".*\\((.*?)\\).*", "\\1", x)
  return(x)
}

#' @title Replace Underscore
#' @author Amy McCorry
#' @details
#'   Function to replace underscores with spaces to make human readable
#    e.g. "Name_1" becomes "Name 1"
#' @noRd

replace_underscore <- function(x) {
  x <- gsub(pattern = "_", replacement = " ", x)
  return(x)
}
