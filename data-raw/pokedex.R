library(tidyverse)
library(janitor)
library(httr)
library(jsonlite)

# Get API url for each Pokémon
pokemon_get <- GET("https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0")

# Create dataframe out of JSON file
pokemon_raw <- fromJSON(rawToChar(pokemon_get$content))$results

# Get API information for each Pokémon
dex <- map(map(map(pokemon_raw$url, GET), function(x) {
  rawToChar(x$content)
}), fromJSON)

# Add information to dataframe, expand it, and choose appropriate variables
pokedex <- pokemon_raw %>%
  select(url) %>%
  add_column(data = dex) %>%
  unnest_wider(data, names_repair = "minimal") %>%
  select(order, name, types, species, height, weight, abilities, base_experience, stats, held_items, is_default) %>%
  rename_with(~ c("order", "full_name", "type", "species", "ht", "wt", "abilities", "exp", "stats", "items", "default"), names(.))


# Note: all pokedex2 entries will eventually be converted to plain pokedex
pokedex2 <- pokedex

# Expand type
pokedex2$type <- map(1:1126, ~ pokedex2$type[[.]][[2]][[1]])


# Begin process of creating/expanding variables for regular and hidden abilities

# Find which Pokémon have a hidden ability and what its row index is in the abilities table
indices_true <- map(map(1:1126, ~ pokedex2$abilities[[.]][[2]]), function(x) {
  which(x == TRUE)
})

# Find which Pokémon have don't a hidden ability and what the row indicies are for its abilities in the abilities table
indices_false <- map(map(1:1126, ~ pokedex2$abilities[[.]][[2]]), function(x) {
  which(x == FALSE)
})

# Get its corresponding row index in the main table (for hidden ability)
index_vals_true <- which(map(map(1:1126, ~ pokedex2$abilities[[.]][[2]]), function(x) {
  which(x == TRUE)
}) != 0)

# Get its corresponding row index in the main table (for those with only 1 regular ability)
index_vals_false1 <- which(map(map(map(1:1126, ~ pokedex2$abilities[[.]][[2]]), function(x) {
  which(x == FALSE)
}), length) == 1)

# Get its corresponding row index in the main table (for those with 2 regular abilities)
index_vals_false2 <- which(map(map(map(1:1126, ~ pokedex2$abilities[[.]][[2]]), function(x) {
  which(x == FALSE)
}), length) == 2)

# Create the abilities variables
pokedex2 <- pokedex2 %>%
  mutate(hidden_ability = ifelse(map(1:1126, ~ is_empty(indices_true[[.]]) == FALSE),
    map(index_vals_true, ~ pokedex2$abilities[[.]][[1]][[1]][[indices_true[[1]]]]), NA
  )) %>%
  mutate(abilities = ifelse(map(map(1:1126, ~ indices_false[[.]]), length) == 2,
    map(index_vals_false2, ~ paste0(pokedex2$abilities[[.]][[1]][[1]][[indices_false[[1]]]], ", ", pokedex2$abilities[[.]][[1]][[1]][[indices_false[[2]]]])),
    map(index_vals_false1, ~ pokedex2$abilities[[.]][[1]][[1]][[indices_false[[1]]]])
  ))

# Make the abilities column a list
pokedex2$abilities <- map(map(pokedex2$abilities, ~ strsplit(.x, ",")), unlist)

# Expand stats, items, and tie in species information from below
  # Need better variable order
  # Change NULLs to NAs?





# Get API information for each Pokémon species (may include repeat URLs for Pokémon of the same species)
species_data <- map(map(map(pokedex2$url, GET), function(x) {
  rawToChar(x$content)
}), fromJSON)

# Add information to dataframe, expand it, and choose appropriate variables
species <- pokemon_raw %>%
  select(url) %>%
  add_column(data = species_data) %>%
  unnest_wider(data, names_repair = "minimal") %>%
  select(name, base_happiness, capture_rate, color, egg_groups, evolves_from_species, forms_switchable, gender_rate, genera, generation, growth_rate, habitat, has_gender_differences, hatch_counter, is_baby, is_legendary, is_mythical, order, shape, varieties)

# Expand variables
species$color <- map(1:1126, ~ species$color[[.]][[1]])
species$egg_groups <- map(1:1126, ~ species$egg_groups[[.]][[1]])
species$evolves_from_species <- map(1:1126, ~ species$evolves_from_species[[.]][[1]])
species$genera <- map(1:1126, ~ species$genera[[.]][[1]][[8]])
species$generation <- map(1:1126, ~ species$generation[[.]][[1]])
species$growth_rate <- map(1:1126, ~ species$growth_rate[[.]][[1]])
species$habitat <- map(1:1126, ~ species$generation[[.]][[1]])
species$shape <- map(1:1126, ~ species$shape[[.]][[1]])
species$varieties <- map(1:1126, ~ species$varieties[[.]][[2]][[1]])
