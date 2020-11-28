
<!-- README.md is generated from README.Rmd. Please edit that file -->

# checknormality

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/chrsshn/checknormality.svg?branch=main)](https://travis-ci.com/chrsshn/checknormality)
[![Codecov test
coverage](https://codecov.io/gh/chrsshn/checknormality/branch/main/graph/badge.svg)](https://codecov.io/gh/chrsshn/checknormality?branch=main)
<!-- badges: end -->

The goal of checknormality is to provide an implementation of popular
normality tests that returns the test statistics as well as plots the
distributions of sample points. Comparable versions of the Shapiro-Wilk
test and the Kolmogorov-Smirnov test are accessible through the base
stats package (base::shapiro.test and base::ks.test, respectively).

## A Note on the Algorithms

### Shapiro-Wilk Test

  - For 2 \<= n \<= 50, the original approach for the Shapiro-Wilk test
    (as described
    [here](https://www.real-statistics.com/tests-normality-and-symmetry/statistical-tests-normality-symmetry/shapiro-wilk-test/))
    is used.

  - For n \> 50, the J. P. Royston approach for the Shapiro-Wilk test
    (as described
    [here](https://www.real-statistics.com/tests-normality-and-symmetry/statistical-tests-normality-symmetry/shapiro-wilk-expanded-test/))
    is used.

## Installation

You can install the released version of checknormality from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("checknormality")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("chrsshn/checknormality")
```

## Example 1: Testing a sample from a normal distribution

``` r
library (checknormality)
set1 <- rnorm (50, 0, 1)
shapiro.test (set1)
#> 
#>  Shapiro-Wilk normality test
#> 
#> data:  set1
#> W = 0.9548, p-value = 0.0539
sw_test (set1)
#>  [1] 2.377756e-01 1.411785e-01 1.368072e+00 5.530068e-01 4.314716e-01
#>  [6] 2.460454e+00 7.578587e-01 1.281544e+00 1.435545e+00 7.254490e-05
#> [11] 3.494289e-01 3.679284e-01 4.336805e-02 1.309439e-01 2.373025e-02
#> [16] 1.095953e-02 4.622461e-03 9.467963e-02 4.892072e+00 8.406685e-01
#> [21] 2.626127e-03 6.653901e-01 6.182574e-02 5.340327e-01 1.535097e-01
#> [26] 2.573783e+00 5.343876e-02 3.762919e+00 1.240212e+00 3.086018e-01
#> [31] 1.263935e+00 3.673762e-02 3.833045e-01 3.415432e+00 4.338122e-04
#> [36] 9.881289e-03 1.617927e-01 1.014303e-01 8.538529e-02 7.838220e+00
#> [41] 2.064438e-01 5.170874e-01 9.988647e-01 4.415216e-01 9.092870e-01
#> [46] 2.395856e-01 8.351626e-05 3.304193e+00 5.199865e-01 7.184153e-02
plot(density (set1))
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />
