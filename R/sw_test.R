#' Check for valid parameters for a sw_test call
#'
#' This function checks that the parameters for a sw_test call are acceptable. When parameters are not acceptable, errors are thrown. When parameters need minor adjustments, warnings are thrown.
#'
#' @param vec_value numeric vector containing data points, of type integer or double
#' @param approach character, one of "original", "modified", or "royston"
#'
#' @return approach_to_use is the recommended approach and may not be identical to what the user initially chose
#'
#' @examples
#' check_sw_test_inputs (1:60, "royston")
check_sw_test_inputs <- function (vec_value, approach) {
  #check that input is a vector
  valid_vec_type <- c("integer", "double")

  if (!(typeof (vec_value) %in% valid_vec_type) )
    stop ('Error: the data structure for vec_value must be a vector of type integer or double')

  #check that the approach is a valid option
  valid_approach_value = c("original", "modified", "royston")

  if (!(approach %in% valid_approach_value))
    stop ('Error: the test approach is invalid')

  #check that number of data points is valid for the approach of the test
  n <- length (vec_value)
  approach_to_use <- approach

  if (n < 3) {
    stop ('Error: the number of data points is too small')
  } else if (n > 5000) {
    warning ('Warning: the number of data points is very large, and the result of the Shapiro-Wilk test may detect trivial non-normality in the data')
  } else if ((n < 20) & approach == "royston"){
    warning ('Warning: the Royston approach of the test requires at least 20 data points, and the modified approach will be used')
    approach_to_use = "modified"
  } else if ((n > 50) & approach != "royston"){
    warning ('Warning: the original and modified approachs of the Shapiro-Wilk test are only valid for n <= 50 data points, and the Royston approach will be used')
    approach_to_use = "royston"
  }

  return (approach_to_use)
}


#' Implementation of the original and modified approaches for the Shapiro-Wilk test
#'
#' This function calculates the W test statistic and p-value for the original and modified approaches for the Shapiro-Wilk test. The original and modified approaches use the Shapiro-Wilk coefficient table (which can be found in the data-raw folder) to determine the value of the test statistic
#'
#' @param vec_value numeric vector containing data points, of type integer or double
#' @param approach character, one of "original" or "modified"
#'
#' @return w_p a list containing the W test statistic and p-value
#' @export
#'
#' @examples
#' original_sw (1:20, "modified")
original_sw <- function (vec_value, approach = "modified"){
  n <- length (vec_value)

  dat_value <- data.frame (original = vec_value, sorted = sort (vec_value))

  #dat_coef holds values used to calculate W
  if (approach == "modified") {
    dat_coef <- as.data.frame(stats::na.omit (modified_sw_coefs[,as.character(n)]))
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

  p_val <- get_pvalue (W, n)

  return (list (W, p_val))
}

#' Calculate the W statistic for the Royston approach (implemented in R)
#'
#' This function calculates the W test statistic for the Royston approach for the Shapiro-Wilk test. This function is comparable to the Rcpp implementation of the Royston approach (which can be found in the src folder). For a step-by-step explanation of this function, look at the Readme file under "A Note on the Algorithms".
#'
#' @param vec_value numeric vector containing data points, of type integer or double
#'
#' @return W double, the Shapiro-Wilk test statistic ranging from 0 to 1
#' @export
#'
#' @examples
#' R_get_W (1:10)
R_get_W <- function (vec_value) {
  n <- length (vec_value)

  m_vec <- rep (0, n)

  for (i in 1:n) {
    m_vec[i] = stats::qnorm ((i - 0.375) / (n + 0.25))
  }

  m_val <- sum(m_vec * m_vec)

  u <- 1 / sqrt(n)

  dat_coef <- rep (0, n)

  dat_coef[n] = -2.706056*u^5 + 4.434685*u^4 - 2.2071190*u^3 - 0.147981*u^2 + 0.221157*u +
    m_vec[n] * m_val^(-0.5)

  dat_coef[1] = -1 * dat_coef[n]

  dat_coef[n - 1] = -3.582633*u^5 + 5.682633*u^4 - 1.752461*u^3 - 0.293762*u^2 + 0.042981*u +
    m_vec[n - 1] * m_val^(-0.5)

  dat_coef[2] = -1 * dat_coef[n - 1]

  for (i in 2:(n - 1)) {
    epsilon = (m_val - (2*m_vec[n]^2) - (2*m_vec[n - 1]^2)) /
      (1 - (2 * dat_coef[n]^2) - (2 * dat_coef[n - 1]^2))

    dat_coef[i] = m_vec[i]/sqrt (epsilon)
  }

  W = (stats::cor (as.matrix (cbind (sort (vec_value), dat_coef)))[1,2])^2

  return (W)
}


#' Implementation of the Royston approach for the Shapiro-Wilk test
#'
#' This function calculates the W test statistic and p-value for the Royston approach for the Shapiro-Wilk test. The Royston approach uses formulas to determine the value of the test statistic
#'
#' @param vec_value numeric vector containing data points, of type integer or double
#' @param use_c boolean, 0 if the R implementation for calculating W should be used or 1 if the Rcpp implentation should be used
#'
#' @return w_p a list containing the W test statistic and p-value
#' @export
#'
#' @examples
#' royston_sw (1:60)
royston_sw <- function (vec_value, use_c = T) {
  if (use_c)
    W = C_get_W (vec_value)
  else
    W = R_get_W (vec_value)

  n <- length(vec_value)

  mu = 0.0038915 * log(n)^3 - 0.083751 * log(n)^2 - 0.31082*log(n) - 1.5861

  sigma = exp (0.0030302 * log(n)^2 - 0.082676 * log (n) - 0.4803)

  z = (log (1 - W) - mu) / sigma

  p_val <- 1 - stats::pnorm (z)

  return (list (W, p_val))
}



#' Shapiro-Wilk Test
#'
#' This function uses the Shapiro-Wilk to determine whether a set of data points is normally distributed. There are three approaches: original, modified, or Royston. For an explanation of the different uses of the approaches, look at the Readme file under "A Note on the Algorithms". The null hypothesis is that the data is normally distributed, and the alternative hypothesis is that the data is not normally distributed. Note that it is recommended to use the Shapiro-Wilk test for n < 5000 data points because the test is sensitive to detecting non-normality, and a tactic to use for n > 5000 data points is to take a random sample of n = 5000 data points and run the Shapiro-Wilk test on the sample.
#'
#' @param vec_value numeric vector containing data points, of type integer or double
#' @param approach character, one of "original", "modified", or "royston"
#' @param use_c boolean, 0 if the R implementation for calculating W should be used or 1 if the Rcpp implentation should be used
#'
#' @return toreturn, an object of class "htest" containing the results of the Shapiro-Wilk test
#' @export
#'
#' @examples
#' sw_test (rnorm(10, 0, 1))
#'
sw_test <- function (vec_value, approach = "royston", use_c = F) {
  actual_approach = check_sw_test_inputs (vec_value, approach)

  if (actual_approach %in% c("original", "modified"))
    test_statistic = original_sw (vec_value, actual_approach)
  else
    test_statistic = royston_sw (vec_value, use_c)

  toreturn <- list (statistic = c(W = round (test_statistic[[1]], 5)),
                    p.value = round (test_statistic[[2]], 5),
                    method = "Shapiro-Wilk Test of Normality",
                    data.name = deparse(substitute(vec_value)))

  class (toreturn) <- "htest"

  return (toreturn)

}
