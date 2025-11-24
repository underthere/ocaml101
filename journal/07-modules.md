# Day 4: Modules

**Date:** Day 4  
**Topic:** Modules and Namespaces

## What I Learned Today

Modules are OCaml's way of organizing code. They provide namespaces and encapsulation.

## What is a Module?

A module is a collection of definitions (types, values, functions, sub-modules).

## Using Built-in Modules

```ocaml
List.map (fun x -> x * 2) [1; 2; 3];;
String.length "hello";;
Array.make 5 0;;
```

## Defining Modules

### Simple Module

```ocaml
module Math = struct
  let pi = 3.14159
  let square x = x * x
  let cube x = x * x * x
end;;

let area = Math.pi *. 5.0 *. 5.0;;
let s = Math.square 4;;
```

### Module with Types

```ocaml
module Point = struct
  type t = { x : float; y : float }
  
  let make x y = { x; y }
  let origin = { x = 0.0; y = 0.0 }
  
  let distance p1 p2 =
    let dx = p2.x -. p1.x in
    let dy = p2.y -. p1.y in
    sqrt (dx *. dx +. dy *. dy)
end;;

let p1 = Point.make 3.0 4.0;;
let d = Point.distance Point.origin p1;;
```

## Opening Modules

Use `open` to avoid prefixing:

```ocaml
open List;;
let doubled = map (fun x -> x * 2) [1; 2; 3];;

(* Or locally: *)
let doubled =
  let open List in
  map (fun x -> x * 2) [1; 2; 3];;

(* Or with syntax: *)
let doubled =
  List.(map (fun x -> x * 2) [1; 2; 3]);;
```

**Be careful:** Opening modules can cause name conflicts.

## Module Types (Signatures)

Define interfaces for modules:

```ocaml
module type STACK = sig
  type 'a t
  val empty : 'a t
  val push : 'a -> 'a t -> 'a t
  val pop : 'a t -> ('a * 'a t) option
  val is_empty : 'a t -> bool
end;;

module Stack : STACK = struct
  type 'a t = 'a list
  
  let empty = []
  let push x stack = x :: stack
  let pop = function
    | [] -> None
    | h :: t -> Some (h, t)
  let is_empty stack = (stack = [])
end;;
```

## Abstract Types

Hide implementation details:

```ocaml
module Counter : sig
  type t
  val make : unit -> t
  val increment : t -> t
  val value : t -> int
end = struct
  type t = { mutable count : int }
  
  let make () = { count = 0 }
  let increment c = c.count <- c.count + 1; c
  let value c = c.count
end;;

(* Users can't access the internal representation *)
```

## File-based Modules

Each `.ml` file is automatically a module:

**math.ml:**
```ocaml
let pi = 3.14159
let square x = x * x
```

**main.ml:**
```ocaml
let area = Math.pi *. 5.0 *. 5.0
let s = Math.square 4
```

The module name is derived from the filename (capitalized).

## Module Interface Files

**math.mli:** (interface)
```ocaml
val pi : float
val square : int -> int
```

**math.ml:** (implementation)
```ocaml
let pi = 3.14159
let square x = x * x
let internal_helper x = x + 1  (* Not exposed *)
```

## Including Modules

Copy definitions from another module:

```ocaml
module Extended_list = struct
  include List
  
  let is_empty = function
    | [] -> true
    | _ -> false
end;;

Extended_list.map;;  (* Has all List functions *)
Extended_list.is_empty [];;  (* Plus new ones *)
```

## Nested Modules

```ocaml
module Geometry = struct
  module Point = struct
    type t = { x : float; y : float }
    let make x y = { x; y }
  end
  
  module Circle = struct
    type t = { center : Point.t; radius : float }
    let make center radius = { center; radius }
    let area circle = 3.14159 *. circle.radius *. circle.radius
  end
end;;

let p = Geometry.Point.make 0.0 0.0;;
let c = Geometry.Circle.make p 5.0;;
```

## Common Standard Library Modules

```ocaml
List        (* List operations *)
String      (* String operations *)
Array       (* Mutable arrays *)
Hashtbl     (* Hash tables *)
Map         (* Immutable maps *)
Set         (* Immutable sets *)
Option      (* Option operations *)
Result      (* Result type operations *)
Printf      (* Formatted printing *)
Sys         (* System interface *)
Unix        (* Unix system calls *)
```

## Key Observations

- Modules provide namespacing and organization
- Module types define interfaces
- Abstract types hide implementation
- Each file is automatically a module
- `.mli` files define module interfaces
- Modules can be nested

## Best Practices

1. Use meaningful module names
2. Keep modules focused on a single concern
3. Use module types to define clear interfaces
4. Use abstract types to hide implementation details
5. Be careful with `open` to avoid name conflicts
6. Use local opens when possible: `Module.(expression)`

## Next Steps

- Learn about functors (parameterized modules)
- Understand first-class modules
- Explore the standard library

## Example Code

See [examples/modules.ml](../examples/modules.ml) for complete examples.
