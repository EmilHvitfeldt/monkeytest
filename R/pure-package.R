#' Run all tests in a package purely
#'
#' @description
#' These pure functions will only run `test_that()` calls.
#' * `test_local_pure()` tests a local source package.
#' * `test_package_pure()` tests an installed package.
#' * `test_check_pure()` checks a package during `R CMD check`.
#'
#' Tests live in `tests/testthat`.
#'
#' @inherit testthat::test_dir return params
#' @inheritSection testthat::test_dir Special files
#' @inheritSection testthat::test_dir Environments
#' @param ... Additional arguments passed to [testthat::test_dir()]
#' @export
#' @rdname test_package_pure
test_package_pure <- function(package, reporter = check_reporter(), ...) {
  test_path <- system.file("tests", "testthat", package = package)
  if (test_path == "") {
    inform(paste0("No installed testthat tests found for ", package))
    return(invisible())
  }

  test_dir_pure(
    test_path,
    package = package,
    reporter = reporter,
    ...,
    load_package = "installed"
  )
}

#' @export
#' @rdname test_package_pure
test_check_pure <- function(package, reporter = check_reporter(), ...) {
  require(package, character.only = TRUE)
  test_dir_pure(
    "testthat",
    package = package,
    reporter = reporter,
    ...,
    load_package = "installed"
  )
}

#' @export
#' @rdname test_package_pure
test_local_pure <- function(path = ".", reporter = NULL, ...) {
  package <- pkgload::pkg_name(path)
  test_path <- file.path(pkgload::pkg_path(path), "tests", "testthat")

  withr::local_envvar(NOT_CRAN = "true")
  test_dir_pure(
    test_path,
    package = package,
    reporter = reporter,
    ...,
    load_package = if (package != "testthat") "source" else "none"
  )
}
