open Raylib
open Types

let draw_entity (entity : state_entity_t) =
  let w, h = Utils.get_size entity.sprite in
  let dx = float_of_int (entity.step / entity.speed mod 4) *. w in
  let dy = Utils.float_of_direction entity.dir *. h in
  let rect = Rectangle.create dx dy w h in
  Raylib.draw_texture_rec entity.sprite rect entity.pos Color.raywhite
;;

let draw_resource (resource : state_resource_t) =
  let w, h = Utils.get_size resource.sprite in
  let rect = Rectangle.create 0. 0. w h in
  Raylib.draw_texture_rec resource.sprite rect resource.pos Color.raywhite
;;
