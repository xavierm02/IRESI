type non_empty_counter = {
  key: string;
  mutable value: int
};;

type counter =
  | Empty
  | Value of non_empty_counter
;;

let compare counter1 counter2 =
  counter2.value - counter1.value
;;

let string_of_counter counter =
  counter.key ^ " -> " ^ (string_of_int counter.value)
;;

let string_of_counters counters =
  (Array.fold_left
    (fun acc counter -> acc ^ "  " ^ (string_of_counter counter) ^ "\n")
    "[\n"
    counters
  ) ^ "]\n"
;;
