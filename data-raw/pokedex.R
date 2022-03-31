## code to prepare `pokedex` dataset goes here

pokedex <-
  "data-raw/pokedex.csv" %>%
  read_csv() %>%
  clean_names()
usethis::use_data(pokedex, overwrite = TRUE)
