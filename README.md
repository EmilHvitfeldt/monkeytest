
<!-- README.md is generated from README.Rmd. Please edit that file -->

# monkeytest

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/monkeytest)](https://CRAN.R-project.org/package=monkeytest)
[![Codecov test
coverage](https://codecov.io/gh/EmilHvitfeldt/monkeytest/branch/main/graph/badge.svg)](https://app.codecov.io/gh/EmilHvitfeldt/monkeytest?branch=main)
[![R-CMD-check](https://github.com/EmilHvitfeldt/monkeytest/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/EmilHvitfeldt/monkeytest/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of monkeytest is to add variations of testing mechanics that
mimic that of [testthat](https://github.com/r-lib/testthat) that are
useful to catch errors of test smells.

## Installation

You can install the development version of monkeytest like so:

``` r
# Or the development version from GitHub:
# install.packages("devtools")
devtools::install_github("emilhvitfeldt/monkeytest")
```

## Example

The `*_pure()` family of functions mirrors the testthat functions except
that they only evaluate `test_that()` calls. This can be a useful tool
to check if your tests are properly self contained.

``` r
# Use
test_local_pure()
# Instead of 
test_local()
```

These functions should not be used on a regular basis, but can be useful
to clean up your tests and identify failure points.
