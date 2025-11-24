(* Pattern Matching in OCaml *)

(* Basic pattern matching *)
let describe_number n =
  match n with
  | 0 -> "zero"
  | 1 -> "one"
  | 2 -> "two"
  | 3 -> "three"
  | _ -> "many"

(* Pattern matching with guards *)
let classify_number n =
  match n with
  | n when n < 0 -> "negative"
  | 0 -> "zero"
  | n when n > 0 && n < 10 -> "small positive"
  | _ -> "large positive"

(* List pattern matching *)
let rec sum_list lst =
  match lst with
  | [] -> 0
  | head :: tail -> head + sum_list tail

let rec length lst =
  match lst with
  | [] -> 0
  | _ :: tail -> 1 + length tail

let first lst =
  match lst with
  | [] -> None
  | head :: _ -> Some head

let second lst =
  match lst with
  | _ :: x :: _ -> Some x
  | _ -> None

(* Multiple element patterns *)
let has_two_elements lst =
  match lst with
  | [_; _] -> true
  | _ -> false

let has_at_least_two lst =
  match lst with
  | _ :: _ :: _ -> true
  | _ -> false

(* Tuple pattern matching *)
let is_origin point =
  match point with
  | (0, 0) -> true
  | _ -> false

let get_x (x, _) = x
let get_y (_, y) = y

let add_points (x1, y1) (x2, y2) =
  (x1 + x2, y1 + y2)

(* Option pattern matching *)
let get_or_default opt default =
  match opt with
  | Some value -> value
  | None -> default

let map_option f opt =
  match opt with
  | Some x -> Some (f x)
  | None -> None

(* Nested pattern matching *)
let rec find_first_some lst =
  match lst with
  | [] -> None
  | Some x :: _ -> Some x
  | None :: rest -> find_first_some rest

(* The function keyword *)
let rec list_sum = function
  | [] -> 0
  | h :: t -> h + list_sum t

let rec contains x = function
  | [] -> false
  | h :: t -> h = x || contains x t

(* Pattern matching with records *)
type point = { x : float; y : float }

let is_origin_record point =
  match point with
  | { x = 0.0; y = 0.0 } -> true
  | _ -> false

let distance_from_origin { x; y } =
  sqrt (x *. x +. y *. y)

(* Variant types *)
type color = Red | Green | Blue | RGB of int * int * int

let color_to_string color =
  match color with
  | Red -> "red"
  | Green -> "green"
  | Blue -> "blue"
  | RGB (r, g, b) -> Printf.sprintf "rgb(%d,%d,%d)" r g b

type shape =
  | Circle of float
  | Rectangle of float * float
  | Triangle of float * float * float

let area shape =
  match shape with
  | Circle radius -> 3.14159 *. radius *. radius
  | Rectangle (width, height) -> width *. height
  | Triangle (a, b, c) ->
      let s = (a +. b +. c) /. 2.0 in
      sqrt (s *. (s -. a) *. (s -. b) *. (s -. c))

(* Recursive data structures *)
type 'a tree =
  | Empty
  | Node of 'a * 'a tree * 'a tree

let rec tree_sum tree =
  match tree with
  | Empty -> 0
  | Node (value, left, right) ->
      value + tree_sum left + tree_sum right

let rec tree_height tree =
  match tree with
  | Empty -> 0
  | Node (_, left, right) ->
      1 + max (tree_height left) (tree_height right)

(* Examples *)
let pattern_matching_examples () =
  print_endline "=== Basic Pattern Matching ===";
  Printf.printf "describe_number 0 = %s\n" (describe_number 0);
  Printf.printf "describe_number 5 = %s\n" (describe_number 5);
  
  print_endline "\n=== Pattern Matching with Guards ===";
  Printf.printf "classify_number (-5) = %s\n" (classify_number (-5));
  Printf.printf "classify_number 5 = %s\n" (classify_number 5);
  Printf.printf "classify_number 100 = %s\n" (classify_number 100);
  
  print_endline "\n=== List Pattern Matching ===";
  let nums = [1; 2; 3; 4; 5] in
  Printf.printf "sum_list [1;2;3;4;5] = %d\n" (sum_list nums);
  Printf.printf "length [1;2;3;4;5] = %d\n" (length nums);
  
  (match first nums with
   | Some x -> Printf.printf "first element = %d\n" x
   | None -> print_endline "empty list");
  
  (match second nums with
   | Some x -> Printf.printf "second element = %d\n" x
   | None -> print_endline "less than 2 elements");
  
  print_endline "\n=== Tuple Pattern Matching ===";
  let p1 = (3, 4) in
  Printf.printf "point (%d, %d): x = %d, y = %d\n"
    (get_x p1) (get_y p1) (get_x p1) (get_y p1);
  
  let p2 = (1, 2) in
  let (x, y) = add_points p1 p2 in
  Printf.printf "add_points (3,4) (1,2) = (%d, %d)\n" x y;
  
  print_endline "\n=== Option Pattern Matching ===";
  Printf.printf "get_or_default (Some 42) 0 = %d\n"
    (get_or_default (Some 42) 0);
  Printf.printf "get_or_default None 0 = %d\n"
    (get_or_default None 0);
  
  print_endline "\n=== Variant Types ===";
  Printf.printf "Red = %s\n" (color_to_string Red);
  Printf.printf "RGB(255,0,0) = %s\n" (color_to_string (RGB (255, 0, 0)));
  
  let circle = Circle 5.0 in
  let rect = Rectangle (4.0, 5.0) in
  Printf.printf "area of circle (radius 5) = %.2f\n" (area circle);
  Printf.printf "area of rectangle (4x5) = %.2f\n" (area rect);
  
  print_endline "\n=== Tree Pattern Matching ===";
  let tree = Node (5,
                   Node (3, Empty, Empty),
                   Node (7, Empty, Empty)) in
  Printf.printf "tree_sum = %d\n" (tree_sum tree);
  Printf.printf "tree_height = %d\n" (tree_height tree)

let () =
  pattern_matching_examples ()
