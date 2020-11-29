#' Calculate the p-value associated with the W statistic
#'
#' Note that this is specific for p-values using the original or modified original Shapiro-Wilk method
#' Because this implementation uses a p-value table, p-values < 0.01 are reported as "0.001", and p-values > 0.99 are reported as "0.999"
#'
#' @param W double
#' @param n integer
#'
#' @return p-value
#' @export
#'
#' @examples
#' get_pvalue (.970, 20)

get_pvalue <- function (W, n) {
  #the p-values come from an internal table
  possible_pvals <- unlist(sw_pvals[(n-2),])

  if (W < possible_pvals[1]) {
    p_val <- 0.001
  } else if (W > possible_pvals[9]) {
    p_val <- .999
  } else {
    x_values <- find_surrounding_pair(W, possible_pvals)$values
    y_values <- as.numeric(names(x_values))
    p_val <- Hmisc::approxExtrap(x = x_values, y = y_values, xout = W)$y

  }
  return (p_val)
}
