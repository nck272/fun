open Raylib
open Types

let get_xy (pos : Vector2.t) = Vector2.x pos, Vector2.y pos

let get_size (texture : Texture.t) =
  float_of_int (Texture.width texture / 4), float_of_int (Texture.height texture / 4)
;;

let float_of_direction (dir : direction_t) =
  match dir with
  | D -> 0.
  | L -> 1.
  | R -> 2.
  | U -> 3.
;;

let is_go_down () = Raylib.is_key_down Key.S
let is_go_up () = Raylib.is_key_down Key.W
let is_go_left () = Raylib.is_key_down Key.A
let is_go_right () = Raylib.is_key_down Key.D
