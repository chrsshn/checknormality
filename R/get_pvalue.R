#' Calculate the p-value associated with the W statistic
#'
#' Note that this is specific for p-values using the original or modified original Shapiro-Wilk method
#'
#' @param W double
#' @param n integer
#'
#' @return p-value
#' @export
#'
#' @examples
#' get_pvalue (.970)

get_pvalue <- function (W, n) {
  #the p-values come from an internal table
  possible_pvals <- unlist(sw_pvals[(n-2),])

  if (W < possible_pvals[1]) {
    p_val <- possible_pvals[1]
  } else if (W > possible_pvals[9]) {
    p_val <- possible_pvals[9]
  } else {
    x_values <- find_surrounding_pair(W, possible_pvals)$values
    y_values <- as.numeric(names(x_values))
    p_val <- Hmisc::approxExtrap(x = x_values, y = as.numeric(y_values), xout = W)$y

  }
  return (p_val)
}
