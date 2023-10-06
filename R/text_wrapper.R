#' @title Wrap text labels across multiple lines on a ggplot2 figure.
#' @description This function returns a ggplot with the text labels split on to
#'   new lines based on a given length of characters.
#' @details This function returns a ggplot with the text labels (e.g. title and
#'  axis tick labels) split on to new lines based on a given length of characters.
#'  Also, replaces as.type() style function calls like `as.factor()` or
#'  `as.numeric(as.character())` in x-axis, y-axis and various legend titles
#'  like fill, color, size etc. automatically. Can also replace underscores.
#'  with spaces in all text labels.
#' @param plot A ggplot2 figure (S3: gg, ggplot).
#' @param title_wrap The maximum number of characters before a new line in the
#'   plot title and subtitle. Defaults to 40.
#' @param axis_title_wrap The maximum number of characters before a new line in
#'   the plot axis titles. Defaults to 30.
#' @param axis_wrap The maximum number of characters before a new line in the
#'   plot axis tick labels. Defaults to 20.
#' @param other_wrap The maximum number of characters before a new line in
#'   the other text labels on the plot like the title of legends for fill,
#'   color, size etc. Defaults to 30.
#' @param spaces Whether to replace underscores with spaces in all text labels.
#'   Defaults to `TRUE`.
#' @seealso \code{\link[scales]{label_wrap}}
#' @seealso \code{\link[stringr]{str_wrap}}
#' @import 'ggplot2'
#' @import 'scales'
#' @import 'stringr'
#' @importFrom rlang :=
#' @export
#' @examples
#' library(ggplot2)
#' library(scales)
#' library(stringr)
#'
#' ## generate a plot
#' ## if you want to use a numeric variable as discrete use `as.factor()` when setting `fill`
#' cars_plot <- ggplot(data = mtcars, aes(x = cyl, y = as.numeric(mpg), fill = as.factor(cyl))) +
#' geom_bar(stat="identity") +
#' exploristics_theme()
#'
#'
#' library(magrittr)
#'
#' ## pipe along with the colour scheme
#' cars_plot_final <- cars_plot %>%
#' exploristics_fill(colour_pal="Expl_External") %>%
#' text_wrapper()


text_wrapper <-
  function(plot,
           title_wrap = 40,
           axis_title_wrap = 30,
           axis_wrap = 20,
           other_wrap = 30,
           spaces = TRUE) {
    ## Axis tick text
    # check if x-axis is discrete or continuous
    x_var <- retrieve_aesthetic_variable(plot, "x")

    # does the plot have an x mapping?
    if (!is.null(x_var)) {
      x_class <- retrieve_aesthetic_class(plot, x_var)

      # wrap the text with the axis width specified
      if (x_class %in% c("logical", "character", "factor", "ordered")) {
        if (isTRUE(spaces)) {
          plot$data[x_var] <- apply(plot$data, 1, function(row) {
            gsub(pattern = "_",
                 replacement = " ",
                 x = row[x_var])
          })
        }
        plot <-
          plot + scale_x_discrete(labels = label_wrap(axis_wrap))

      } else {
        plot <- plot + scale_x_continuous(labels = label_wrap(axis_wrap))
      }
    }


    # check if y-axis is discrete or continuous
    y_var <- retrieve_aesthetic_variable(plot, "y")

    # does the plot have an y mapping?
    if (!is.null(y_var)) {
      # check if type is specified by using an as.*() function
      y_class <- retrieve_aesthetic_class(plot, y_var)

      # wrap the text with the axis width specified
      if (y_class %in% c("logical", "character", "factor", "ordered")) {
        if (isTRUE(spaces)) {
          plot$data[y_var] <- apply(plot$data, 1, function(row) {
            gsub(pattern = "_",
                 replacement = " ",
                 x = row[y_var])
          })
        }
        plot <-
          plot + scale_y_discrete(labels = label_wrap(axis_wrap))

      } else {
        plot <- plot + scale_y_continuous(labels = label_wrap(axis_wrap))

      }
    }


    ## Titles
    # does the plot have a title?
    labels <- lapply(plot$labels, function(label) {
      !is.null(plot$labels[[label]]) && plot$labels[[label]] != ""
    })

    labels <- lapply(labels, function(label) {
      text <- retrieve_label_text(plot, label, spaces = spaces)
      wrap_width <- switch(label,
                           "title" = title_wrap,
                           "x" = axis_title_wrap,
                           "y",
                           other_wrap)
      str_wrap(text,
               width = wrap_width)

    })

    plot <-
      plot +
      do.call("labs", args = labels)

    return(plot)
  }
