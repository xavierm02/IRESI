type compteur = Empty | Compte of compte and compte = {clef: int; valeur: int};;
exc

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
							end	) 		
		|_ -> ()
;;	


let cl = [Empty;Empty;Empty];;
let f = [10;20;10;20;30;10;40];;
print (misraGries f cl);;
