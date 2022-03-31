library(tidyverse)
library(janitor)

pokedex <-
  "data-raw/pokedex.csv" %>%
  read_csv() %>%
  clean_names()
pokedex$type <- map(map(pokedex$type, ~strsplit(.x, ",")), unlist)
pokedex$ev_yield <- map(map(pokedex$ev_yield, ~strsplit(.x, ",")), unlist)
pokedex$egg_group <- map(map(pokedex$egg_group, ~strsplit(.x, ",")), unlist)
pokedex$type_defenses <- map(map(pokedex$type_defenses, ~strsplit(.x, ",")), unlist)
pokedex$evo_order <- map(map(pokedex$evo_order, ~strsplit(.x, ",")), unlist)
usethis::use_data(pokedex, overwrite = TRUE)
