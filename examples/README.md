# OCaml Examples

This directory contains runnable OCaml example files corresponding to the journal entries.

## Running the Examples

### Using the OCaml Compiler

To compile and run an example:

```bash
ocamlc -o hello hello.ml
./hello
```

To compile with optimizations:

```bash
ocamlopt -o hello hello.ml
./hello
```

### Using the OCaml Interpreter

To run directly with the interpreter:

```bash
ocaml hello.ml
```

Or load into the REPL:

```bash
ocaml
# #use "hello.ml";;
```

## Examples

- **hello.ml** - Hello World examples
- **basics.ml** - Basic syntax, types, and operations
- **functions.ml** - Function definitions, recursion, higher-order functions
- **pattern_matching.ml** - Pattern matching with various data types
- **lists.ml** - List operations and common patterns
- **tuples_records.ml** - Working with tuples and records
- **modules.ml** - Module definitions and usage

## Compiling All Examples

You can compile all examples at once:

```bash
for file in *.ml; do
  if [ "$file" != "README.ml" ]; then
    echo "Compiling $file..."
    ocamlc -o "${file%.ml}" "$file"
  fi
done
```

## Cleaning Up

Remove compiled files:

```bash
rm -f *.cmi *.cmo *.cmx *.o hello basics functions pattern_matching lists tuples_records modules
```

## Using Dune (Recommended for Projects)

For a more structured approach, consider using Dune. Create a `dune` file:

```lisp
(executables
 (names hello basics functions pattern_matching lists tuples_records modules))
```

Then build and run:

```bash
dune build
dune exec ./hello.exe
```

## Notes

- All examples are self-contained and can be run independently
- Examples use only the OCaml standard library
- Comments explain key concepts throughout the code
- Examples are meant for learning and experimentation
