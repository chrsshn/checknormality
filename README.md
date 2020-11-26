
<!-- README.md is generated from README.Rmd. Please edit that file -->

# checknormality

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/chrsshn/checknormality.svg?branch=main)](https://travis-ci.com/chrsshn/checknormality)
[![Codecov test
coverage](https://codecov.io/gh/chrsshn/checknormality/branch/main/graph/badge.svg)](https://codecov.io/gh/chrsshn/checknormality?branch=main)
<!-- badges: end -->

The goal of checknormality is to provide an implementation of popular normality tests that returns the test statistics as well as plots the distributions of sample points. Comparable versions of the Shapiro-Wilk test and the Kolmogorov-Smirnov test are accessible through the base stats package (base::shapiro.test and base::ks.test, respectively).

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

