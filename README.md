
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

  - For 2 \<= n \<= 50, there are two “options”: the original approach
    for the Shapiro-Wilk test as described
    [here](https://www.real-statistics.com/tests-normality-and-symmetry/statistical-tests-normality-symmetry/shapiro-wilk-test/)
    and a modified approach that is compatible with the Royston approach
    (see below) as described in the last paragraph
    [here](https://www.real-statistics.com/tests-normality-and-symmetry/statistical-tests-normality-symmetry/shapiro-wilk-test/).

  - For n \> 50, the J. P. Royston approach for the Shapiro-Wilk test as
    described
    [here](https://www.real-statistics.com/tests-normality-and-symmetry/statistical-tests-normality-symmetry/shapiro-wilk-expanded-test/)
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

``` normal
library (checknormality)
set1 <- rnorm (50, 0, 1)
shapiro.test (set1)
sw_test (set1)
plot(density (set1))
```

## Example 2: Testing a sample from a normal distribution

``` r
library (checknormality)
set1 <- rnorm (50, 0, 1)
shapiro.test (set1)
#> 
#>  Shapiro-Wilk normality test
#> 
#> data:  set1
#> W = 0.98503, p-value = 0.773
sw_test (set1)
#>  [1] 1.688670e+00 4.021886e-01 5.616954e-01 5.138895e-01 9.534717e-01
#>  [6] 5.266090e-03 1.227038e-01 4.546810e-01 1.219958e-02 7.404258e-01
#> [11] 5.103042e-01 1.005203e+00 1.455994e+00 4.128012e+00 1.228166e+00
#> [16] 1.491502e+00 7.163809e-01 3.139425e-01 7.001719e-01 8.884068e-01
#> [21] 1.199625e-01 6.154608e-02 1.908010e+00 3.608774e-05 6.804595e-02
#> [26] 1.377779e-02 7.166097e+00 2.372139e-01 3.730401e+00 1.462941e-01
#> [31] 4.041212e-01 1.576736e-01 4.202577e-01 3.918320e-01 3.323551e-02
#> [36] 7.341878e-01 1.590865e-01 2.679409e-02 2.971106e-02 1.118247e-01
#> [41] 2.327180e-01 2.323793e-01 6.221634e-02 5.439554e+00 1.675611e+00
#> [46] 2.752238e-01 1.357998e-02 3.801394e-02 7.204376e-03 8.234500e-01
plot(density (set1))
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />
