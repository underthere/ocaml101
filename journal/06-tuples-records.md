# Day 3: Tuples and Records

**Date:** Day 3  
**Topic:** Product Types - Tuples and Records

## What I Learned Today

OCaml has two main ways to group data: tuples and records. Both are immutable by default.

## Tuples

Tuples group a fixed number of values of potentially different types.

### Creating Tuples

```ocaml
let pair = (42, "hello");;
(* val pair : int * string = (42, "hello") *)

let triple = (1, 2.5, "three");;
(* val triple : int * float * string *)

let point = (3.0, 4.0);;
(* val point : float * float *)
```

### Accessing Tuple Elements

Pattern matching:
```ocaml
let (x, y) = point;;
(* x = 3.0, y = 4.0 *)

let get_first (x, _) = x;;
let get_second (_, y) = y;;
```

Built-in functions for pairs:
```ocaml
fst (1, 2);;  (* 1 *)
snd (1, 2);;  (* 2 *)
```

Note: `fst` and `snd` only work with pairs (2-tuples).

### Tuples in Functions

```ocaml
let distance point =
  let (x, y) = point in
  sqrt (x *. x +. y *. y);;

(* Or directly in parameters: *)
let distance (x, y) =
  sqrt (x *. x +. y *. y);;
```

### Returning Multiple Values

```ocaml
let div_mod x y =
  (x / y, x mod y);;

let quotient, remainder = div_mod 17 5;;
(* quotient = 3, remainder = 2 *)
```

## Records

Records are like tuples with named fields.

### Defining Record Types

```ocaml
type point = {
  x : float;
  y : float;
};;

type person = {
  name : string;
  age : int;
  email : string;
};;
```

### Creating Records

```ocaml
let origin = { x = 0.0; y = 0.0 };;

let alice = {
  name = "Alice";
  age = 30;
  email = "alice@example.com";
};;
```

### Accessing Record Fields

```ocaml
let x_coord = origin.x;;  (* 0.0 *)
let alice_name = alice.name;;  (* "Alice" *)
```

### Pattern Matching on Records

```ocaml
let is_origin point =
  match point with
  | { x = 0.0; y = 0.0 } -> true
  | _ -> false;;

(* Extract fields: *)
let { x; y } = origin;;

(* In function parameters: *)
let distance { x; y } =
  sqrt (x *. x +. y *. y);;
```

### Updating Records (Functional Update)

Records are immutable, but you can create new records with updated fields:

```ocaml
let p1 = { x = 1.0; y = 2.0 };;
let p2 = { p1 with x = 3.0 };;
(* p2 = { x = 3.0; y = 2.0 } *)
(* p1 is unchanged *)

let older_alice = { alice with age = alice.age + 1 };;
```

### Mutable Fields

Fields can be marked as mutable:

```ocaml
type counter = {
  mutable count : int;
};;

let c = { count = 0 };;
c.count <- c.count + 1;;  (* Mutation with <- *)
(* c.count is now 1 *)
```

## Record vs Tuple: When to Use What?

### Use Tuples When:
- You have a small, temporary grouping of values
- The order of elements is clear from context
- You don't need to name the fields

### Use Records When:
- You have multiple fields that need names
- The data structure is used throughout your code
- You want to make the code more self-documenting
- You might add fields later

## Examples

### Distance Between Points
```ocaml
type point = { x : float; y : float };;

let distance p1 p2 =
  let dx = p2.x -. p1.x in
  let dy = p2.y -. p1.y in
  sqrt (dx *. dx +. dy *. dy);;

let p1 = { x = 0.0; y = 0.0 };;
let p2 = { x = 3.0; y = 4.0 };;
let d = distance p1 p2;;  (* 5.0 *)
```

### Person Database
```ocaml
type person = {
  name : string;
  age : int;
  email : string;
};;

let is_adult person = person.age >= 18;;

let birthday person =
  { person with age = person.age + 1 };;

let people = [
  { name = "Alice"; age = 30; email = "alice@example.com" };
  { name = "Bob"; age = 25; email = "bob@example.com" };
];;

let adults = List.filter is_adult people;;
```

## Nested Records

```ocaml
type address = {
  street : string;
  city : string;
  zip : string;
};;

type person = {
  name : string;
  age : int;
  address : address;
};;

let alice = {
  name = "Alice";
  age = 30;
  address = {
    street = "123 Main St";
    city = "Springfield";
    zip = "12345";
  };
};;

let city = alice.address.city;;  (* "Springfield" *)
```

## Key Observations

- Both tuples and records are immutable by default
- Records provide better code documentation through named fields
- Pattern matching works with both
- Functional updates create new records
- Use mutable fields sparingly

## Next Steps

- Learn about variants (sum types)
- Understand algebraic data types
- Explore modules for organizing types

## Example Code

See [examples/tuples_records.ml](../examples/tuples_records.ml) for complete examples.
