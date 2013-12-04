module StringSet = Set.Make(String);;

include StringSet;;

let set_of_array array =
  let set = ref StringSet.empty in
  Array.iter (fun string ->
    set := StringSet.add string !set
  ) array;
  !set
;;

let intersection array_1 array_2 =
  StringSet.inter (set_of_array array_1) (set_of_array array_2)
;;

let intersection_size array_1 array_2 =
  StringSet.cardinal (intersection array_1 array_2)
;;
