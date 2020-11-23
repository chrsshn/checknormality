test_that("sw_test works", {
  # set.seed(151)
  # nrep = 10
  # b0 = 5
  # b1 = -2
  # sigma = 2
  #
  #
  # ngroup = 2
  # group = rep( c("group1", "group2"), each = nrep)
  # eps = rnorm(n = ngroup*nrep, mean = 0, sd = sigma)
  # response = b0 + b1*(group == "group2") + eps
  # sim_dat = data.frame(group, response)
  # sim_dat
  #
  #
  # lin_reg <- lm (data = sim_dat, formula = response ~ group)
  # sum_lin <- summary (lin_reg)
  #
  # sum_lin$residuals
  #
  # sim_dat <- sim_dat %>%
  #   add_column (fitted_vals = lin_reg$fitted.values) %>%
  #   mutate (lm_residuals = response - fitted_vals)
  #
  # shapiro.test(sum_lin$residuals)
  # checktheresiduals::sw_test(sum_lin$residuals)



  expect_equivalent (shapiro.test(1:5)$statistic, sw_test(1:5), tolerance = 0.002)
})
