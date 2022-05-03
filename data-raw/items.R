library(tidyverse)
library(httr)
library(jsonlite)

# Get API url for each Item
item_get <- GET("https://pokeapi.co/api/v2/item?offset=0&limit=10000")

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
  select(name, cost, category, attributes, held_by_pokemon, fling_power, fling_effect) %>%
  rename_with(~ c("item_name", "item_cost", "category", "attributes", "pokemon", "fling_power", "fling_effect"), names(.))

# Expand Variables
item_index$item_name <- map_chr(1:1607, ~ item_index$item_name[[.]][[1]])
item_index$item_cost <- map_dbl(1:1607, ~ item_index$item_cost[[.]][[1]])
item_index$category <- map_chr(1:1607, ~ item_index$category[[.]][[1]])
item_index$fling_power <- map(1:1607, ~ item_index$fling_power[[.]][[1]])
item_index$fling_effect <- map(1:1607, ~ item_index$fling_effect[[.]][[1]])
item_index$pokemon <- map(1:1607, ~ item_index$pokemon[[.]][[1]])

# Edit Formatting for Attributes, Pokemon, and Fling Effect
item_index$fling_effect[item_index$fling_effect == "NULL"] <- NA
item_index$pokemon[item_index$pokemon == "NULL"] <- NA
item_index$attributes[item_index$attributes == "NULL"] <- NA

# Export data
usethis::use_data(item_index, overwrite = TRUE)
