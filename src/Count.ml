(* ici, tu fais les calcules "en vrai". Oublis pas de reset l'enum avant de commencer a la lire *)

let hash_add hash x =
	if(Hashtbl.mem hash x) then 
		Hashtbl.replace hash x ((Hashtbl.find hash x) + 1) 
	else 
		Hashtbl.add hash x 1
;;

let enum_to_hash enum =
	let h = Hashtbl.create (10) in
	begin
		Enum.reset enum;
		Enum.iter (hash_add h) enum;
		h
	end
;;

let f k x vx =
	
;;

let hash_count h =
	Hashtbl.iter (f k) h
;;
