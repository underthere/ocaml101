(* Working with Lists in OCaml *)

(* List creation *)
let empty = []
let numbers = [1; 2; 3; 4; 5]
let strings = ["hello"; "world"; "ocaml"]

(* Cons operator *)
let cons_example () =
  let lst = 1 :: 2 :: 3 :: [] in
  let with_zero = 0 :: lst in
  Printf.printf "lst = [%s]\n"
    (String.concat "; " (List.map string_of_int lst));
  Printf.printf "with_zero = [%s]\n"
    (String.concat "; " (List.map string_of_int with_zero))

(* List concatenation *)
let concat_example () =
  let left = [1; 2; 3] in
  let right = [4; 5; 6] in
  let combined = left @ right in
  Printf.printf "combined = [%s]\n"
    (String.concat "; " (List.map string_of_int combined))

(* Custom list functions *)
let rec length lst =
  match lst with
  | [] -> 0
  | _ :: tail -> 1 + length tail

let rec sum lst =
  match lst with
  | [] -> 0
  | head :: tail -> head + sum tail

let rec map f lst =
  match lst with
  | [] -> []
  | head :: tail -> f head :: map f tail

let rec filter predicate lst =
  match lst with
  | [] -> []
  | head :: tail ->
      if predicate head then
        head :: filter predicate tail
      else
        filter predicate tail

let rec fold_left f acc lst =
  match lst with
  | [] -> acc
  | head :: tail -> fold_left f (f acc head) tail

let rec fold_right f lst acc =
  match lst with
  | [] -> acc
  | head :: tail -> f head (fold_right f tail acc)

(* Reverse a list *)
let reverse lst =
  let rec helper acc = function
    | [] -> acc
    | h :: t -> helper (h :: acc) t
  in
  helper [] lst

(* Range function *)
let rec range start stop =
  if start >= stop then []
  else start :: range (start + 1) stop

(* Find element *)
let rec find predicate lst =
  match lst with
  | [] -> None
  | head :: tail ->
      if predicate head then Some head
      else find predicate tail

(* All and Any *)
let rec all predicate lst =
  match lst with
  | [] -> true
  | head :: tail -> predicate head && all predicate tail

let rec any predicate lst =
  match lst with
  | [] -> false
  | head :: tail -> predicate head || any predicate tail

(* Zip two lists *)
let rec zip lst1 lst2 =
  match lst1, lst2 with
  | [], _ | _, [] -> []
  | h1 :: t1, h2 :: t2 -> (h1, h2) :: zip t1 t2

(* Take n elements *)
let rec take n lst =
  match n, lst with
  | 0, _ | _, [] -> []
  | n, h :: t -> h :: take (n - 1) t

(* Drop n elements *)
let rec drop n lst =
  match n, lst with
  | 0, _ -> lst
  | _, [] -> []
  | n, _ :: t -> drop (n - 1) t

(* Examples *)
let list_examples () =
  print_endline "=== List Creation ===";
  Printf.printf "numbers = [%s]\n"
    (String.concat "; " (List.map string_of_int numbers));
  
  print_endline "\n=== Cons Operator ===";
  cons_example ();
  
  print_endline "\n=== Concatenation ===";
  concat_example ();
  
  print_endline "\n=== Custom Functions ===";
  Printf.printf "length [1;2;3;4;5] = %d\n" (length numbers);
  Printf.printf "sum [1;2;3;4;5] = %d\n" (sum numbers);
  
  let doubled = map (fun x -> x * 2) numbers in
  Printf.printf "doubled = [%s]\n"
    (String.concat "; " (List.map string_of_int doubled));
  
  let evens = filter (fun x -> x mod 2 = 0) numbers in
  Printf.printf "evens = [%s]\n"
    (String.concat "; " (List.map string_of_int evens));
  
  let product = fold_left ( * ) 1 [1; 2; 3; 4; 5] in
  Printf.printf "product = %d\n" product;
  
  print_endline "\n=== Reverse ===";
  let reversed = reverse numbers in
  Printf.printf "reversed = [%s]\n"
    (String.concat "; " (List.map string_of_int reversed));
  
  print_endline "\n=== Range ===";
  let r = range 1 11 in
  Printf.printf "range 1 11 = [%s]\n"
    (String.concat "; " (List.map string_of_int r));
  
  print_endline "\n=== Find ===";
  (match find (fun x -> x > 3) numbers with
   | Some x -> Printf.printf "first element > 3: %d\n" x
   | None -> print_endline "not found");
  
  print_endline "\n=== All and Any ===";
  Printf.printf "all positive: %b\n" (all (fun x -> x > 0) numbers);
  Printf.printf "any even: %b\n" (any (fun x -> x mod 2 = 0) numbers);
  
  print_endline "\n=== Zip ===";
  let lst1 = [1; 2; 3] in
  let lst2 = ["a"; "b"; "c"] in
  let zipped = zip lst1 lst2 in
  List.iter (fun (n, s) -> Printf.printf "(%d, %s) " n s) zipped;
  print_newline ();
  
  print_endline "\n=== Take and Drop ===";
  let taken = take 3 numbers in
  Printf.printf "take 3 = [%s]\n"
    (String.concat "; " (List.map string_of_int taken));
  let dropped = drop 3 numbers in
  Printf.printf "drop 3 = [%s]\n"
    (String.concat "; " (List.map string_of_int dropped));
  
  print_endline "\n=== Pipe Operator ===";
  let result =
    [1; 2; 3; 4; 5; 6; 7; 8; 9; 10]
    |> filter (fun x -> x mod 2 = 0)
    |> map (fun x -> x * x)
    |> fold_left (+) 0
  in
  Printf.printf "sum of squares of evens = %d\n" result

let () =
  list_examples ()
