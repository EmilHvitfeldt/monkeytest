is_test_that <- function(x) {
  purrr::map_lgl(x, ~.x[[1]] == "test_that")
}
