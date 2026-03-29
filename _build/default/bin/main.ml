open Raylib
open Fun

let load_state () : Types.state_main_t =
  ({ player =
       { base =
           { sprite = Raylib.load_texture "assets/sprites/001.png"
           ; pos = Vector2.create 0.0 0.0
           ; dir = D
           }
       ; team = { states = [] }
       }
   }
   : Types.state_main_t)
;;

let setup () : unit =
  Raylib.init_window Constants.window_width Constants.window_height "Fun";
  Raylib.set_target_fps Constants.target_fps
;;

let rec loop (state : Types.state_main_t) : unit =
  let update_state (state : Types.state_main_t) : Types.state_main_t =
    { player =
        { state.player with
          base = { state.player.base with pos = Vector2.create 0.0 0.0 }
        }
    }
  in
  if Raylib.window_should_close ()
  then Raylib.close_window ()
  else (
    Raylib.begin_drawing ();
    Raylib.clear_background Color.raywhite;
    Renderer.draw_entity state.player.base;
    Raylib.end_drawing ();
    update_state state |> loop)
;;

let () = setup () |> load_state |> loop
