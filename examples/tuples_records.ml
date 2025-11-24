(* Tuples and Records in OCaml *)

(* ===== TUPLES ===== *)

(* Creating tuples *)
let pair = (42, "hello")
let triple = (1, 2.5, "three")
let point = (3.0, 4.0)

(* Accessing tuple elements *)
let get_first (x, _) = x
let get_second (_, y) = y

let distance (x, y) =
  sqrt (x *. x +. y *. y)

(* Returning multiple values *)
let div_mod x y =
  (x / y, x mod y)

let tuple_examples () =
  print_endline "=== Tuples ===";
  
  let (x, y) = point in
  Printf.printf "point = (%.1f, %.1f)\n" x y;
  Printf.printf "distance from origin = %.2f\n" (distance point);
  
  let p1 = (1, 2) in
  Printf.printf "first: %d, second: %d\n" (fst p1) (snd p1);
  
  let quotient, remainder = div_mod 17 5 in
  Printf.printf "17 / 5 = %d remainder %d\n" quotient remainder

(* ===== RECORDS ===== *)

(* Define record types *)
type point_2d = {
  x : float;
  y : float;
}

type person = {
  name : string;
  age : int;
  email : string;
}

type rectangle = {
  top_left : point_2d;
  width : float;
  height : float;
}

(* Creating records *)
let origin = { x = 0.0; y = 0.0 }

let alice = {
  name = "Alice";
  age = 30;
  email = "alice@example.com";
}

(* Accessing record fields *)
let get_x_coord point = point.x
let get_y_coord point = point.y

let is_adult person = person.age >= 18

(* Pattern matching on records *)
let is_origin_point point =
  match point with
  | { x = 0.0; y = 0.0 } -> true
  | _ -> false

let distance_between p1 p2 =
  let dx = p2.x -. p1.x in
  let dy = p2.y -. p1.y in
  sqrt (dx *. dx +. dy *. dy)

(* Functional update *)
let translate_x point dx =
  { point with x = point.x +. dx }

let translate point dx dy =
  { point with x = point.x +. dx; y = point.y +. dy }

let birthday person =
  { person with age = person.age + 1 }

(* Mutable fields *)
type counter = {
  mutable count : int;
}

let make_counter () = { count = 0 }

let increment counter =
  counter.count <- counter.count + 1

let get_count counter = counter.count

(* Record examples *)
let record_examples () =
  print_endline "\n=== Records ===";
  
  Printf.printf "origin = (%.1f, %.1f)\n" origin.x origin.y;
  
  let p1 = { x = 3.0; y = 4.0 } in
  let p2 = { x = 0.0; y = 0.0 } in
  Printf.printf "distance from (3, 4) to origin = %.2f\n"
    (distance_between p1 p2);
  
  print_endline "\n=== Person Records ===";
  Printf.printf "%s is %d years old\n" alice.name alice.age;
  Printf.printf "%s is an adult: %b\n" alice.name (is_adult alice);
  
  let older_alice = birthday alice in
  Printf.printf "After birthday: %s is %d years old\n"
    older_alice.name older_alice.age;
  
  print_endline "\n=== Functional Update ===";
  let p = { x = 1.0; y = 2.0 } in
  let moved = translate p 3.0 4.0 in
  Printf.printf "original: (%.1f, %.1f)\n" p.x p.y;
  Printf.printf "translated: (%.1f, %.1f)\n" moved.x moved.y;
  
  print_endline "\n=== Mutable Fields ===";
  let counter = make_counter () in
  Printf.printf "initial count: %d\n" (get_count counter);
  increment counter;
  increment counter;
  increment counter;
  Printf.printf "after 3 increments: %d\n" (get_count counter)

(* Nested records *)
type address = {
  street : string;
  city : string;
  zip : string;
}

type employee = {
  name : string;
  age : int;
  address : address;
}

let nested_record_examples () =
  print_endline "\n=== Nested Records ===";
  
  let bob = {
    name = "Bob";
    age = 25;
    address = {
      street = "123 Main St";
      city = "Springfield";
      zip = "12345";
    };
  } in
  
  Printf.printf "%s lives in %s\n" bob.name bob.address.city;
  
  (* Update nested record *)
  let moved_bob = {
    bob with address = { bob.address with city = "New York" }
  } in
  Printf.printf "After moving: %s lives in %s\n"
    moved_bob.name moved_bob.address.city

(* Working with lists of records *)
let list_of_records_examples () =
  print_endline "\n=== Lists of Records ===";
  
  let people = [
    { name = "Alice"; age = 30; email = "alice@example.com" };
    { name = "Bob"; age = 25; email = "bob@example.com" };
    { name = "Charlie"; age = 35; email = "charlie@example.com" };
    { name = "Diana"; age = 17; email = "diana@example.com" };
  ] in
  
  (* Filter adults *)
  let adults = List.filter is_adult people in
  Printf.printf "Number of adults: %d\n" (List.length adults);
  
  (* Calculate average age *)
  let total_age = List.fold_left (fun acc p -> acc + p.age) 0 people in
  let avg_age = float_of_int total_age /. float_of_int (List.length people) in
  Printf.printf "Average age: %.1f\n" avg_age;
  
  (* Print all names *)
  print_endline "Names:";
  List.iter (fun p -> Printf.printf "  - %s\n" p.name) people

(* Comparison example: tuple vs record *)
let comparison_example () =
  print_endline "\n=== Tuple vs Record ===";
  
  (* With tuple *)
  let point_tuple = (3.0, 4.0) in
  let (x_t, y_t) = point_tuple in
  Printf.printf "Tuple: x=%.1f, y=%.1f\n" x_t y_t;
  
  (* With record *)
  let point_record = { x = 3.0; y = 4.0 } in
  Printf.printf "Record: x=%.1f, y=%.1f\n" point_record.x point_record.y;
  
  print_endline "Records are more self-documenting!"

let () =
  tuple_examples ();
  record_examples ();
  nested_record_examples ();
  list_of_records_examples ();
  comparison_example ()
