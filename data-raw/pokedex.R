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
  select(url) %>%
  add_column(data = dex) %>%
  unnest_wider(data, names_repair = "minimal") %>%
  select(order, name, types, species, height, weight, abilities, base_experience, stats, held_items, is_default) %>%
  rename_with(~ c("order", "full_name", "type", "species", "ht", "wt", "abilities", "exp", "stats", "items", "default"), names(pokedex))

### ---DO NOT CHANGE/RUN ABOVE UNLESS RUNNING ALL

pokedex2 <- pokedex %>%
  unnest_wider(type, names_repair = "minimal")

pokedex2$type <- t(pokedex2[[4]][[1]][[1]])
pokedex2$type <- paste(pokedex2$type[, 1], pokedex2$type[, 2], sep = ", ")
pokedex2$type <- map(map(pokedex2$type, ~ strsplit(.x, ",")), unlist)
pokedex2 <- subset(pokedex2, select = -slot)

pokedex2 <- pokedex2 %>%
  unnest_wider(species, names_repair = "minimal") %>%
  rename(species = name)


#   unnest_wider(abilities, names_repair = "minimal") %>%
#   unnest_wider(stats, names_repair = "minimal") %>%
#   unnest_wider(items, names_repair = "minimal")
#
#
