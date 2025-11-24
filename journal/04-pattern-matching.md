# Day 2: Pattern Matching

**Date:** Day 2  
**Topic:** Pattern Matching Fundamentals

## What I Learned Today

Pattern matching is one of OCaml's most powerful features. It's more than just a switch statement!

## Basic Pattern Matching

```ocaml
let describe_number n =
  match n with
  | 0 -> "zero"
  | 1 -> "one"
  | 2 -> "two"
  | _ -> "many";;
```

The `_` is a wildcard that matches anything.

## Pattern Matching with Lists

```ocaml
let rec sum_list lst =
  match lst with
  | [] -> 0
  | head :: tail -> head + sum_list tail;;
```

Patterns:
- `[]` - empty list
- `head :: tail` - list with at least one element
- `[x]` - list with exactly one element
- `[x; y]` - list with exactly two elements
- `x :: y :: rest` - list with at least two elements

## Multiple Patterns

```ocaml
let rec list_length lst =
  match lst with
  | [] -> 0
  | _ :: tail -> 1 + list_length tail;;
```

## Guards

Add conditions to patterns:

```ocaml
let classify_number n =
  match n with
  | n when n < 0 -> "negative"
  | 0 -> "zero"
  | n when n > 0 && n < 10 -> "small positive"
  | _ -> "large positive";;
```

## Matching Tuples

```ocaml
let is_origin point =
  match point with
  | (0, 0) -> true
  | _ -> false;;

let get_x point =
  match point with
  | (x, _) -> x;;
```

## Matching Options

```ocaml
let get_or_default opt default =
  match opt with
  | Some value -> value
  | None -> default;;

let x = get_or_default (Some 42) 0;;  (* 42 *)
let y = get_or_default None 0;;  (* 0 *)
```

## Nested Patterns

```ocaml
let rec find_first_some lst =
  match lst with
  | [] -> None
  | Some x :: _ -> Some x
  | None :: rest -> find_first_some rest;;
```

## Pattern Matching in Function Parameters

```ocaml
let fst (x, _) = x;;
let snd (_, y) = y;;

(* With lists: *)
let head (h :: _) = h;;
(* Warning: This is partial - fails on empty list *)
```

## The `function` Keyword

Shorthand for pattern matching on the last parameter:

```ocaml
let rec length = function
  | [] -> 0
  | _ :: tail -> 1 + length tail;;

(* Equivalent to: *)
let rec length lst =
  match lst with
  | [] -> 0
  | _ :: tail -> 1 + length tail;;
```

## Exhaustiveness Checking

OCaml warns about non-exhaustive patterns:

```ocaml
let head lst =
  match lst with
  | h :: _ -> h;;
(* Warning: pattern-matching is not exhaustive. *)
```

## Key Observations

- Pattern matching is exhaustive - OCaml checks all cases
- More powerful than switch statements
- Works with any data structure
- Combines testing and destructuring
- Guards add conditional logic to patterns

## Common Patterns

```ocaml
(* Check if list has at least 2 elements *)
let has_two = function
  | _ :: _ :: _ -> true
  | _ -> false;;

(* Get second element *)
let second = function
  | _ :: x :: _ -> Some x
  | _ -> None;;

(* Reverse a list *)
let reverse lst =
  let rec helper acc = function
    | [] -> acc
    | h :: t -> helper (h :: acc) t
  in
  helper [] lst;;
```

## Next Steps

- Learn about custom types (variants)
- Understand algebraic data types
- Explore more complex pattern matching

## Example Code

See [examples/pattern_matching.ml](../examples/pattern_matching.ml) for complete examples.
