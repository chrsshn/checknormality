
<!-- README.md is generated from README.Rmd. Please edit that file -->

# checknormality

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/chrsshn/checknormality.svg?branch=main)](https://travis-ci.com/chrsshn/checknormality)
[![Codecov test
coverage](https://codecov.io/gh/chrsshn/checknormality/branch/main/graph/badge.svg)](https://codecov.io/gh/chrsshn/checknormality?branch=main)
<!-- badges: end -->

## Overview

The goal of checknormality is to provide implementations of popular
normality tests that returns the test statistics and p-values. As of
2020/11/30, the package contains an implementation of the [Shapiro-Wilk
Test of
Normality](https://en.wikipedia.org/wiki/Shapiro%E2%80%93Wilk_test).

## A Note on the Algorithms

### Shapiro-Wilk Test

  - For n \> 50, the J. P. Royston approach for the Shapiro-Wilk test as
    described
    [here](https://www.real-statistics.com/tests-normality-and-symmetry/statistical-tests-normality-symmetry/shapiro-wilk-expanded-test/)
    must be used.

  - For 3 \<= n \<= 50, there are three “approaches”: the original
    approach for the Shapiro-Wilk test as described
    [here](https://www.real-statistics.com/tests-normality-and-symmetry/statistical-tests-normality-symmetry/shapiro-wilk-test/),
    a modified approach that is compatible with the Royston approach as
    described in the last paragraph
    [here](https://www.real-statistics.com/tests-normality-and-symmetry/statistical-tests-normality-symmetry/shapiro-wilk-test/),
    and the Royston approach for n \> 20.

### Inverse of Normal CDF (Phi inverse)

  - The Royston approach requires the inverse of the normal CDF, which
    is calculated in R using

<!-- end list -->

``` r
stats::qnorm(p)
```

  - In the Rcpp implementation of the Royston approach, a
    [freely-available stand-alone C++
    implementation](https://www.johndcook.com/blog/cpp_phi_inverse/) was
    used.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("chrsshn/checknormality")
```

## Usage

### Example 1: Testing a small sample from an exponential distribution using the original, modified, and Royston approaches

``` r
set1 <- rexp (30, .8)
checknormality::sw_test (set1, "original")
#> 
#>  Shapiro-Wilk Test of Normality
#> 
#> data:  set1
#> W = 0.77896, p-value = 0.001
checknormality::sw_test (set1, "modified")
#> 
#>  Shapiro-Wilk Test of Normality
#> 
#> data:  set1
#> W = 0.77896, p-value = 0.001
checknormality::sw_test (set1, "royston")
#> 
#>  Shapiro-Wilk Test of Normality
#> 
#> data:  set1
#> W = 0.77756, p-value = 3e-05
stats::shapiro.test (set1) 
#> 
#>  Shapiro-Wilk normality test
#> 
#> data:  set1
#> W = 0.77793, p-value = 2.664e-05
plot(density (set1))
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

### Example 2: Testing a small sample from a normal distribution using the original, modified, and Royston approaches

``` r
set2 <- rnorm (40, 20, 5)
checknormality::sw_test (set2, "original")
#> 
#>  Shapiro-Wilk Test of Normality
#> 
#> data:  set2
#> W = 0.95521, p-value = 0.2099
checknormality::sw_test (set2, "modified")
#> 
#>  Shapiro-Wilk Test of Normality
#> 
#> data:  set2
#> W = 0.95521, p-value = 0.2099
checknormality::sw_test (set2, "royston")
#> 
#>  Shapiro-Wilk Test of Normality
#> 
#> data:  set2
#> W = 0.95829, p-value = 0.1464
stats::shapiro.test (set2)
#> 
#>  Shapiro-Wilk normality test
#> 
#> data:  set2
#> W = 0.95814, p-value = 0.1447
plot(density (set2))   
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

### Example 3: Testing a large sample from a Poisson distribution using the Royston approach

note: the original and modified approaches are only valid for n \< 50
points

``` r
set3 <- rpois(4000, .787)
checknormality::sw_test (set3, "royston")
#> 
#>  Shapiro-Wilk Test of Normality
#> 
#> data:  set3
#> W = 0.79618, p-value < 2.2e-16
stats::shapiro.test (set3)
#> 
#>  Shapiro-Wilk normality test
#> 
#> data:  set3
#> W = 0.79618, p-value < 2.2e-16
plot(density (set3))   
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

## Example 4: Testing a large sample from a normal distribution using the Royston approach

note: the original and modified approaches are only valid for n \< 50
points

``` r
set4 <- rnorm(4000)
checknormality::sw_test (set4, "royston")
#> 
#>  Shapiro-Wilk Test of Normality
#> 
#> data:  set4
#> W = 0.99937, p-value = 0.1967
stats::shapiro.test (set4)
#> 
#>  Shapiro-Wilk normality test
#> 
#> data:  set4
#> W = 0.99937, p-value = 0.1966
plot(density (set4))   
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />
