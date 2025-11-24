(* Functors in OCaml *)

(* Define a module type for comparable elements *)
module type COMPARABLE = sig
  type t
  val compare : t -> t -> int
end

(* Functor that creates a Set module for any comparable type *)
module MakeSet (Elem : COMPARABLE) = struct
  type element = Elem.t
  type t = element list
  
  let empty = []
  
  let rec mem x = function
    | [] -> false
    | h :: t ->
        let c = Elem.compare x h in
        if c = 0 then true
        else if c < 0 then false
        else mem x t
  
  let rec add x set =
    match set with
    | [] -> [x]
    | h :: t ->
        let c = Elem.compare x h in
        if c = 0 then set
        else if c < 0 then x :: set
        else h :: add x t
  
  let to_list set = set
end

(* Create a module for comparing integers *)
module IntComparable = struct
  type t = int
  let compare = compare
end

(* Apply the functor to create IntSet *)
module IntSet = MakeSet(IntComparable)

(* Create a module for comparing strings *)
module StringComparable = struct
  type t = string
  let compare = compare
end

(* Apply the functor to create StringSet *)
module StringSet = MakeSet(StringComparable)

(* Example: Map functor from standard library *)
module IntMap = Map.Make(struct
  type t = int
  let compare = compare
end)

module StringMap = Map.Make(String)

(* Module type for showable values *)
module type SHOWABLE = sig
  type t
  val show : t -> string
end

(* Module type for ordered values *)
module type ORDERED = sig
  type t
  val compare : t -> t -> int
end

(* Functor for creating a priority queue *)
module MakePriorityQueue (Ord : ORDERED) = struct
  type element = Ord.t
  type t = element list
  
  let empty = []
  
  let rec insert x = function
    | [] -> [x]
    | h :: t as l ->
        if Ord.compare x h <= 0 then x :: l
        else h :: insert x t
  
  let extract_min = function
    | [] -> None
    | h :: t -> Some (h, t)
  
  let to_list pq = pq
end

(* Create integer priority queue *)
module IntPQ = MakePriorityQueue(struct
  type t = int
  let compare = compare
end)

(* Functor with multiple module parameters *)
module type SERIALIZABLE = sig
  type t
  val to_string : t -> string
  val from_string : string -> t option
end

module MakeCache
    (Key : COMPARABLE)
    (Value : SERIALIZABLE) = struct
  type key = Key.t
  type value = Value.t
  type t = (key * value) list
  
  let empty = []
  
  let rec get k cache =
    match cache with
    | [] -> None
    | (k', v) :: rest ->
        if Key.compare k k' = 0 then Some v
        else get k rest
  
  let set k v cache =
    (k, v) :: List.filter (fun (k', _) -> Key.compare k k' <> 0) cache
  
  let size cache = List.length cache
end

(* Example values for serialization *)
module IntSerializable = struct
  type t = int
  let to_string = string_of_int
  let from_string s =
    try Some (int_of_string s)
    with Failure _ -> None
end

(* Create a cache with string keys and int values *)
module StringIntCache = MakeCache(StringComparable)(IntSerializable)

(* Examples *)
let functor_examples () =
  print_endline "=== Set Functor ===";
  
  let s = IntSet.empty in
  let s = IntSet.add 5 s in
  let s = IntSet.add 3 s in
  let s = IntSet.add 7 s in
  let s = IntSet.add 3 s in  (* Duplicate, won't be added *)
  
  Printf.printf "IntSet contains 5: %b\n" (IntSet.mem 5 s);
  Printf.printf "IntSet contains 4: %b\n" (IntSet.mem 4 s);
  Printf.printf "IntSet: [%s]\n"
    (String.concat "; " (List.map string_of_int (IntSet.to_list s)));
  
  let str_set = StringSet.empty in
  let str_set = StringSet.add "hello" str_set in
  let str_set = StringSet.add "world" str_set in
  let str_set = StringSet.add "ocaml" str_set in
  
  Printf.printf "StringSet contains \"hello\": %b\n"
    (StringSet.mem "hello" str_set);
  Printf.printf "StringSet: [%s]\n"
    (String.concat "; " (StringSet.to_list str_set));
  
  print_endline "\n=== Map Functor (Standard Library) ===";
  
  let m = IntMap.empty in
  let m = IntMap.add 1 "one" m in
  let m = IntMap.add 2 "two" m in
  let m = IntMap.add 3 "three" m in
  
  (match IntMap.find_opt 2 m with
   | Some v -> Printf.printf "IntMap[2] = %s\n" v
   | None -> print_endline "Not found");
  
  let sm = StringMap.empty in
  let sm = StringMap.add "hello" 1 sm in
  let sm = StringMap.add "world" 2 sm in
  
  (match StringMap.find_opt "hello" sm with
   | Some v -> Printf.printf "StringMap[\"hello\"] = %d\n" v
   | None -> print_endline "Not found");
  
  print_endline "\n=== Priority Queue Functor ===";
  
  let pq = IntPQ.empty in
  let pq = IntPQ.insert 5 pq in
  let pq = IntPQ.insert 2 pq in
  let pq = IntPQ.insert 8 pq in
  let pq = IntPQ.insert 1 pq in
  
  Printf.printf "Priority Queue: [%s]\n"
    (String.concat "; " (List.map string_of_int (IntPQ.to_list pq)));
  
  let rec extract_all pq =
    match IntPQ.extract_min pq with
    | None -> []
    | Some (min, rest) -> min :: extract_all rest
  in
  
  Printf.printf "Extracted in order: [%s]\n"
    (String.concat "; " (List.map string_of_int (extract_all pq)));
  
  print_endline "\n=== Cache Functor (Multiple Parameters) ===";
  
  let cache = StringIntCache.empty in
  let cache = StringIntCache.set "answer" 42 cache in
  let cache = StringIntCache.set "count" 10 cache in
  let cache = StringIntCache.set "total" 100 cache in
  
  (match StringIntCache.get "answer" cache with
   | Some v -> Printf.printf "cache[\"answer\"] = %d\n" v
   | None -> print_endline "Not found");
  
  (match StringIntCache.get "missing" cache with
   | Some v -> Printf.printf "cache[\"missing\"] = %d\n" v
   | None -> print_endline "cache[\"missing\"] not found");
  
  Printf.printf "Cache size: %d\n" (StringIntCache.size cache)

let () =
  functor_examples ()
