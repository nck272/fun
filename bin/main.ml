open Raylib
open Fun

let load_state () : Types.state_main_t =
  ({ player =
       { base =
           { sprite = Raylib.load_texture "assets/sprites/001.png"
           ; pos = Vector2.create 500.0 250.0
           ; dir = D
           ; step = 0
           ; speed = 4
           }
       ; team = { states = [] }
       }
   }
   : Types.state_main_t)
;;

let update_state_entity (state : Types.state_entity_t) : Types.state_entity_t =
  let get_axis_press positive_key negative_key =
    (if positive_key () then 1. else 0.) -. if negative_key () then 1. else 0.
  in
  let next_dir =
    match state.dir with
    | Types.D when Utils.is_go_down () -> Some Types.D
    | Types.L when Utils.is_go_left () -> Some Types.L
    | Types.R when Utils.is_go_right () -> Some Types.R
    | Types.U when Utils.is_go_up () -> Some Types.U
    | _ ->
      (match () with
       | _ when Utils.is_go_down () -> Some Types.D
       | _ when Utils.is_go_left () -> Some Types.L
       | _ when Utils.is_go_right () -> Some Types.R
       | _ when Utils.is_go_up () -> Some Types.U
       | _ -> None)
  in
  match next_dir with
  | Some dir ->
    let dx = get_axis_press Utils.is_go_right Utils.is_go_left in
    let dy = get_axis_press Utils.is_go_down Utils.is_go_up in
    let x = Vector2.x state.pos +. (dx *. Constants.sprite_step) in
    let y = Vector2.y state.pos +. (dy *. Constants.sprite_step) in
    let next_step =
      if dir = state.dir then (state.step + 1) mod (state.speed * 4) else state.step
    in
    let next_pos = Vector2.create x y in
    { state with pos = next_pos; dir; step = next_step }
  | None -> state
;;

let setup () : unit =
  Raylib.init_window Constants.window_width Constants.window_height "Fun";
  Raylib.set_target_fps Constants.target_fps
;;

let rec loop (state : Types.state_main_t) : unit =
  let update_state (state : Types.state_main_t) : Types.state_main_t =
    { player = { base = update_state_entity state.player.base; team = state.player.team }
    }
  in
  if Raylib.window_should_close ()
  then Raylib.close_window ()
  else (
    Raylib.begin_drawing ();
    Raylib.clear_background Color.raywhite;
    let random_pokemon = Generator.create_pokemon_random_at () in
    Renderer.draw_entity random_pokemon;
    Renderer.draw_entity state.player.base;
    Raylib.end_drawing ();
    update_state state |> loop)
;;

let () = setup () |> load_state |> loop
