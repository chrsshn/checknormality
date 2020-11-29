#' Find the two values within a vector that immediately surround the target value
#'
#' @param target vector
#' @param x value (integer or double)
#'
#' @return a list with positions of the values within the vector and the values
#' @export
#'
#' @examples
#' find_surrounding_pair (5, 1:10)

find_surrounding_pair <- function (target, x) {
  #check that target and x are numeric values
  acceptable_types <- c("integer", "double")

  if (!(typeof (target) %in% acceptable_types) )
    stop ('Error: the type of data structure for target is not supported at this time')

  if (!(typeof (x) %in% acceptable_types) )
    stop ('Error: the type of data structure for x is not supported at this time')


  #note that the interval is closed on the right (i.e. the upper value will be at most equal to the target)
  lower_position <- which.max (x[(x < target)])
  lower_value <- x[lower_position]
  upper_position <- lower_position + 1
  upper_value <- x[upper_position]

  return (list (positions = c(lower_position, upper_position),
                values = c(lower_value, upper_value)))
}
