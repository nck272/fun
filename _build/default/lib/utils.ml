open Raylib

let get_xy (pos : Vector2.t) = Vector2.x pos, Vector2.y pos

let get_size (texture : Texture.t) (pos : Vector2.t) =
  float_of_int (Texture.width texture / 4), float_of_int (Texture.height texture / 4)
;;
