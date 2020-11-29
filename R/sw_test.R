#' Shapiro-Wilk Test
#'
#' Test the normality of a vector using either the original, modified original, or Royston version of the Shapiro-Wilk test
#'
#' @param vec_value vector
#' @param alpha character
#' @param version character
#'
#' @return p_value
#' @export
#'
#' @examples
#' sw_test (rnorm(10, 0, 1))
#'
sw_test <- function (vec_value, alpha = 0.05, version = "modified") {
  #check that input is a vector
  acceptable_types <- c("integer", "double")

  if (!(typeof (vec_value) %in% acceptable_types) )
    stop ('Error: the type of data structure for vec_value is not supported at this time')

  #check that number of data points is within range
  n <- length (vec_value)

  if (n < 2 | n > 50)
    stop ('Error: the number of data points is not supported at this time')

  dat_value <- data.frame (original = vec_value, sorted = sort (vec_value))

  #dat_coef holds values used to calculate W
  if (version == "modified") {
    dat_coef <- as.data.frame(stats::na.omit (modified_sw_coefs[,as.character(n)]))

    #column 'diff' holds the values of the original data in sorted order
    dat_coef$diff <- dat_value$sorted
  } else {
    dat_coef <- as.data.frame(stats::na.omit (sw_coefs[,as.character(n)]))

    #column 'diff' holds the difference between the lowest and highest data values
    #(e.g. between 1st and last, 2nd and second-to-last, etc.) for the original test
    dat_coef$diff <- rep (0, nrow (dat_coef))
    for (i in 1:(nrow (dat_coef))) {
      dat_coef$diff[i] <- dat_value$sorted[(n-i+1)]-dat_value$sorted[i]
    }
  }

  names (dat_coef) <- c('a', 'diff')
  dat_coef$a_diff <- dat_coef[,1] * dat_coef[,2]

  b <- sum (dat_coef[,3])
  SS <- sum((dat_value$sorted-mean(dat_value$sorted))^2)
  W <- (b^2)/SS

  p_val <- get_pvalue (W)

  toreturn <- list (statistic = c(W = round (W, 5)),
                    p.value = round (p_val, 5),
                    method = "Shapiro-Wilk Test of Normality",
                    data.name = deparse(substitute(vec_value)))

  class (toreturn) <- "htest"

  return (toreturn)

}
