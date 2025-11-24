# Day 1: Basic Syntax and Types

**Date:** Getting Started  
**Topic:** Variables, Types, and Basic Operations

## What I Learned Today

OCaml has a powerful type system with type inference. I learned about basic types and how to work with them.

## Basic Types

### Integers
```ocaml
let x = 42;;
let y = -10;;
let sum = x + y;;  (* 32 *)
```

### Floating Point
```ocaml
let pi = 3.14159;;
let radius = 5.0;;
let area = pi *. (radius ** 2.0);;  (* Note: *. for float multiplication *)
```

**Important:** OCaml uses different operators for integers and floats:
- Integer: `+`, `-`, `*`, `/`
- Float: `+.`, `-.`, `*.`, `/.`

### Strings
```ocaml
let greeting = "Hello";;
let name = "OCaml";;
let message = greeting ^ " " ^ name;;  (* String concatenation with ^ *)
```

### Booleans
```ocaml
let is_true = true;;
let is_false = false;;
let result = is_true && not is_false;;  (* true *)
```

### Characters
```ocaml
let letter = 'a';;
let newline = '\n';;
```

## Let Bindings

The `let` keyword is used for variable binding (immutable by default):

```ocaml
let x = 5;;
(* x = 10;;  This would cause an error! Variables are immutable by default *)
```

### Local Bindings
```ocaml
let x = 5 in
let y = 10 in
x + y;;  (* 15 *)
```

## Type Annotations

OCaml can infer types, but you can be explicit:

```ocaml
let x : int = 42;;
let name : string = "OCaml";;
let pi : float = 3.14159;;
```

## Comments

```ocaml
(* This is a single-line comment *)

(* This is a
   multi-line
   comment *)
```

## Type Inference

OCaml's type inference is powerful:

```ocaml
let double x = x * 2;;
(* OCaml infers: val double : int -> int *)

let double_float x = x *. 2.0;;
(* OCaml infers: val double_float : float -> float *)
```

## Key Observations

- Variables are immutable by default (functional programming style)
- Type system prevents many common errors at compile time
- Different operators for different numeric types prevents silent bugs
- Type inference reduces boilerplate while maintaining type safety

## Next Steps

- Learn about functions in depth
- Understand recursive functions
- Explore conditional expressions

## Example Code

See [examples/basics.ml](../examples/basics.ml) for complete examples.
