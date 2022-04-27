library(tidyverse)
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
  select(order, name, types, species, height, weight, abilities,
         base_experience, stats, is_default) %>%
  rename_with(~ c("order", "full_name", "type", "species", "ht", "wt",
                  "abilities", "exp", "stats", "default"), names(.))

# Expand type
pokedex$type <- map(1:1126, ~ pokedex$type[[.]][[2]][[1]])

# Expand abilities
pokedex$abilities <- map(map(map(1:1126, ~ pokedex$abilities[[.]][[1]][[1]]),
                              ~ strsplit(.x, ",")), unlist)

# Expand stats
pokedex$hp <- map(1:1126, ~ pokedex$stats[[.]][[1]][[1]])
pokedex$attack <- map(1:1126, ~ pokedex$stats[[.]][[1]][[2]])
pokedex$defense <- map(1:1126, ~ pokedex$stats[[.]][[1]][[3]])
pokedex$spattack <- map(1:1126, ~ pokedex$stats[[.]][[1]][[4]])
pokedex$spdefense <- map(1:1126, ~ pokedex$stats[[.]][[1]][[5]])
pokedex$speed <- map(1:1126, ~ pokedex$stats[[.]][[1]][[6]])

# Get species url
species_url <- map(1:1126, ~pokedex$species[[.]][[2]])

# Remove stats, species columns, add column for sum of stats
pokedex <- pokedex %>%
  select(-stats, -species) %>%
  mutate(total = map(1:1126, ~pokedex$hp[[.]] +
                       pokedex$attack[[.]] +
                       pokedex$defense[[.]] +
                       pokedex$spattack[[.]] +
                       pokedex$spdefense[[.]] +
                       pokedex$speed[[.]]))


# Get API information for each Pokémon species
  # (may include repeat URLs for Pokémon of the same species)
species_data <- map(map(map(species_url, GET), function(x) {
  rawToChar(x$content)
}), fromJSON)

# Add information to dataframe, expand it, and choose appropriate variables
species <- pokemon_raw %>%
  select(url) %>%
  add_column(data = species_data) %>%
  unnest_wider(data, names_repair = "minimal") %>%
  select(name, base_happiness, capture_rate, color, egg_groups,
         evolves_from_species, forms_switchable, gender_rate, genera,
         generation, growth_rate, habitat, has_gender_differences, hatch_counter,
         is_baby, is_legendary, is_mythical, shape, varieties) %>%
  rename_with(~ c("species_name", "friend", "catch", "color", "egg_groups",
                  "evolves_from", "form_switch", "f", "genus", "gen", "growth",
                  "habitat", "gender_diff", "egg_cycles", "baby", "legendary",
                  "mythical", "shape", "varieties"), names(.))

# Change formatting of gender
species$f[species$f == -1] <- NA

# Expand variables
species$color <- map(1:1126, ~ species$color[[.]][[1]])
species$egg_groups <- map(1:1126, ~ species$egg_groups[[.]][[1]])
species$evolves_from <- map(1:1126, ~ species$evolves_from[[.]][[1]])
species$genus <- map(1:1126, ~ species$genus[[.]][[1]][[8]])
species$gen <- map(1:1126, ~ species$gen[[.]][[1]])
species$growth <- map(1:1126, ~ species$growth[[.]][[1]])
species$habitat <- map(1:1126, ~ species$habitat[[.]][[1]])
species$shape <- map(1:1126, ~ species$shape[[.]][[1]])
species$varieties <- map(1:1126, ~ species$varieties[[.]][[2]][[1]])
species$f <- map(1:1126, ~species$f[[.]]/8)

# Combine pokedex and species data
pokedex <- cbind(pokedex, species)

# Reorder variables
pokedex <- pokedex %>%
  select(order, full_name, species_name, genus, gen, type, ht, wt, color, shape,
         habitat, abilities, catch, friend, exp, growth, egg_groups, f,
         gender_diff, egg_cycles, hp, attack, defense, spattack, spdefense,
         speed, total, evolves_from, default, varieties,form_switch, baby,
         legendary, mythical)

# Export data
usethis::use_data(pokedex, overwrite = TRUE)
