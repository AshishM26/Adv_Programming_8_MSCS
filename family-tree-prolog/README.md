# Family Tree in Prolog

This project demonstrates how Prolog represents knowledge and answers questions through facts, rules, logical inference, and recursion. The program models a small family tree and supports queries about parents, children, grandparents, siblings, cousins, and descendants.

The goal is to show how Prolog differs from procedural and object-oriented languages. Instead of writing step-by-step instructions, we define relationships and let the Prolog engine infer answers from those definitions.

## Facts, Rules, and Recursive Inference

Facts represent information that is directly true in the knowledge base. In this project, facts are written using:

- `male/1`
- `female/1`
- `parent/2`

Rules define relationships that can be inferred from the facts. For example:

- `child/2` is derived by reversing `parent/2`
- `father/2` and `mother/2` combine parent facts with gender facts
- `grandparent/2` links two parent relationships together
- `sibling/2` checks for a shared parent
- `cousin/2` checks whether two parents are siblings

The `descendant/2` rule uses recursion. It works in two parts:

- Base case: a direct parent relationship means direct descent
- Recursive case: if X is a parent of Z, and Y is a descendant of Z, then Y is also a descendant of X through that chain

This allows Prolog to infer descendants across multiple generations.

## Tree Used
```text
alen + mary
|-- susan + henry
|   |-- anna + mark
|   |   `-- oliver
|   `-- ben
|-- jack + clara
|   |-- daniel
|   `-- emma
`-- lisa + ethan
    |-- nora
    `-- liam
```