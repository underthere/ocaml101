(* Basic OCaml Syntax Examples *)

(* Integer operations *)
let int_examples () =
  let x = 42 in
  let y = 10 in
  Printf.printf "x = %d, y = %d\n" x y;
  Printf.printf "x + y = %d\n" (x + y);
  Printf.printf "x - y = %d\n" (x - y);
  Printf.printf "x * y = %d\n" (x * y);
  Printf.printf "x / y = %d\n" (x / y);
  Printf.printf "x mod y = %d\n" (x mod y)

(* Float operations *)
let float_examples () =
  let pi = 3.14159 in
  let radius = 5.0 in
  Printf.printf "pi = %.5f, radius = %.1f\n" pi radius;
  Printf.printf "area = %.2f\n" (pi *. radius *. radius);
  Printf.printf "circumference = %.2f\n" (2.0 *. pi *. radius)

(* String operations *)
let string_examples () =
  let greeting = "Hello" in
  let name = "OCaml" in
  let message = greeting ^ " " ^ name ^ "!" in
  Printf.printf "%s\n" message;
  Printf.printf "Length of message: %d\n" (String.length message);
  Printf.printf "Uppercase: %s\n" (String.uppercase_ascii message);
  Printf.printf "Lowercase: %s\n" (String.lowercase_ascii message)

(* Boolean operations *)
let boolean_examples () =
  let is_true = true in
  let is_false = false in
  Printf.printf "true AND false = %b\n" (is_true && is_false);
  Printf.printf "true OR false = %b\n" (is_true || is_false);
  Printf.printf "NOT false = %b\n" (not is_false);
  Printf.printf "5 > 3 = %b\n" (5 > 3);
  Printf.printf "5 = 5 = %b\n" (5 = 5);
  Printf.printf "5 <> 3 = %b\n" (5 <> 3)

(* Type annotations *)
let typed_examples () =
  let x : int = 42 in
  let name : string = "OCaml" in
  let pi : float = 3.14159 in
  Printf.printf "int: %d, string: %s, float: %.5f\n" x name pi

(* Let bindings *)
let let_binding_examples () =
  let x = 5 in
  let y = 10 in
  let sum = x + y in
  Printf.printf "sum = %d\n" sum;
  
  (* Nested let bindings *)
  let result =
    let a = 2 in
    let b = 3 in
    a * b
  in
  Printf.printf "result = %d\n" result

(* Main execution *)
let () =
  print_endline "=== Integer Examples ===";
  int_examples ();
  print_endline "\n=== Float Examples ===";
  float_examples ();
  print_endline "\n=== String Examples ===";
  string_examples ();
  print_endline "\n=== Boolean Examples ===";
  boolean_examples ();
  print_endline "\n=== Type Annotations ===";
  typed_examples ();
  print_endline "\n=== Let Bindings ===";
  let_binding_examples ()
