exception Found of int;;

let first_index predicate array =
  try
    for i=0 to (Array.length array)-1 do
      if predicate array.(i) then
        raise (Found i)
      else ()
    done;
    None
  with
    | Found i ->
      Some i
;;
