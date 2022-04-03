test_that("pokedex has correct number of rows and columns", {
  expect_equal(nrow(pokedex), 24)
  expect_equal(ncol(pokedex), 28)
})
