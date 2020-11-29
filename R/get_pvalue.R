#' Calculate the p-value associated with the W statistic
#'
#' @param W double
#'
#' @return p-value
#' @export
#'
#' @examples
#' get_pvalue (.970)

get_pvalue <- function (W) {
  #the p-values come from an internal table
  possible_pvals <- unlist(sw_pvals[n,])

  if (W < possible_pvals[1]) {
    p_val <- possible_pvals[1]
  } else if (W > possible_pvals[9]) {
    p_val <- possible_pvals[9]
  } else {
    x_values <- find_surrounding_pair(W, possible_pvals)$values
    y_values <- names(possible_pvals)[find_surrounding_pair(W, possible_pvals)$positions]
    p_val <- Hmisc::approxExtrap(x = x_values, y = as.numeric(y_values), xout = W)$y
  }
}
