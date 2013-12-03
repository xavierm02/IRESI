open Counter;;

let init k =
  Array.make k Empty
;;

exception Done;;

let read counters host =
  let increment_host_counter counters host =
    Array.iter
      (fun counter -> match counter with
        | Value c ->
          if c.key = host then begin
            c.value <- c.value + 1;
            raise Done
          end else ()
        | Empty -> ()
      )
      counters
  in
  let increment_empty_counter counters host =
    Array.iteri
      (fun index counter -> match counter with
        | Value c -> ()
        | Empty -> begin
          counters.(index) <- Value {key = host; value = 1};
          raise Done
        end
      )
      counters
  in
  let decrement_all_counters counters =
    Array.iteri
      (fun index counter -> match counter with
        | Value c ->
          if c.value > 1 then
            c.value <- c.value - 1
          else
            counters.(index) <- Empty
        | Empty -> ()
      )
      counters
  in
  try
    increment_host_counter counters host;
    increment_empty_counter counters host;
    decrement_all_counters counters
  with
    | Done -> ()
;;

let read_all counters host_enum =
  Enum.reset host_enum;
  Enum.iter (read counters) host_enum
;;

let (|>) x f = f x;;

let misra_gries k host_enum =
  let counters = init k in
  read_all counters host_enum;
  let non_empty_counters_list = ref [] in
  Array.iter (fun counter ->
    match counter with
      | Value c -> non_empty_counters_list := c :: !non_empty_counters_list
      | Empty -> ()
  ) counters;
  let non_empty_counters_array = Array.of_list !non_empty_counters_list in
  Array.sort compare non_empty_counters_array;
  non_empty_counters_array
;;
