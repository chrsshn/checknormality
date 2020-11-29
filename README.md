
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
#> W = 0.97999, p-value = 0.5514
sw_test (set1)
#>  [1] 0.237721596 1.058921751 0.041337161 1.233142312 0.210247698 0.359917457
#>  [7] 0.234603651 0.249073281 1.459571736 7.776508925 0.196683380 0.052704199
#> [13] 2.021400294 1.975280523 0.590255614 0.041989452 0.019104092 0.435653985
#> [19] 0.700613132 0.392357162 1.046698921 0.209102657 0.357909940 0.020950784
#> [25] 1.469254929 5.669832448 0.252290745 0.476174375 0.038824723 1.326724558
#> [31] 0.003143995 0.650810136 0.836382522 1.271781184 0.108877535 5.207621711
#> [37] 0.391709312 0.585029817 0.687259669 2.482328409 2.109762884 0.257954804
#> [43] 0.002359577 3.374346437 0.161248052 0.008218266 3.559156602 0.394719641
#> [49] 1.599446211 2.598222093
plot(density (set1))
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />
