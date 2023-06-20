#' @title Wrap text labels across multiple lines on a ggplot2 figure.
#' @description This function returns a ggplot with the text labels split on to new lines based on a given length of characters.
#' @details This function returns a ggplot with the text labels (e.g. title and axis tick labels) split on to new lines based on a given length of characters.
#'  Also, replaces as.type() style function calls like `as.factor()` or `as.numeric(as.character())` in x-axis, y-axis and various legend titles like fill, color, size etc. automatically.
#'  Can also replace underscores with spaces in all text labels.
#' @param plot A ggplot2 figure (S3: gg, ggplot).
#' @param title_wrap The maximum number of characters before a new line in the plot title and subtitle. Defaults to 40.
#' @param axis_title_wrap The maximum number of characters before a new line in the plot axis titles. Defaults to 30.
#' @param axis_wrap The maximum number of characters before a new line in the plot axis tick labels. Defaults to 20.
#' @param other_wrap The maximum number of characters before a new line in the other text labels on the plot like the title of legends for fill, color, size etc. Defaults to 30.
#' @param spaces Whether to replace underscores with spaces in all text labels. Defaults to `TRUE`.
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


text_wrapper <- function(plot,title_wrap=40,axis_title_wrap=30,axis_wrap=20,other_wrap=30,spaces=TRUE){

  ## function to remove "as.factor()" or "as.character(as.numeric())" from labels
  # e.g. "as.factor(cyl)" becomes "cyl"
  clean_label <- function(x){
    x <- sub(".*\\((.*?)\\).*", "\\1", x)
    return(x)
  }

  ## function to replace underscores with spaces
  # e.g. "Name_1" becomes "Name 1"
  add_spaces <- function(x){
    x <- gsub(pattern = "_", replacement = " ",x)
    return(x)
  }


  ## Axis tick text
  # check if x-axis is discrete or continuous
  x_var <- as_label(plot$mapping$x)

  # check if type is specified by using an as.*() function
  if(grepl("as.*)$",x_var)==TRUE){
    # find function applied
    func_x <- sub("^as.(\\w+)\\(.*$", "\\1", x_var)
    # clean the name
    x_var <- clean_label(x_var)
    # use the function as the class
    x_class <- func_x
  } else{
    x_class <- class(unlist(plot$data[x_var]))
  }


  # wrap the text with the axis width specified
  if(x_class %in% c("logical","character","factor","ordered")){
    if(spaces==TRUE){
      plot$data[x_var] <- apply(plot$data, 1, function(row) {
        gsub(pattern = "_", replacement = " ", x = row[x_var])
      })
    }
   plot <- plot + scale_x_discrete(labels = label_wrap(axis_wrap))

  } else{
    plot <- plot + scale_x_continuous(labels = label_wrap(axis_wrap))

  }

  # check if y-axis is discrete or continuous
  y_var <- as_label(plot$mapping$y)

  # check if type is specified by using an as.*() function
  if(grepl("as.*)$",y_var)==TRUE){
    # find function applied
    func_y <- sub("^as.(\\w+)\\(.*$", "\\1", y_var)
    # clean the name
    y_var <- clean_label(y_var)
    # use the function as the class
    y_class <- func_y
  } else{
    y_class <- class(unlist(plot$data[y_var]))
  }


  # wrap the text with the axis width specified
  if(y_class %in% c("logical","character","factor","ordered")){
    if(spaces==TRUE){
      plot$data[y_var] <- apply(plot$data, 1, function(row) {
        gsub(pattern = "_", replacement = " ", x = row[y_var])
      })
    }
    plot <- plot + scale_y_discrete(labels = label_wrap(axis_wrap))

  } else{
    plot <- plot + scale_y_continuous(labels = label_wrap(axis_wrap))

  }

  ## Titles
  # does the plot have a title?
  has_title <- !is.null(plot$labels$title) && plot$labels$title != ""

  # does the plot have a subtitle?
  has_subtitle <- !is.null(plot$labels$subtitle) && plot$labels$subtitle != ""

  # does the plot have an x axis label?
  has_x_lab <- !is.null(plot$labels$x) && plot$labels$x != ""

  # does the plot have an y axis label?
  has_y_lab <- !is.null(plot$labels$y) && plot$labels$y != ""

  # wrap the title and subtitle with the title width specified
  # title
  if(has_title==TRUE){

    title_text <- plot$labels$title

    # add spaces if needed
    title_text <- if(spaces) add_spaces(title_text) else title_text

      plot <- plot + labs(title = str_wrap(
        title_text,
        width = title_wrap))
  }

  # subtitle
  if(has_subtitle==TRUE){

    subtitle_text <- plot$labels$subtitle

    # add spaces if needed
    subtitle_text <- if(spaces) add_spaces(subtitle_text) else subtitle_text

    plot <- plot + labs(subtitle = str_wrap(
      subtitle_text,
      width = title_wrap))
  }

  # can specify 2 values so first is the x axis and second is the y axis
  # otherwise just use the 1 value for both
  if(length(axis_title_wrap)>1){
    x_wrap <- axis_title_wrap[1]
    y_wrap <- axis_title_wrap[2]

  } else{
    x_wrap <- axis_title_wrap
    y_wrap <- axis_title_wrap

  }

  # x-axis label
  if(has_x_lab==TRUE){
    x_text <- plot$labels$x

    # clean if needed
    if(grepl("as.*)$",x_text)==TRUE){
      x_text <- clean_label(x_text)
    }
    # add spaces if needed
    x_text <- if(spaces) add_spaces(x_text) else x_text

    plot <- plot + labs(x = str_wrap(
      x_text,
      width = x_wrap))
  }

  # y-axis label
  if(has_y_lab==TRUE){
    y_text <- plot$labels$y

    # clean if needed
    if(grepl("as.*)$",y_text)==TRUE){
      y_text <- clean_label(y_text)
    }
    # add spaces if needed
    y_text <- if(spaces) add_spaces(y_text) else y_text

    plot <- plot + labs(y = str_wrap(
      y_text,
      width = y_wrap))
  }

  # Any other labels
  # wrap them with the specified other width
  # e.g. color, fill, size etc.
  other_labels <- setdiff(unique(names(plot$labels)),c("title","subtitle","x","y"))


  for(l in seq_along(other_labels)){
    label_text <- unlist(plot$labels[other_labels[l]])

    # clean if needed
    if(grepl("as.*)$",label_text)==TRUE){
      label_text <- clean_label(label_text)
    }
    # add spaces if needed
    label_text <- if(spaces) add_spaces(label_text) else label_text


    plot <- plot + labs(!!as.name(other_labels[l]) := str_wrap(
      label_text,
      width = other_wrap))
  }

  return(plot)
}

