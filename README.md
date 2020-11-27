
<!-- README.md is generated from README.Rmd. Please edit that file -->

# checknormality

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/chrsshn/checknormality.svg?branch=main)](https://travis-ci.com/chrsshn/checknormality)
[![Codecov test
coverage](https://codecov.io/gh/chrsshn/checknormality/branch/main/graph/badge.svg)](https://codecov.io/gh/chrsshn/checknormality?branch=main)
<!-- badges: end -->

The goal of checknormality is to provide an implementation of popular normality tests that returns the test statistics as well as plots the distributions of sample points. Comparable versions of the Shapiro-Wilk test and the Kolmogorov-Smirnov test are accessible through the base stats package (base::shapiro.test and base::ks.test, respectively).

## A Note on the Algorithms

### Shapiro-Wilk Test
- For  3 <= n <= 50, the original approach for the Shapiro-Wilk test (as described [here](https://www.real-statistics.com/tests-normality-and-symmetry/statistical-tests-normality-symmetry/shapiro-wilk-test/)) is used.

- For n > 50, the J. P. Royston approach for the Shapiro-Wilk test (as described [here](https://www.real-statistics.com/tests-normality-and-symmetry/statistical-tests-normality-symmetry/shapiro-wilk-expanded-test/)) is used.


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

## Example
This is a basic example that compares the functions in this package with functions from the base stats package.

