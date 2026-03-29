open Raylib
open Types

let create_pokemon_random_at () : state_entity_t =
  Random.self_init ();
  let i = Random.int Constants.n_pokemons in
  let x = Random.float (float_of_int Constants.window_width) in
  let y = Random.float (float_of_int Constants.window_height) in
  let sprite = Raylib.load_texture (Printf.sprintf "assets/sprites/%03d.png" i) in
  { sprite; pos = Vector2.create x y; dir = D; step = 0; speed = 4 }
;;
