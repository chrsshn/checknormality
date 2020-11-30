test_using_distributions <- function (dist, n, param1, param2, approach = "modified", use_c = F) {
  need_1_param = c("rpois", "rexp")

  if (dist %in% need_1_param)
    test_dist = match.fun(dist) (n, param1)
  else
    test_dist = match.fun(dist) (n, param1, param2)

  # approach = ifelse (n > 20, "royston", "modified")

  expect_equivalent (shapiro.test(test_dist)$statistic,
                     sw_test(test_dist, approach, use_c)$statistic,
                     tolerance = 0.02)
}


test_that("sw_test is accurate for normal distributions", {
  test_using_distributions("rnorm", 10, 0, 1)
  test_using_distributions("rnorm", 10, 0, 1, "modified")
  test_using_distributions("rnorm", 5000, 14, 16, "royston", F)
  test_using_distributions("rnorm", 5000, 14, 16, "royston", T)
  test_using_distributions("rnorm", 50, 3, 8, "original")
  test_using_distributions("rnorm", 50, 3, 8, "modified")
  test_using_distributions("rnorm", 50, 3, 8, "royston", F)
  test_using_distributions("rnorm", 50, 3, 8, "royston", T)


})

test_that("sw_test is accurate for non-normal distributions", {
  test_using_distributions("rpois", 9, 4,"", "original")
  test_using_distributions("rpois", 9, 4,"", "modified")
  test_using_distributions("rpois", 31, 6, "","original")
  test_using_distributions("rpois", 31, 6, "", "modified")
  test_using_distributions("rpois", 31, 6,"", "royston")
  test_using_distributions("rpois", 500, 78,"","royston", F)
  test_using_distributions("rpois", 500, 78,"","royston", T)


  test_using_distributions("rexp", 12, .4,"","original")
  test_using_distributions("rexp", 12, .4,"","modified")
  test_using_distributions("rexp", 29, 6,"","original")
  test_using_distributions("rexp", 29, 6,"","modified")
  test_using_distributions("rexp", 29, 6,"", "modified")
  test_using_distributions("rexp", 29, 6,"", "royston", F)
  test_using_distributions("rexp", 29, 6,"", "royston", T)
  test_using_distributions("rexp", 700, 1, "", "royston", F)
  test_using_distributions("rexp", 700, 1, "", "royston", T)


})

