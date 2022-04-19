library(tidyverse)
library(janitor)
library(httr)
library(jsonlite)

pokemon_raw <-
  GET("https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0")

pokemon <- fromJSON(rawToChar(pokemon_raw$content))$results

dex <- map(map(map(pokemon$url, GET), function(x) {
  rawToChar(x$content)
}), fromJSON)

pokedex <- pokemon %>%
  select(url)
pokedex$data <- dex

pokedex <- pokedex %>%
  unnest_wider(data, names_repair = "universal") %>%
  select(order...1, name...2, types...3, species...4, height...5, weight...6, abilities...7, base_experience...8, stats...9, held_items...10, is_default...11) %>%
  clean_names()

names(pokedex) <- c("order", "name", "type", "species", "ht", "wt", "abilities", "exp", "stats", "items", "default")

pokedex <- pokedex %>%
  unnest_wider(type, names_repair = "minimal") %>%
  unnest_wider(species, names_repair = "minimal") %>%
  unnest_wider(abilities, names_repair = "minimal") %>%
  unnest_wider(stats, names_repair = "minimal") %>%
  unnest_wider(items, names_repair = "minimal")


