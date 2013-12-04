open Counter;;

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
    counters := ({key = host; value = 1}) :: !counters
  with
    | Done -> ()
;;

let read_all counters host_enum =
  Enum.reset host_enum;
  Enum.iter (read counters) host_enum
;;

let count_all host_enum =
  let counters = init () in
  read_all counters host_enum;
  let counters_array = Array.of_list !counters in
  Array.sort compare counters_array;
  Array.map (fun counter -> counter.key) counters_array
;;

let first_k k array =
  Array.sub array 0 (min k (Array.length array))
;;

let count k host_enum =
  first_k k (count_all host_enum)
;;
