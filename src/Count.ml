(* ici, tu fais les calcules "en vrai". Oublis pas de reset l'enum avant de commencer a la lire *)

type non_empty_counter = {
  key: string;
  mutable value: int
};;

let make key value = {
  key = key;
  value = value
};;

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

let init () =
  ref []
;;

exception Done;;

let read counters host =
  try
    List.iter (fun counter ->
      if counter.key = host then begin
        counter.value <- counter.value + 1;
        raise Done
      end else ()
    ) !counters;
    counters := (make host 1) :: !counters
  with
    | Done -> ()
;;

let read_all counters host_enum =
  Enum.reset host_enum;
  Enum.iter (read counters) host_enum
;;

let count k host_enum =
  let counters = init () in
  read_all counters host_enum;
  let counters_array = Array.of_list !counters in
  Array.sort compare counters_array;
  Array.sub counters_array 0 (min k (Array.length counters_array))
;;
