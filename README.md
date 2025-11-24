# OCaml 101 - A Quick Journal

A quick journal for learning OCaml programming language. This repository contains notes, examples, and exercises for getting started with OCaml.

## Table of Contents

1. [Getting Started](#getting-started)
2. [Journal Entries](#journal-entries)
3. [Examples](#examples)
4. [Resources](#resources)

## Getting Started

### Installing OCaml

#### On macOS
```bash
brew install ocaml opam
opam init
eval $(opam env)
```

#### On Ubuntu/Debian
```bash
sudo apt-get install ocaml opam
opam init
eval $(opam env)
```

#### On Windows
Use WSL2 or follow the [official OCaml installation guide](https://ocaml.org/docs/install.html).

### Running OCaml Code

#### Interactive REPL
```bash
ocaml
```

#### Compile and Run
```bash
ocamlc -o program program.ml
./program
```

#### Using Dune (recommended for projects)
```bash
opam install dune
dune build
dune exec
```

## Journal Entries

### Day 1: Introduction to OCaml
- [01-hello-world.md](journal/01-hello-world.md) - First steps with OCaml
- [02-basic-syntax.md](journal/02-basic-syntax.md) - Variables, types, and basic operations

### Day 2: Functions and Pattern Matching
- [03-functions.md](journal/03-functions.md) - Defining and using functions
- [04-pattern-matching.md](journal/04-pattern-matching.md) - Pattern matching basics

### Day 3: Data Structures
- [05-lists.md](journal/05-lists.md) - Working with lists
- [06-tuples-records.md](journal/06-tuples-records.md) - Tuples and records

### Day 4: Advanced Topics
- [07-modules.md](journal/07-modules.md) - Modules and namespaces
- [08-functors.md](journal/08-functors.md) - Functors introduction

## Examples

All example code can be found in the [examples/](examples/) directory.

## Resources

- [Official OCaml Website](https://ocaml.org/)
- [OCaml Documentation](https://ocaml.org/docs)
- [Real World OCaml](https://dev.realworldocaml.org/)
- [OCaml from the Very Beginning](https://johnwhitington.net/ocamlfromtheverybeginning/)

## Contributing

This is a personal learning journal, but suggestions and corrections are welcome via issues or pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.