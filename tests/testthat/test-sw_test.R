test_that("sw_test works", {


  test_a_different_value <- function (n, mu = 1, sigmasquared = 1) {
    test_df1 <- rnorm (n, 0, 1)
    expect_equivalent (shapiro.test(test_df1)$statistic,
                       sw_test(test_df1),
                       tolerance = 0.01)

  }

  expect_equivalent (shapiro.test(1:30)$statistic,
                     sw_test(1:30),
                     tolerance = 0.01)

  test_a_different_value (30, 0, 1)
  test_a_different_value (31, 0, 1)
  test_a_different_value (50, 676, 2)

  #different distribution
  #out of bounds n


})
