type non_empty_counter = {
  key: string;
  mutable value: int
};;

type counter =
  | Empty
  | Value of non_empty_counter
;;

let make key value =
  Value ({
    key = key;
    value = value
  })
;;

let string_of_counter = function
  | Value c -> c.key ^ " -> " ^ (string_of_int c.value)
  | Empty -> "? -> 0"
;;

let string_of_counters counters =
  (Array.fold_left
    (fun acc counter -> acc ^ "  " ^ (string_of_counter counter) ^ "\n")
    "[\n"
    counters
  ) ^ "]\n"
;;

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
          counters.(index) <- make host 1;
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

let misra_gries k host_enum =
  let counters = init k in
  read_all counters host_enum;
  counters
;;
