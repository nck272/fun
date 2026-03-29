open Utils
open Types
open Raylib

let draw_entity (entity : state_entity_t) =
  let x, y = Utils.get_xy entity.pos in
  let w, h = Utils.get_size entity.sprite entity.pos in
  let dy =
    match entity.dir with
    | D -> 0.
    | U -> h
    | L -> 2. *. h
    | R -> 3. *. h
  in
  let rect = Rectangle.create x (y +. dy) w h in
  Raylib.draw_texture_rec entity.sprite rect entity.pos Color.white
;;
