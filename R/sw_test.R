#' Shapiro-Wilk Test
#'
#' Test the normality of a vector using either the original or modified (Royston) version of the Shapiro-Wilk test
#'
#' @param vec_value vector
#' @param alpha character
#'
#' @return p_value
#' @export
#'
#' @examples
#' sw_test (rnorm(10, 0, 1))
#'
sw_test <- function (vec_value, alpha = 0.05) {

  #check that input is a vector
  acceptable_types <- c("integer", "double")

  if (!(typeof (vec_value) %in% acceptable_types) )
    stop ('Error: the type of data structure for vec_value is not supported at this time')

  #check that number of data points is > 1 and <= 50 (the original Shapiro-Wilk test is limited to those values)
  n <- length (vec_value)

  if (n < 2 | n > 50) stop ('Error: the number of data points is not supported at this time')

  #dat_value holds the values of the data
  #column 'original' holds original data as given
  #column 'sorted' holds data sorted in increasing value
  dat_value <- data.frame (original = vec_value,
                           sorted = sort (vec_value))

  #dat_coef holds values used to calculate W
  #column 'a' holds the coefficients a_i for the calculation of the W statistic
  #the values of the coefficients come from an internal table
  dat_coef <- as.data.frame(stats::na.omit (sw_coefs[,as.character(n)]))
  names (dat_coef) <- 'a'

  #column 'diff' holds the difference between the lowest and highest data values (e.g. between 1st and last, 2nd and second-to-last, etc.)
  dat_coef$diff <- rep (0, nrow (dat_coef))

  for (i in 1:(n/2)) {
    dat_coef$diff[i] <- dat_value$sorted[(n-i+1)]-dat_value$sorted[i]
  }

  #column 'a_diff' holds the product of the a_i coefficient and the ith difference
  dat_coef$a_diff <- dat_coef[,1] * dat_coef[,2]

  #b is an intermediate value used to calculate W
  b <- sum (dat_coef[,3])

  #SS is an intermediate value used to calculate W
  SS <- sum((dat_value$sorted-mean(dat_value$sorted))^2)

  #W is the test statistic
  W <- (b^2)/SS

  #the p-values come from an internal table
  possible_pvals <- unlist(sw_pvals[n,])

  if (W < possible_pvals[1]) {
    p_val <- possible_pvals[1]
  } else if (W > possible_pvals[9]) {
    p_val <- possible_pvals[9]
  } else {
    x_values <- find_surrounding_pair(W, possible_pvals)$values
    y_values <- as.numeric(names(possible_pvals)[find_surrounding_pair(W, possible_pvals)$positions])

    p_val <- Hmisc::approxExtrap(x = x_values, y = y_values, xout = W)$y
  }

  reject_decision <- ifelse (p_val <= alpha, "Reject the null", "Fail to reject the null")

  print ("Shapiro-Wilk Test of Normality")
  print (paste0("W = ", round (W, 5), ", p = ", round (p_val, 5)))
  print (paste0 ("Decision: ", reject_decision))

  return (W)

}
