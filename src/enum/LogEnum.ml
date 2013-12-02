open Enum;;

let make filename parse_line =
  let channel = ref (open_in filename) in
  Enum.make (fun () ->
    channel := open_in filename
  ) (fun () ->
    try
      Some (parse_line (input_line !channel))
    with
      | _ ->
        None
  )
;;
