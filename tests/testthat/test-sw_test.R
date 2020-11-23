test_that("sw_test works", {


  expect_equivalent (shapiro.test(1:5)$statistic, sw_test(1:5), tolerance = 0.002)
})
