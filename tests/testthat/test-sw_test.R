test_using_distributions <- function (dist, n, param1, param2) {
  #use a different return statement depending on the distribution
  need_1_param = c("rpois", "rexp")

  if (dist %in% need_1_param)
    test_dist = match.fun(dist) (n, param1)
  else
    test_dist = match.fun(dist) (n, param1, param2)

  expect_equivalent (shapiro.test(test_dist)$statistic,
                     sw_test(test_dist),
                     tolerance = 0.02)
}


test_that("sw_test is accurate for normal distributions", {
  test_using_distributions("rnorm", 10, 0, 1)
  test_using_distributions("rnorm", 31, 2, 1)
  test_using_distributions("rnorm", 50, 3, 8)


})

test_that("sw_test is accurate for non-normal distributions", {
  test_using_distributions("rpois", 9, 4)
  test_using_distributions("rpois", 31, 6)
  test_using_distributions("rpois", 50, 78)


  test_using_distributions("rexp", 12, .4)
  test_using_distributions("rexp", 19, 6)
  test_using_distributions("rexp", 50, 78)


})
