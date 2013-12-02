open ArrayMethods;;

type ('a, 'b) non_empty_counter = {
  key: 'a;
  value: 'b
};;

type ('a, 'b) counter =
  | Empty
  | Value of ('a, 'b) non_empty_counter
;;

let make key value =
  Value ({
    key = key;
    value = value
  })
;;

let init k =
  Array.make k Empty
;;

let read counters host =
  let index = ArrayMethods.first_index
    (fun counter -> match counter with
      | Value c -> c.key = host
      | Empty -> true
    )
    counters
  in
  match index with
    | Some i -> begin
      match counters.(i) with
        | Value c -> incr c.value
        | Empty -> counters.(i) <- make host (ref 1)
    end
    | None -> begin
      ignore (ArrayMethods.first_index
        (fun counter -> match counter with
          | Value c -> begin
            decr c.value;
            false
          end
          | Empty -> true
        )
        counters
      )
    end
;;
(*








let drec_compteur c =
  match c with
    |Compte c0 -> (if (c0.valeur = 1) then Empty else Compte{clef = c0.clef; valeur = c0.valeur -1})
    |_ -> Empty
;;

let rec decrAll cl =
  match cl with
    |t::q ->  (drec_compteur t) :: (decrAll q)
    | _ -> cl
;;

let rec add cl k =
(* to do : gérer le cas où il faut renvoyer decrAll *)
    match cl with
      |t::q ->
        (match t with
          |Compte c -> if c.clef = k then Compte {clef = k; valeur = c.valeur + 1} :: q else t :: add q k
          |Empty -> Compte {clef=k;valeur=1} :: q)
      |_ -> cl
;;

let rec misraGries f cl =
  match f with
    |t::q -> misraGries q (add cl t)
    |_ -> cl
;;

let rec print cl =
  match cl with
    |t::q ->
      (match t with
        |Compte c -> begin
                print_int c.clef;
                print_string " ; ";
                print_int c.valeur;
                print_newline();
                print q;
              end
        |Empty -> begin
                print_string "Empty";
                print_newline();
                print q;
              end )
    |_ -> ()
;;


let cl = [Empty;Empty;Empty];;
let f = [10;20;10;20;30;10;40];;
print (misraGries f cl);;
*)
