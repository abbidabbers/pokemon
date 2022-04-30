#' Available Pokémon
#'
#' A dataset of all available Pokémon forms and associated information
#'
#' @format A data frame of 1126 rows representing Pokémon and 33 variables
#' \describe{
#' \item{order}{Number in sorting order. Almost national order, except families grouped together.}
#' \item{name}{Name of Pokémon}
#' \item{species_name}{Species of Pokémon.}
#' \item{genus}{Genus of Pokémon.}
#' \item{gen}{Generation Pokémon introduced in.}
#' \item{type}{Type of Pokémon.}
#' \item{ht}{Height of Pokémon in meters.}
#' \item{wt}{Weight of Pokémon in kilograms.}
#' \item{color}{Color of Pokémon.}
#' \item{shape}{Shape of Pokémon.}
#' \item{abilities}{Abilities Pokémon can have.}
#' \item{catch}{Base catch rate of Pokémon; up to 255. The higher the number, the easier the catch.}
#' \item{friend}{Base friendship value of Pokémon when caught by a normal Pokéball; up to 255. The higher the number, the happier the Pokémon. Also known as happiness}
#' \item{exp}{Base experience value gained by defeating this Pokémon.}
#' \item{growth}{Growth rate of Pokémon; how fast it gains levels.}
#' \item{egg_groups}{Egg group(s) of Pokémon.}
#' \item{f}{Decimal proportion of Pokémon that are female; NA if genderless}
#' \item{gender_diff}{Whether Pokémon has visual gender differences.}
#' \item{egg_cycles}{Number of egg cycles for Pokémon. Must walk 255 × (egg_cycles + 1) steps before egg hatches, unless utilizing bonuses.}
#' \item{hp}{Base health points of Pokémon.}
#' \item{attack}{Base attack of Pokémon.}
#' \item{defense}{Base defense of Pokémon.}
#' \item{spattack}{Base special attack of Pokémon.}
#' \item{spdefense}{Base special defense of Pokémon.}
#' \item{speed}{Base speed of Pokémon.}
#' \item{total}{Total value of Pokémon's base stats (excluding base experience and base friendship).}
#' \item{evolves_from}{Pokémon species that evolves into this species.}
#' \item{default}{Whether default form of species.}
#' \item{varieties}{List of Pokémon in same species.}
#' \item{form_switch}{Whether Pokémon has multiple forms and can switch between them.}
#' \item{baby}{Whether baby Pokémon.}
#' \item{legendary}{Whether legendary Pokémon.}
#' \item{mythical}{Whether mythical Pokémon.}
#' }
#' @source https://pokeapi.co/
"pokedex"
