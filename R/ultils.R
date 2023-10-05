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

#' @title Retrieve Aesthetic Variable Label
#' @author Gareth Burns
#' @description
#'   Retrieves the variable label of the plot a data.frame for a given
#'   set of aesthetic.
#' @param plot A data.frame
#' @param aesthetics A character vector. Identities of the of the mappings which
#'   variables label to be retrieved.
#' @return A named character vector. Name is aesthetic, value is class.
#' @noRd

retrieve_aesthetic_variable <- function(plot, aesthetics, ...) {
  sapply(aesthetics, function(variable) {
    as_label(plot$mapping[[variable]])
  })
}


#' @title Retrieve Mapping Aesthetic Class
#' @author Gareth Burns
#' @description
#'   Retrieves the variable class of the plot a data.frame for a given aesthetic.
#' @param plot A data.frame
#' @param aesthetics A character vector. Identities of the of the mappings which
#'   variables class to be retrieved.
#' @return A named character vector. Name is aesthetic, value is class.
#' @noRd

retrieve_aesthetic_class <- function(plot, aesthetics, ...) {
  stopifnot(is(plot, "ggplot"),
            is.character(aesthetics))

  if (all(!aesthetics %in% names(plot$mapping))) {
    stop(
      sprintf(
        "None of the supplied aesthetics variables %1$s are used within the supplied plot"
      ),
      paste(aesthetics, collapse = ",")
    )
  }

  sapply(aesthetics, function(variable) {
    variable <- retrieve_aesthetic_variable(plot, variable)

    # if as.*() used set it to that function, else use the type of colour variable
    if (isTRUE(grepl("as.*)$", variable))) {
      # find the conversion function applied
      func <- sub("^as.(\\w+)\\(.*$", "\\1", variable)
      # clean the name
      func <- clean_label(func)
      # use the function as the class
      class <- func
    } else {
      fill_class <- class(plot$data[[variable]])
    }

  }, simplify = TRUE, USE.NAMES = TRUE)

}
