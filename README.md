
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pokemon

<!-- badges: start -->
<!-- badges: end -->

`pokemon` is an R package that contains Pokémon-related datasets. The
first Pokémon video game came out in 1996, and Nintendo has since
released nine generations of games, including 37 individual games in the
main series. It is the second best-selling video game series of all time
and is actively played by millions of people. Previously, only Pokédex
data could be found, but this package expands the availability by
including datasets related to regions and moves, as well as the Pokédex.
The goal of this package is to create a design that allows users to view
and easily interact with extensive Pokémon-related data without needing
to collect it themselves because no such package currently exists (to
our knowledge). This package can help create visualizations to compare
different types of Pokémon, demonstrating evolution charts, examining
the prevalence of particular attack or defense moves, and more. It
allows Pokémon enthusiasts and those hunting for datasets to perform
Pokémon-related data analysis more smoothly.

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

-   `pokedex`: a small subset of the Pokédex
    -   Note: type defense is based on the primary ability if one of the
        abilities affects type defense
-   more will be coming

## Example: Pokédex

``` r
head(pokemon::pokedex)
#>   natl_no       name           type        species height weight ability1
#> 1       1  Bulbasaur Grass,  Poison   Seed Pokémon    0.7    6.9 Overgrow
#> 2       2    Ivysaur Grass,  Poison   Seed Pokémon    1.0   13.0 Overgrow
#> 3       3   Venusaur Grass,  Poison   Seed Pokémon    2.0  100.0 Overgrow
#> 4       4 Charmander           Fire Lizard Pokémon    0.6    8.5    Blaze
#> 5       5 Charmeleon           Fire  Flame Pokémon    1.1   19.0    Blaze
#> 6       6  Charizard  Fire,  Flying  Flame Pokémon    1.7   90.5    Blaze
#>   ability2 hidden_ability                             ev_yield catch_rate
#> 1     <NA>    Chlorophyll                     1 Special Attack         45
#> 2     <NA>    Chlorophyll 1 Special Attack,  1 Special Defense         45
#> 3     <NA>    Chlorophyll 2 Special Attack,  1 Special Defense         45
#> 4     <NA>    Solar Power                              1 Speed         45
#> 5     <NA>    Solar Power           1 Special Attack,  1 Speed         45
#> 6     <NA>    Solar Power                     3 Special Attack         45
#>   base_friend base_exp growth_rate        egg_group male female egg_cycles
#> 1          50       64 Medium Slow  Grass,  Monster 87.5   12.5         20
#> 2          50      142 Medium Slow  Grass,  Monster 87.5   12.5         20
#> 3          50      236 Medium Slow  Grass,  Monster 87.5   12.5         20
#> 4          50       62 Medium Slow Dragon,  Monster 87.5   12.5         20
#> 5          50      142 Medium Slow Dragon,  Monster 87.5   12.5         20
#> 6          50      240 Medium Slow Dragon,  Monster 87.5   12.5         20
#>   base_hp base_attack base_defense base_spattack base_spdefense base_speed
#> 1      45          49           49            65             65         45
#> 2      60          62           63            80             80         60
#> 3      80          82           83           100            100         80
#> 4      39          52           43            60             50         65
#> 5      58          64           58            80             65         80
#> 6      78          84           78           109             85        100
#>   base_total
#> 1        318
#> 2        405
#> 3        525
#> 4        309
#> 5        405
#> 6        534
#>                                                                         type_defenses
#> 1    1,  2,  0.5,  0.5,  0.25,  2,  0.5,  1,  1,  2,  2,  1,  1,  1,  1,  1,  1,  0.5
#> 2    1,  2,  0.5,  0.5,  0.25,  2,  0.5,  1,  1,  2,  2,  1,  1,  1,  1,  1,  1,  0.5
#> 3    1,  2,  0.5,  0.5,  0.25,  2,  0.5,  1,  1,  2,  2,  1,  1,  1,  1,  1,  1,  0.5
#> 4   1,  0.5,  2,  1,  0.5,  0.5,  1,  1,  2,  1,  1,  0.5,  2,  1,  1,  1,  0.5,  0.5
#> 5   1,  0.5,  2,  1,  0.5,  0.5,  1,  1,  2,  1,  1,  0.5,  2,  1,  1,  1,  0.5,  0.5
#> 6 1,  0.5,  2,  2,  0.25,  1,  0.5,  1,  0,  1,  1,  0.25,  4,  1,  1,  1,  0.5,  0.5
#>                             evo_order evo_level
#> 1      Bulbasaur,  Ivysaur,  Venusaur        16
#> 2      Bulbasaur,  Ivysaur,  Venusaur        32
#> 3      Bulbasaur,  Ivysaur,  Venusaur        NA
#> 4 Charmander,  Charmeleon,  Charizard        16
#> 5 Charmander,  Charmeleon,  Charizard        36
#> 6 Charmander,  Charmeleon,  Charizard        NA
```

## Contributors

-   [Abbie Benfield](https://github.com/abbidabbers)
-   [Kacey Jean-Jacques](https://github.com/kaceyjj)
-   [Elina Gordon-Halpern](https://github.com/egordonhalpern)
