library(tidyverse)
library(janitor)
library(httr)
library(jsonlite)

pokemon_raw <-
  GET("https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0")

pokemon <- fromJSON(rawToChar(pokemon_raw$content))$results

dex_url <- "https://pokeapi.co/api/v2/pokemon/"

dex <- map(pokemon$url, GET)

dex2 <- map(dex, function(x) {
  rawToChar(x$content)
})

pokedex <- map(dex2, fromJSON)

pokedex2 <- pokedex

pokemon2 <- pokemon

pokemon2$data <- pokedex2

pokemon2 <- pokemon2 %>%
  unnest_wider(data, names_repair = "minimal")
