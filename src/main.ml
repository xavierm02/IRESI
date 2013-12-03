open Logs;;
open Counter;;

let (|>) x f = f x;;

let k = 10;;

MisraGries.misra_gries k enum_1 |> string_of_counters |> print_string;;
Count.count k enum_1 |> string_of_counters |> print_string;;

MisraGries.misra_gries k enum_2 |> string_of_counters |> print_string;;
Count.count k enum_2 |> string_of_counters |> print_string;;

MisraGries.misra_gries k enum_3 |> string_of_counters |> print_string;;
Count.count k enum_3 |> string_of_counters |> print_string;;
