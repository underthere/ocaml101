# Day 2: Functions in OCaml

**Date:** Day 2  
**Topic:** Defining and Using Functions

## What I Learned Today

Functions are at the heart of OCaml. Everything revolves around functions in functional programming.

## Basic Function Definition

```ocaml
let square x = x * x;;
(* val square : int -> int = <fun> *)

let result = square 5;;  (* 25 *)
```

## Multiple Parameters

```ocaml
let add x y = x + y;;
(* val add : int -> int -> int = <fun> *)

let sum = add 3 7;;  (* 10 *)
```

## Anonymous Functions (Lambda)

```ocaml
let square = fun x -> x * x;;

(* Or inline: *)
let result = (fun x -> x * x) 5;;  (* 25 *)
```

## Recursive Functions

Use `let rec` for recursive functions:

```ocaml
let rec factorial n =
  if n <= 1 then 1
  else n * factorial (n - 1);;

(* factorial 5 = 120 *)
```

### Tail Recursion

Better performance with tail recursion:

```ocaml
let factorial n =
  let rec helper acc n =
    if n <= 1 then acc
    else helper (acc * n) (n - 1)
  in
  helper 1 n;;
```

## Conditional Expressions

```ocaml
let max x y =
  if x > y then x else y;;
```

OCaml's `if` is an expression (returns a value):

```ocaml
let sign x =
  if x > 0 then "positive"
  else if x < 0 then "negative"
  else "zero";;
```

## Higher-Order Functions

Functions can take other functions as parameters:

```ocaml
let apply_twice f x = f (f x);;

let result = apply_twice (fun x -> x + 1) 5;;  (* 7 *)
```

### Map Example

```ocaml
let rec map f lst =
  match lst with
  | [] -> []
  | head :: tail -> f head :: map f tail;;

let doubled = map (fun x -> x * 2) [1; 2; 3; 4];;
(* [2; 4; 6; 8] *)
```

## Partial Application (Currying)

All multi-parameter functions are curried:

```ocaml
let add x y = x + y;;

let add_five = add 5;;  (* Partially applied *)
let result = add_five 10;;  (* 15 *)
```

## Function Composition

```ocaml
let compose f g x = f (g x);;

let add_one x = x + 1;;
let double x = x * 2;;

let add_then_double = compose double add_one;;
let result = add_then_double 5;;  (* 12 *)
```

## Key Observations

- Functions are first-class values
- All functions are curried by default
- `let rec` is needed for recursive functions
- Tail recursion is important for performance
- Functions can be passed as arguments and returned as results

## Next Steps

- Learn pattern matching
- Understand algebraic data types
- Explore more list operations

## Example Code

See [examples/functions.ml](../examples/functions.ml) for complete examples.
