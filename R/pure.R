#' Run all tests in a single file purely
#'
#' Helper, setup, and teardown files located in the same directory as the
#' test will also be run. These pure functions will only run `test_that()` calls.
#'
#' @param path Path to file.
#' @param ... Additional parameters passed on to `testthat::test_file()`
#' @export
#' @examples
#' path <- testthat::testthat_example("success")
#' test_file_pure(path)
#' test_file_pure(path, reporter = "minimal")
test_file_pure <- function(path, ...) {
  if (!file.exists(path)) {
    stop("`path` does not exist", call. = FALSE)
  }

  old_test <- readLines(path)
  on.exit(writeLines(old_test, path))

  make_file_pure(path)

  test_file(path, ...)
}

make_file_pure <- function(input, output = input) {
  code_chunks <- parse(text = readLines(input))

  code_chunks <- code_chunks[is_test_that(code_chunks)]

  writeLines(as.character(code_chunks), output)
}

test_dir_pure <- function(path,
                          filter = NULL,
                          ...) {

  test_paths <- testthat::find_test_scripts(
    path,
    filter = filter,
    full.names = FALSE
  )

  test_paths_full <- file.path(path, test_paths)

  old_test <- lapply(test_paths_full, readLines)
  on.exit(purrr::walk2(old_test, test_paths_full, writeLines))

  purrr::walk(test_paths_full, make_file_pure)

  testthat::test_dir(path = path, ...)
}
