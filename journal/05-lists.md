# Day 3: Working with Lists

**Date:** Day 3  
**Topic:** Lists and List Operations

## What I Learned Today

Lists are the fundamental data structure in OCaml. They are immutable and implemented as linked lists.

## Creating Lists

```ocaml
let empty = [];;
let numbers = [1; 2; 3; 4; 5];;
let strings = ["hello"; "world"];;
```

Note: Use semicolons (`;`) to separate elements, not commas!

## The Cons Operator `::`

Build lists with the cons operator:

```ocaml
let lst = 1 :: 2 :: 3 :: [];;  (* [1; 2; 3] *)

(* Add to front of list *)
let new_list = 0 :: numbers;;  (* [0; 1; 2; 3; 4; 5] *)
```

## List Concatenation

Use `@` to concatenate lists:

```ocaml
let combined = [1; 2] @ [3; 4];;  (* [1; 2; 3; 4] *)
```

**Warning:** `@` is O(n) where n is the length of the first list. Use `::` when possible.

## Common List Functions

### Length
```ocaml
let rec length lst =
  match lst with
  | [] -> 0
  | _ :: tail -> 1 + length tail;;

List.length [1; 2; 3];;  (* 3 *)
```

### Head and Tail
```ocaml
let head lst =
  match lst with
  | h :: _ -> Some h
  | [] -> None;;

let tail lst =
  match lst with
  | _ :: t -> Some t
  | [] -> None;;

(* Or use List module *)
List.hd [1; 2; 3];;  (* 1 - raises exception on empty list *)
List.tl [1; 2; 3];;  (* [2; 3] *)
```

### Map
```ocaml
let rec map f lst =
  match lst with
  | [] -> []
  | h :: t -> f h :: map f t;;

let doubled = map (fun x -> x * 2) [1; 2; 3];;  (* [2; 4; 6] *)
List.map (fun x -> x * 2) [1; 2; 3];;  (* Using stdlib *)
```

### Filter
```ocaml
let rec filter predicate lst =
  match lst with
  | [] -> []
  | h :: t when predicate h -> h :: filter predicate t
  | _ :: t -> filter predicate t;;

let evens = filter (fun x -> x mod 2 = 0) [1; 2; 3; 4; 5];;  (* [2; 4] *)
```

### Fold (Reduce)

Fold left (tail recursive):
```ocaml
let rec fold_left f acc lst =
  match lst with
  | [] -> acc
  | h :: t -> fold_left f (f acc h) t;;

let sum = fold_left (+) 0 [1; 2; 3; 4];;  (* 10 *)
```

Fold right:
```ocaml
let rec fold_right f lst acc =
  match lst with
  | [] -> acc
  | h :: t -> f h (fold_right f t acc);;

let concatenated = fold_right (^) ["a"; "b"; "c"] "";;  (* "abc" *)
```

## List Comprehension (Not Built-in)

OCaml doesn't have list comprehension syntax, but you can achieve similar results:

```ocaml
(* Generate a range *)
let rec range start stop =
  if start >= stop then []
  else start :: range (start + 1) stop;;

let nums = range 1 11;;  (* [1; 2; 3; ..., 10] *)

(* Squares of even numbers *)
let squares_of_evens n =
  range 1 n
  |> List.filter (fun x -> x mod 2 = 0)
  |> List.map (fun x -> x * x);;
```

## The Pipe Operator `|>`

Chain operations left-to-right:

```ocaml
let result =
  [1; 2; 3; 4; 5; 6]
  |> List.filter (fun x -> x mod 2 = 0)
  |> List.map (fun x -> x * x)
  |> List.fold_left (+) 0;;
(* 56 = 4 + 16 + 36 *)
```

## Common Patterns

### Reverse a List
```ocaml
let reverse lst =
  let rec helper acc = function
    | [] -> acc
    | h :: t -> helper (h :: acc) t
  in
  helper [] lst;;
```

### Find Element
```ocaml
let rec find predicate = function
  | [] -> None
  | h :: t -> if predicate h then Some h else find predicate t;;
```

### Zip Two Lists
```ocaml
let rec zip lst1 lst2 =
  match lst1, lst2 with
  | [], _ | _, [] -> []
  | h1 :: t1, h2 :: t2 -> (h1, h2) :: zip t1 t2;;
```

## Key Observations

- Lists are immutable and persistent
- Operations like `::` are O(1), but `@` is O(n)
- Most operations work recursively
- The standard library has many useful list functions
- Use tail recursion for better performance

## Important List Module Functions

```ocaml
List.length        (* Get list length *)
List.rev           (* Reverse list *)
List.nth           (* Get nth element *)
List.append        (* Concatenate lists *)
List.concat        (* Flatten list of lists *)
List.iter          (* Iterate with side effects *)
List.exists        (* Test if any element satisfies predicate *)
List.for_all       (* Test if all elements satisfy predicate *)
```

## Next Steps

- Learn about tuples and records
- Understand arrays (mutable)
- Explore other data structures

## Example Code

See [examples/lists.ml](../examples/lists.ml) for complete examples.
