
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pokemon

<!-- badges: start -->

[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![CRAN
status](https://www.r-pkg.org/badges/version/pokemon)](https://CRAN.R-project.org/package=pokemon)
<!-- badges: end -->

`pokemon` is an R package that contains Pokémon-related datasets. The
first Pokémon video game came out in 1996, and Nintendo has since
released nine generations of games, including 37 individual games in the
main series. It is the second best-selling video game series of all time
and is actively played by millions of people. The Pokédex is an
encyclopedic collection of stats for all Pokémon in the game series.
Previously, only Pokédex data could be found, but this package expands
the availability of data by including data sets related to items and
moves, as well as the Pokédex. Our data is retrieved from PokéAPI
(<https://pokeapi.co>), a public database of Pokémon-related data that
uses URL links as a programming interface. The goal of this package is
to create a design that allows users to view and easily interact with
extensive Pokémon-related data without needing to collect it themselves,
because no such package currently exists (to our knowledge). This
package can help create visualizations to compare different types of
Pokémon, demonstrating evolution charts, examining the prevalence of
particular attack or defense moves, and more. It allows Pokémon
enthusiasts and those hunting for datasets to perform Pokémon-related
data analysis more smoothly.

Note limitations: This data does not account for the two most recent
Pokémon game releases: Pokémon Shining Pearl and Brilliant Diamond, and
Pokémon Legends: Arceus, nor will it incorporate data from Pokémon
Scarlet and Violet (to be released Fall 2022). Some Pokémon Sword and
Shield data may be inaccurate due to communication errors from the API.
Some information from the API has not been added or updated.

## Installation

You can install the development version of pokemon from
[GitHub](https://github.com/) with:

``` r
devtools::install_github("abbidabbers/pokemon")
```

## Load

``` r
library(pokemon)
```

## Available Tables

-   `pokedex`: Detailed organizer for data included in the official
    Pokédex such as order, name, types, species, height, weight,
    abilities, base experience, stats, and held items for each Pokémon.
-   `items`: A more in-depth set of metadata about items in the Pokémon
    games, such as item ID, name, cost, category, the power and effect
    of the move “Fling” when used with this item, and the Pokémon that
    can hold it.
-   `moves`: A collection of data about moves in the Pokémon games,
    including name, accuracy, power, generation, etc.

## Example: Pokédex

``` r
head(pokemon::pokedex)
#>   order       name species_name          genus          gen          type ht
#> 1     1  bulbasaur    bulbasaur   Seed Pokémon generation-i grass, poison  7
#> 2     2    ivysaur      ivysaur   Seed Pokémon generation-i grass, poison 10
#> 3     3   venusaur     venusaur   Seed Pokémon generation-i grass, poison 20
#> 4     5 charmander   charmander Lizard Pokémon generation-i          fire  6
#> 5     6 charmeleon   charmeleon  Flame Pokémon generation-i          fire 11
#> 6     7  charizard    charizard  Flame Pokémon generation-i  fire, flying 17
#>     wt color     shape   habitat             abilities catch friend exp
#> 1   69 green quadruped grassland overgrow, chlorophyll    45     50  64
#> 2  130 green quadruped grassland overgrow, chlorophyll    45     50 142
#> 3 1000 green quadruped grassland overgrow, chlorophyll    45     50 263
#> 4   85   red   upright  mountain    blaze, solar-power    45     50  62
#> 5  190   red   upright  mountain    blaze, solar-power    45     50 142
#> 6  905   red   upright  mountain    blaze, solar-power    45     50 267
#>        growth      egg_groups     f gender_diff egg_cycles hp attack defense
#> 1 medium-slow  monster, plant 0.125       FALSE         20 45     49      49
#> 2 medium-slow  monster, plant 0.125       FALSE         20 60     62      63
#> 3 medium-slow  monster, plant 0.125        TRUE         20 80     82      83
#> 4 medium-slow monster, dragon 0.125       FALSE         20 39     52      43
#> 5 medium-slow monster, dragon 0.125       FALSE         20 58     64      58
#> 6 medium-slow monster, dragon 0.125       FALSE         20 78     84      78
#>   spattack spdefense speed total evolves_from default
#> 1       65        65    45   318         NULL    TRUE
#> 2       80        80    60   405    bulbasaur    TRUE
#> 3      100       100    80   525      ivysaur    TRUE
#> 4       60        50    65   309         NULL    TRUE
#> 5       80        65    80   405   charmander    TRUE
#> 6      109        85   100   534   charmeleon    TRUE
#>                                                       varieties form_switch
#> 1                                                     bulbasaur       FALSE
#> 2                                                       ivysaur       FALSE
#> 3                        venusaur, venusaur-mega, venusaur-gmax        TRUE
#> 4                                                    charmander       FALSE
#> 5                                                    charmeleon       FALSE
#> 6 charizard, charizard-mega-x, charizard-mega-y, charizard-gmax        TRUE
#>    baby legendary mythical
#> 1 FALSE     FALSE    FALSE
#> 2 FALSE     FALSE    FALSE
#> 3 FALSE     FALSE    FALSE
#> 4 FALSE     FALSE    FALSE
#> 5 FALSE     FALSE    FALSE
#> 6 FALSE     FALSE    FALSE
```

## Contributors

-   [Abbie Benfield](https://github.com/abbidabbers)
-   [Kacey Jean-Jacques](https://github.com/kaceyjj)
-   [Elina Gordon-Halpern](https://github.com/egordonhalpern)

## Acknowledgements

Many thanks to the folks at PokeAPI for their amazing work
