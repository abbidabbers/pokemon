test_that("pokedex has correct number of rows and columns", {
  expect_equal(nrow(pokedex), 1126)
  expect_equal(ncol(pokedex), 33)
})

test_that("item_index has correct number of rows and columns", {
  expect_equal(nrow(item_index), 1607)
  expect_equal(ncol(item_index), 7)
})

test_that("moves_index has correct number of rows and columns", {
  expect_equal(nrow(moves_index), 844)
  expect_equal(ncol(moves_index), 8)
})
