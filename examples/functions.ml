(* Functions in OCaml *)

(* Basic function definition *)
let square x = x * x

let add x y = x + y

let greet name = "Hello, " ^ name ^ "!"

(* Functions with type annotations *)
let multiply (x : int) (y : int) : int = x * y

(* Anonymous functions *)
let anonymous_examples () =
  let f = fun x -> x * x in
  Printf.printf "square of 5: %d\n" (f 5);
  
  (* Inline anonymous function *)
  let result = (fun x -> x + 10) 5 in
  Printf.printf "5 + 10 = %d\n" result

(* Recursive functions *)
let rec factorial n =
  if n <= 1 then 1
  else n * factorial (n - 1)

let rec fibonacci n =
  if n <= 1 then n
  else fibonacci (n - 1) + fibonacci (n - 2)

(* Tail recursive factorial *)
let factorial_tail n =
  let rec helper acc n =
    if n <= 1 then acc
    else helper (acc * n) (n - 1)
  in
  helper 1 n

(* Conditional expressions *)
let max x y =
  if x > y then x else y

let sign x =
  if x > 0 then "positive"
  else if x < 0 then "negative"
  else "zero"

(* Higher-order functions *)
let apply_twice f x = f (f x)

let compose f g x = f (g x)

(* Partial application *)
let add_five = add 5

let multiply_by_ten = multiply 10

(* Map implementation *)
let rec map f lst =
  match lst with
  | [] -> []
  | head :: tail -> f head :: map f tail

(* Filter implementation *)
let rec filter predicate lst =
  match lst with
  | [] -> []
  | head :: tail ->
      if predicate head then
        head :: filter predicate tail
      else
        filter predicate tail

(* Reduce/fold implementation *)
let rec fold_left f acc lst =
  match lst with
  | [] -> acc
  | head :: tail -> fold_left f (f acc head) tail

(* Examples *)
let function_examples () =
  Printf.printf "square 5 = %d\n" (square 5);
  Printf.printf "add 3 7 = %d\n" (add 3 7);
  Printf.printf "greet \"OCaml\" = %s\n" (greet "OCaml");
  Printf.printf "multiply 4 5 = %d\n" (multiply 4 5);
  
  print_endline "\n=== Recursive Functions ===";
  Printf.printf "factorial 5 = %d\n" (factorial 5);
  Printf.printf "factorial_tail 5 = %d\n" (factorial_tail 5);
  Printf.printf "fibonacci 7 = %d\n" (fibonacci 7);
  
  print_endline "\n=== Conditionals ===";
  Printf.printf "max 5 3 = %d\n" (max 5 3);
  Printf.printf "sign 5 = %s\n" (sign 5);
  Printf.printf "sign (-5) = %s\n" (sign (-5));
  Printf.printf "sign 0 = %s\n" (sign 0);
  
  print_endline "\n=== Higher-Order Functions ===";
  Printf.printf "apply_twice (fun x -> x + 1) 5 = %d\n"
    (apply_twice (fun x -> x + 1) 5);
  
  let add_one x = x + 1 in
  let double x = x * 2 in
  Printf.printf "compose double add_one 5 = %d\n"
    (compose double add_one 5);
  
  print_endline "\n=== Partial Application ===";
  Printf.printf "add_five 10 = %d\n" (add_five 10);
  Printf.printf "multiply_by_ten 7 = %d\n" (multiply_by_ten 7);
  
  print_endline "\n=== List Operations ===";
  let nums = [1; 2; 3; 4; 5] in
  let doubled = map (fun x -> x * 2) nums in
  Printf.printf "doubled: [%s]\n"
    (String.concat "; " (List.map string_of_int doubled));
  
  let evens = filter (fun x -> x mod 2 = 0) nums in
  Printf.printf "evens: [%s]\n"
    (String.concat "; " (List.map string_of_int evens));
  
  let sum = fold_left (+) 0 nums in
  Printf.printf "sum: %d\n" sum

let () =
  function_examples ()
