open Raylib
open Types

let create_random_pokemon_sprite () : Texture.t =
  Random.self_init ();
  Raylib.load_texture
    (Printf.sprintf "assets/sprites/%03d.png" (Random.int Constants.n_pokemons))
;;

let create_random_resource () : state_resource_t =
  Random.self_init ();
  let sprite = create_random_pokemon_sprite () in
  let w, h = Utils.get_size sprite in
  let x = Random.float (float_of_int Constants.window_width -. w) in
  let y = Random.float (float_of_int Constants.window_height -. h) in
  { sprite
  ; pos = Vector2.create x y
  ; interval = 1.
  ; value = 0.
  ; _type = ROCK
  ; last_time = Unix.gettimeofday ()
  }
;;
