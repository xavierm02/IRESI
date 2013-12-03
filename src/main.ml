open Logs;;
open MisraGries;;

let (|>) x f = f x;;

let k = 10;;

misra_gries k enum_1 |> string_of_counters |> print_string;;
