library(tidyverse)
library(janitor)
library(httr)
library(jsonlite)

# Get API url for each Item
item_get <- GET("https://pokeapi.co/api/v2/item?offset=20&limit=20")

# Create data frame out of JSON file
item_raw <- fromJSON(rawToChar(item_get$content))$results

# Get API information for each Item
itemdex <- map(map(map(item_raw$url, GET), function(x) {
  rawToChar(x$content)
}), fromJSON)

# Add information to data frame, expand it, and choose appropriate variable names
item_index <- item_raw %>%
  select(url) %>%
  add_column(data = itemdex) %>%
  unnest_wider(data, names_repair = "minimal") %>%
  select(id, name, cost, category, default, held_by_pokemon, rarity, version, pocket) %>%
  rename_with(~ c("id", "item_name", "item_cost", "category", "default_depiction", "pokemon", "rarity", "version", "pocket"), names(.))
