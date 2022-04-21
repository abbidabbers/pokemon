library(tidyverse)
library(janitor)
library(httr)
library(jsonlite)

# Get API url for each Pokémon move
moves_get <- GET("https://pokeapi.co/api/v2/move?limit=100000&offset=0")

# Create dataframe out of JSON file
moves_raw <- fromJSON(rawToChar(moves_get$content))$results

# Get API information for each Pokémon move
dex <- map(map(map(moves_raw$url, GET), function(x) {
  rawToChar(x$content)
}), fromJSON)

# Add information to dataframe, expand it, and choose appropriate variables
moves_index <- moves_raw %>%
  select(url) %>%
  add_column(data = dex) %>%
  unnest_wider(data, names_repair = "minimal") %>%
  select(id, name, accuracy, pp, damage_class, power, learned_by_pokemon, generation) %>%
  rename_with(~ c("id", "item_name", "accuracy", "pp", "damage_class", "power", "learned_by_pokemon", "generation"), names(.))

