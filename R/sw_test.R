#' Shapiro-Wilk Test
#'
#' Test the normality of a vector using a version of the Shapiro-Wilk test
#'
#' @param vec_value vector
#' @param version character
#' @param alpha character
#'
#' @return p_value
#' @export
#'
#' @examples
#' sw_test (rnorm(10, 0, 1))
#'
sw_test <- function (vec_value,
                     version = "original",
                     alpha = 0.05) {

  #the original Shapiro-Wilk test is limited to n = 50 values
  #need to check that x is a vector
  n <- length (vec_value)

  #dat_value holds the values of the data
  #column 'original' holds original data as given
  #column 'sorted' holds data sorted in increasing value
  dat_value <- data.frame (original = vec_value,
                           sorted = sort (vec_value))

  #dat_coef holds values used to calculate W
  #column 'a' holds the coefficients a_i for the calculation of the W statistic
  #the values of the coefficients comes from an internal table
  #the number of coefficients varies with n
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

  p_02 <- unlist(sw_pvals[n,2])
  p_05 <- unlist (sw_pvals[n,3])

  p_val <- .05 - ((.03)*(p_05 - W)/(p_05 - p_02))
  reject_decision <- ifelse (p_val <= alpha, "yes", "no")

  # print ("Shapiro-Wilk Test of Normality")
  # print (paste0("W = ", W, ", p = ", p_val))
  # print (paste0 ("Reject? ", reject_decision))
  # return (W)


  return (round (W, 5))

}
