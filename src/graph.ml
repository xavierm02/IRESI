open Comparison;;
open Logs;;
open Counter;;

let enum = match Sys.argv.(1) with
  | "1" -> enum_1
  | "2" -> enum_2
  | "3" -> enum_3
  | _ -> failwith "Invalid argument given to graph.ml."
;;

let (|>) x f = f x;;

let fincr x =
  let i = ref 1 in
  while !i <= !x do
    i := !i * 10
  done;
  x := !x + (!i/10)
;;

let k = ref 1;;

let n = Enum.get_remaining_length_and_reset enum;;
let result_counter_global = Count.count_all enum;;
let m = Count.count n enum |> Array.length;;

print_string "#n = ";
print_int n;
print_newline ();
print_string "#m = ";
print_int m;
print_newline ();;

let k_max = min 10000 (2*m);;

while !k <= k_max do
  let result_mg = MisraGries.misra_gries !k enum in
  let result_counter = Count.first_k !k result_counter_global in
  let l = intersection_size result_mg result_counter in
  print_int !k;
  print_string " ";
  print_float ((float_of_int l) /. (float_of_int (min !k m)));
  print_newline ();
  fincr k
done;;

