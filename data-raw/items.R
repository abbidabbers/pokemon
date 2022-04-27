library(tidyverse)
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
  select(id, name, cost, category, held_by_pokemon, fling_power, fling_effect) %>%
  rename_with(~ c("id", "item_name", "item_cost", "category", "pokemon", "fling_power", "fling_effect"), names(.))

# Expand Variable
item_index$id <- map(1:20, ~ item_index$id[[.]][[1]])
item_index$item_name <- map(1:20, ~ item_index$item_name[[.]][[1]])
item_index$item_cost <- map(1:20, ~ item_index$item_cost[[.]][[1]])
item_index$category <- map(1:20, ~ item_index$category[[.]][[1]])
item_index$fling_power <- map(1:20, ~ item_index$fling_power[[.]][[1]])
item_index$fling_effect <- map(1:20, ~ item_index$fling_effect[[.]][[1]])

# Export data
usethis::use_data(item_index, overwrite = TRUE)

