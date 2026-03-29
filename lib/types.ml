open Raylib

type state_main_t = { player : state_player_t }

and state_player_t =
  { base : state_entity_t
  ; team : state_player_team_t
  }

and state_entity_t =
  { sprite : Texture.t
  ; pos : Vector2.t
  ; dir : direction_t
  }

and state_player_team_t = { states : state_pokemon_t list }
and state_pokemon_t = { base : state_entity_t }

and direction_t =
  | D
  | U
  | L
  | R
