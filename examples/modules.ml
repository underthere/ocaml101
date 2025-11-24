(* Modules in OCaml *)

(* Simple module definition *)
module Math = struct
  let pi = 3.14159
  let e = 2.71828
  
  let square x = x * x
  let cube x = x * x * x
  
  let circle_area radius = pi *. radius *. radius
  let circle_circumference radius = 2.0 *. pi *. radius
end

(* Module with types *)
module Point = struct
  type t = { x : float; y : float }
  
  let make x y = { x; y }
  let origin = { x = 0.0; y = 0.0 }
  
  let distance p1 p2 =
    let dx = p2.x -. p1.x in
    let dy = p2.y -. p1.y in
    sqrt (dx *. dx +. dy *. dy)
  
  let translate point dx dy =
    { x = point.x +. dx; y = point.y +. dy }
  
  let to_string point =
    Printf.sprintf "(%.2f, %.2f)" point.x point.y
end

(* Module with abstract type *)
module Counter : sig
  type t
  val make : unit -> t
  val increment : t -> unit
  val decrement : t -> unit
  val get : t -> int
  val reset : t -> unit
end = struct
  type t = { mutable value : int }
  
  let make () = { value = 0 }
  let increment counter = counter.value <- counter.value + 1
  let decrement counter = counter.value <- counter.value - 1
  let get counter = counter.value
  let reset counter = counter.value <- 0
end

(* Stack module with interface *)
module type STACK = sig
  type 'a t
  val empty : 'a t
  val is_empty : 'a t -> bool
  val push : 'a -> 'a t -> 'a t
  val pop : 'a t -> ('a * 'a t) option
  val peek : 'a t -> 'a option
end

module Stack : STACK = struct
  type 'a t = 'a list
  
  let empty = []
  let is_empty stack = (stack = [])
  let push x stack = x :: stack
  let pop = function
    | [] -> None
    | h :: t -> Some (h, t)
  let peek = function
    | [] -> None
    | h :: _ -> Some h
end

(* Nested modules *)
module Geometry = struct
  module Point = struct
    type t = { x : float; y : float }
    let make x y = { x; y }
    let origin = { x = 0.0; y = 0.0 }
  end
  
  module Circle = struct
    type t = { center : Point.t; radius : float }
    let make center radius = { center; radius }
    let area circle = 3.14159 *. circle.radius *. circle.radius
  end
  
  module Rectangle = struct
    type t = { top_left : Point.t; width : float; height : float }
    let make top_left width height = { top_left; width; height }
    let area rect = rect.width *. rect.height
  end
end

(* Including other modules *)
module ExtendedList = struct
  include List
  
  let is_empty = function
    | [] -> true
    | _ -> false
  
  let sum lst = fold_left (+) 0 lst
  let product lst = fold_left ( * ) 1 lst
end

(* Examples *)
let module_examples () =
  print_endline "=== Math Module ===";
  Printf.printf "pi = %.5f\n" Math.pi;
  Printf.printf "square 5 = %d\n" (Math.square 5);
  Printf.printf "circle area (r=3) = %.2f\n" (Math.circle_area 3.0);
  
  print_endline "\n=== Point Module ===";
  let p1 = Point.make 3.0 4.0 in
  let p2 = Point.origin in
  Printf.printf "p1 = %s\n" (Point.to_string p1);
  Printf.printf "p2 = %s\n" (Point.to_string p2);
  Printf.printf "distance = %.2f\n" (Point.distance p1 p2);
  
  let p3 = Point.translate p1 1.0 (-1.0) in
  Printf.printf "p3 (translated) = %s\n" (Point.to_string p3);
  
  print_endline "\n=== Counter Module (Abstract Type) ===";
  let counter = Counter.make () in
  Printf.printf "initial: %d\n" (Counter.get counter);
  Counter.increment counter;
  Counter.increment counter;
  Counter.increment counter;
  Printf.printf "after 3 increments: %d\n" (Counter.get counter);
  Counter.decrement counter;
  Printf.printf "after 1 decrement: %d\n" (Counter.get counter);
  Counter.reset counter;
  Printf.printf "after reset: %d\n" (Counter.get counter);
  
  print_endline "\n=== Stack Module ===";
  let s = Stack.empty in
  let s = Stack.push 1 s in
  let s = Stack.push 2 s in
  let s = Stack.push 3 s in
  
  (match Stack.peek s with
   | Some x -> Printf.printf "peek: %d\n" x
   | None -> print_endline "empty stack");
  
  let rec print_stack stack =
    match Stack.pop stack with
    | None -> ()
    | Some (x, rest) ->
        Printf.printf "popped: %d\n" x;
        print_stack rest
  in
  print_stack s;
  
  print_endline "\n=== Nested Modules ===";
  let center = Geometry.Point.make 0.0 0.0 in
  let circle = Geometry.Circle.make center 5.0 in
  Printf.printf "circle area = %.2f\n" (Geometry.Circle.area circle);
  
  let top_left = Geometry.Point.make 0.0 0.0 in
  let rect = Geometry.Rectangle.make top_left 4.0 5.0 in
  Printf.printf "rectangle area = %.2f\n" (Geometry.Rectangle.area rect);
  
  print_endline "\n=== Extended List Module ===";
  let nums = [1; 2; 3; 4; 5] in
  Printf.printf "is_empty: %b\n" (ExtendedList.is_empty nums);
  Printf.printf "sum: %d\n" (ExtendedList.sum nums);
  Printf.printf "product: %d\n" (ExtendedList.product nums);
  
  (* Can still use all List functions *)
  let doubled = ExtendedList.map (fun x -> x * 2) nums in
  Printf.printf "doubled: [%s]\n"
    (String.concat "; " (List.map string_of_int doubled))

(* Using local open *)
let local_open_example () =
  print_endline "\n=== Local Open ===";
  
  (* Without open *)
  let p1 = Point.make 1.0 2.0 in
  
  (* With local open (let open) *)
  let p2 =
    let open Point in
    make 3.0 4.0
  in
  
  (* With local open (syntax) *)
  let p3 = Point.(make 5.0 6.0) in
  
  Printf.printf "p1 = %s\n" (Point.to_string p1);
  Printf.printf "p2 = %s\n" (Point.to_string p2);
  Printf.printf "p3 = %s\n" (Point.to_string p3)

let () =
  module_examples ();
  local_open_example ()
