# Day 4: Functors

**Date:** Day 4  
**Topic:** Functors - Parameterized Modules

## What I Learned Today

Functors are functions that take modules as arguments and return modules. They're like generics for modules.

## What is a Functor?

A functor is a module that is parameterized by another module. Think of it as a function at the module level.

## Simple Functor Example

```ocaml
(* Define a module type for things that can be compared *)
module type COMPARABLE = sig
  type t
  val compare : t -> t -> int
end;;

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
end;;
```

## Using the Functor

```ocaml
(* Create a module for comparing integers *)
module IntComparable = struct
  type t = int
  let compare = compare  (* Built-in compare *)
end;;

(* Apply the functor to create IntSet *)
module IntSet = MakeSet(IntComparable);;

let s = IntSet.empty;;
let s = IntSet.add 5 s;;
let s = IntSet.add 3 s;;
let s = IntSet.add 7 s;;
IntSet.mem 5 s;;  (* true *)
IntSet.mem 4 s;;  (* false *)
```

## Real-World Example: Map Functor

The standard library's Map module is a functor:

```ocaml
module StringMap = Map.Make(String);;

let m = StringMap.empty;;
let m = StringMap.add "hello" 1 m;;
let m = StringMap.add "world" 2 m;;
StringMap.find "hello" m;;  (* 1 *)
```

## Functor with Type Constraints

```ocaml
module type SHOWABLE = sig
  type t
  val show : t -> string
end;;

module type CONTAINER = sig
  type 'a t
  val map : ('a -> 'b) -> 'a t -> 'b t
  val to_list : 'a t -> 'a list
end;;

module ShowContainer
    (C : CONTAINER)
    (S : SHOWABLE) = struct
  let show_all container =
    C.to_list container
    |> List.map S.show
    |> String.concat ", "
end;;
```

## Multiple Module Parameters

```ocaml
module type SERIALIZABLE = sig
  type t
  val to_string : t -> string
  val from_string : string -> t option
end;;

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
end;;
```

## Functor Signatures

Define types for functors:

```ocaml
module type SET = sig
  type element
  type t
  val empty : t
  val add : element -> t -> t
  val mem : element -> t -> bool
end;;

module type MAKE_SET = functor (Elem : COMPARABLE) -> SET
  with type element = Elem.t;;
```

## Sharing Constraints

```ocaml
module type PRINTABLE_SET = sig
  type element
  type t
  val empty : t
  val add : element -> t -> t
  val mem : element -> t -> bool
  val print : t -> unit
end;;

module MakePrintableSet
    (Elem : COMPARABLE)
    (ElemShow : SHOWABLE with type t = Elem.t) :
  PRINTABLE_SET with type element = Elem.t = struct
  type element = Elem.t
  type t = element list
  
  let empty = []
  let rec mem x = function
    | [] -> false
    | h :: t -> Elem.compare x h = 0 || mem x t
  
  let rec add x set =
    if mem x set then set else x :: set
  
  let print set =
    List.iter (fun x -> print_endline (ElemShow.show x)) set
end;;
```

## When to Use Functors

Functors are useful when you want to:
1. Create generic data structures (Set, Map, Hashtbl)
2. Parameterize algorithms by data types
3. Share code between similar modules
4. Build module hierarchies with shared behavior

## Standard Library Functors

```ocaml
Map.Make        (* Create map for a type with ordering *)
Set.Make        (* Create set for a type with ordering *)
Hashtbl.Make    (* Create hash table for a hashable type *)
```

## Example: Generic Priority Queue

```ocaml
module type ORDERED = sig
  type t
  val compare : t -> t -> int
end;;

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
end;;

module IntPQ = MakePriorityQueue(struct
  type t = int
  let compare = compare
end);;

let pq = IntPQ.empty;;
let pq = IntPQ.insert 5 pq;;
let pq = IntPQ.insert 2 pq;;
let pq = IntPQ.insert 8 pq;;
match IntPQ.extract_min pq with
| Some (min, rest) -> min  (* 2 *)
| None -> 0;;
```

## Key Observations

- Functors are module-level functions
- They enable code reuse and abstraction
- The standard library uses functors extensively
- Functors can have multiple parameters
- Sharing constraints ensure type compatibility
- They're checked at compile time for type safety

## Common Patterns

1. **Generic Data Structures**: Map, Set using functors
2. **Algorithm Parameterization**: Different comparison functions
3. **Dependency Injection**: Pass implementations as modules
4. **Code Generation**: Create similar modules with variations

## Next Steps

- Learn about first-class modules
- Explore more standard library functors
- Build custom data structures with functors
- Understand generative vs applicative functors

## Example Code

See [examples/functors.ml](../examples/functors.ml) for complete examples.
