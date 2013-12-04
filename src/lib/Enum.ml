type 'a enum =
  {
    reset: unit -> unit;
    next: unit -> 'a option
  }
;;

let empty =
  {
    reset = (fun () -> ());
    next = (fun () -> None)
  }
;;

let make reset next =
  {
    reset = reset;
    next = next
  }
;;

let reset enum =
  enum.reset ()
;;

let next enum =
  enum.next ()
;;

let concat enum1 enum2 =
  let next3 = fun () -> None in
  let next = ref next3 in
  let next2 = fun () ->
    let result = enum2.next () in
    match result with
      | Some _ -> result
      | None -> begin
        next := next3;
        (!next) ()
      end
  in
  let next1 = fun () ->
    let result = enum1.next () in
    match result with
      | Some _ -> result
      | None -> begin
        next := next2;
        (!next) ()
      end
  in
  next := next1;
  {
    reset = (fun () ->
      next := next1;
      enum1.reset ();
      enum2.reset ()
    );
    next = (fun () -> (!next) ())
  }
;;

let iter f enum =
  let rec aux () =
    match enum.next () with
      | Some x -> begin
        f x;
        aux ()
      end
      | None -> ()
  in
  aux ()
;;

let get_remaining_length_and_reset enum =
  let length = ref 0 in
  iter (fun _ -> incr length) enum;
  reset enum;
  !length
;;
