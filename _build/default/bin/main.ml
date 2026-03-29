open Raylib

let window_size = 1280, 960
let target_fps = 60
let max_sprite_frame = 4

type state_t =
  { sprite : sprite_t
  ; pos_x : float
  ; pos_y : float
  }

and sprite_t =
  { texture : Texture.t
  ; dir : direction_t
  ; frame : int
  ; step : float
  }

and direction_t =
  | D
  | L
  | R
  | U

let get_sprite_size (sprite : sprite_t) =
  let sprite_width = float_of_int (Raylib.Texture.width sprite.texture) /. 4.0 in
  let sprite_height = float_of_int (Raylib.Texture.height sprite.texture) /. 4.0 in
  sprite_width, sprite_height
;;

let map_direction_to_int direction =
  match direction with
  | D -> 0
  | L -> 1
  | R -> 2
  | U -> 3
;;

let draw_sprite (sprite : sprite_t) (x : float) (y : float) =
  (* TODO: Add acceleration *)
  let sprite_width, sprite_height = get_sprite_size sprite in
  let offset = map_direction_to_int sprite.dir in
  let frame_skip = target_fps / max_sprite_frame / 2 in
  let container =
    Rectangle.create
      (sprite_width *. float_of_int (sprite.frame / frame_skip))
      (sprite_height *. float_of_int offset)
      sprite_width
      sprite_height
  in
  let position = Vector2.create x y in
  Raylib.draw_texture_rec sprite.texture container position Color.white
;;

let next_frame (dir : direction_t) (sprite : sprite_t) =
  if sprite.dir = dir
  then (sprite.frame + 1) mod (target_fps * max_sprite_frame)
  else sprite.frame
;;

let next_x (direction : direction_t) (step : float) =
  match direction with
  | D -> 0.
  | L -> -.step
  | R -> +.step
  | U -> 0.
;;

let next_y (direction : direction_t) (step : float) =
  match direction with
  | D -> +.step
  | L -> 0.
  | R -> 0.
  | U -> -.step
;;

let is_go_down () = Raylib.is_key_down Key.J || Raylib.is_key_down Key.Down
let is_go_up () = Raylib.is_key_down Key.K || Raylib.is_key_down Key.Up
let is_go_left () = Raylib.is_key_down Key.H || Raylib.is_key_down Key.Left
let is_go_right () = Raylib.is_key_down Key.L || Raylib.is_key_down Key.Right

let get_movement () =
  if is_go_down ()
  then Some D
  else if is_go_up ()
  then Some U
  else if is_go_left ()
  then Some L
  else if is_go_right ()
  then Some R
  else None
;;

let get_next_state (state : state_t) =
  let sprite = state.sprite in
  match get_movement () with
  | None -> state
  | Some dir ->
    { sprite = { sprite with dir; frame = next_frame dir sprite }
    ; pos_x = state.pos_x +. next_x dir sprite.step
    ; pos_y = state.pos_y +. next_y dir sprite.step
    }
;;

let rec loop (state : state_t) =
  if Raylib.window_should_close ()
  then ()
  else (
    Raylib.begin_drawing ();
    Raylib.clear_background Color.black;
    draw_sprite state.sprite state.pos_x state.pos_y;
    Raylib.end_drawing ();
    get_next_state state |> loop)
;;

let () =
  let w, h = window_size in
  Raylib.init_window w h "Fun";
  Raylib.set_target_fps target_fps;
  let texture = Raylib.load_texture "assets/sprites/003.png" in
  let initial_state =
    { sprite = { texture; dir = D; frame = 0; step = 1.0 }; pos_x = 0.0; pos_y = 0.0 }
  in
  loop initial_state;
  Raylib.close_window ()
;;
