exception UnmatchedString of string;;

let file_1 = "../logs/1epahttp.txt";;
let file_2_1 = "../logs/2sdschttp.txt";;
let file_2_2 = "../logs/2sdschttpter.txt";;
let file_3 = "../logs/3Calgaryaccess_log.txt";;

let first_word separator string =
  (String.sub string 0 (String.index string separator))
;;

let enum_1 = LogEnum.make file_1 (first_word ' ');;
(* let enum_2 = Enum.concat (LogEnum.make file_2_1 (first_word ':')) (LogEnum.make file_2_2 (first_word ':'));; *)
let enum_2 = LogEnum.make file_2_2 (first_word ':');;
let enum_3 = LogEnum.make file_3 (first_word ' ');;
