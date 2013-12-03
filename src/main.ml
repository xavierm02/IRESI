open Logs;;

let (|>) x f = f x;;

let k = 5;;

MisraGries.misra_gries k enum_1 |> MisraGries.string_of_counters |> print_string;;
Count.count k enum_1 |> Count.string_of_counters |> print_string;;

MisraGries.misra_gries k enum_2 |> MisraGries.string_of_counters |> print_string;;
Count.count k enum_2 |> Count.string_of_counters |> print_string;;

MisraGries.misra_gries k enum_3 |> MisraGries.string_of_counters |> print_string;;
Count.count k enum_3 |> Count.string_of_counters |> print_string;;
