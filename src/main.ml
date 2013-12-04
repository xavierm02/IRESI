open Logs;;
open Counter;;

let (|>) x f = f x;;

let k = 10;;

let string_of_array string_of_element array =
  (Array.fold_left
    (fun acc element -> acc ^ "  " ^ (string_of_element element) ^ "\n")
    "{\n"
    array
  ) ^ "}\n"
;;

let id x = x;;

MisraGries.misra_gries k enum_1 |> string_of_array id |> print_string;;
Count.count k enum_1 |> string_of_array id |> print_string;;
print_newline ();;

MisraGries.misra_gries k enum_2 |> string_of_array id |> print_string;;
Count.count k enum_2 |> string_of_array id |> print_string;;
print_newline ();;

MisraGries.misra_gries k enum_3 |> string_of_array id |> print_string;;
Count.count k enum_3 |> string_of_array id |> print_string;;
