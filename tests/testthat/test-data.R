test_that("pokedex has correct number of rows and columns", {
  expect_equal(nrow(pokedex), 1126)
  expect_equal(ncol(pokedex), 33)
})
