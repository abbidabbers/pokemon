library(tidyverse)
library(httr)
library(jsonlite)

# Get API url for each move
moves_get <- GET("https://pokeapi.co/api/v2/move?limit=100000&offset=0")

# Create data frame out of JSON file
moves_raw <- fromJSON(rawToChar(moves_get$content))$results

# Get API information for each move
movedex <- map(map(map(moves_raw$url, GET), function(x) {
  rawToChar(x$content)
}), fromJSON)

# Add information to data frame, expand it, and choose appropriate variables
moves_index <- moves_raw %>%
  select(url) %>%
  add_column(data = movedex) %>%
  unnest_wider(data, names_repair = "minimal") %>%
  select(
    name, type, accuracy, pp, damage_class, power, learned_by_pokemon,
    generation
  ) %>%
  rename_with(~ c(
    "move_name", "type", "accuracy", "pp", "damage_class", "power",
    "learned_by_pokemon", "generation"
  ), names(.))

# Expand variables
moves_index$move_name <- map_chr(1:844, ~ moves_index$move_name[[.]][[1]])
moves_index$type <- map_chr(1:844, ~ moves_index$type[[.]][[1]])
moves_index$accuracy <- map_int(1:844, ~ moves_index$accuracy[[.]][[1]])
moves_index$pp <- map_int(1:844, ~ moves_index$pp[[.]][[1]])
moves_index$damage_class <- map_chr(1:844, ~ moves_index$damage_class[[.]][[1]])
moves_index$power <- map_int(1:844, ~ moves_index$power[[.]][[1]])
moves_index$learned_by_pokemon <- map(1:844, ~ moves_index$learned_by_pokemon[[.]][[1]])
moves_index$generation <- map_chr(1:844, ~ moves_index$generation[[.]][[1]])

# Edit formatting
moves_index$learned_by_pokemon[moves_index$learned_by_pokemon == "NULL"] <- NA

# Export the data
usethis::use_data(moves_index, overwrite = TRUE)
