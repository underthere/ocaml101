# Day 1: Hello World in OCaml

**Date:** Getting Started  
**Topic:** First OCaml Program

## What I Learned Today

Today I wrote my first OCaml program! OCaml is a functional programming language with strong static typing.

## Hello World

The simplest OCaml program:

```ocaml
print_endline "Hello, World!";;
```

### Key Points

- `print_endline` is a function that prints a string followed by a newline
- The `;;` at the end is used in the OCaml REPL to indicate the end of an expression
- In compiled programs, `;;` is optional but commonly used

## Running the Code

### In the REPL
```bash
$ ocaml
# print_endline "Hello, World!";;
Hello, World!
- : unit = ()
```

### As a Compiled Program

Create a file `hello.ml`:
```ocaml
let () = print_endline "Hello, World!"
```

Compile and run:
```bash
ocamlc -o hello hello.ml
./hello
```

### Using print_string

Alternative way to print:
```ocaml
print_string "Hello, World!\n";;
```

## Observations

- OCaml uses `let` for variable binding
- Functions are first-class citizens
- Type inference is powerful - OCaml knows `print_endline` takes a string
- The `()` is the unit type, similar to `void` in other languages

## Next Steps

- Learn about variables and basic types
- Understand let bindings better
- Explore basic operations

## Example Code

See [examples/hello.ml](../examples/hello.ml) for the complete example.
