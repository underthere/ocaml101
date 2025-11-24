(* Hello World in OCaml *)

let () = print_endline "Hello, World!"

(* Alternative ways to print *)

let hello_with_print_string () =
  print_string "Hello, World!\n"

let hello_with_printf () =
  Printf.printf "Hello, %s!\n" "World"

(* Multiple prints *)
let greet_multiple () =
  print_endline "Hello, World!";
  print_endline "Welcome to OCaml!";
  print_endline "Let's learn functional programming!"

(* Main execution *)
let () =
  hello_with_print_string ();
  hello_with_printf ();
  greet_multiple ()
