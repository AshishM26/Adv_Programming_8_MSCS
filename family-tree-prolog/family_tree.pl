/*
  Family Tree Program in Prolog

  This file demonstrates how Prolog stores knowledge as facts and derives
  new relationships through rules. The program is intentionally written in a
  beginner-friendly style so that each fact and rule can be discussed in an
  assignment report.
*/

/*
  Gender facts describe which family members are male and female.
  These base facts are used by rules such as father/2 and mother/2.
*/

male(alen).
male(jack).
male(ben).
male(daniel).
male(liam).
male(oliver).
male(henry).
male(ethan).
male(mark).

female(mary).
female(susan).
female(lisa).
female(anna).
female(emma).
female(nora).
female(clara).

/*
  Parent facts are the core knowledge in the family tree.
  Each parent(X, Y) fact means X is a parent of Y.
*/

parent(alen, susan).
parent(mary, susan).
parent(alen, jack).
parent(mary, jack).
parent(alen, lisa).
parent(mary, lisa).

parent(susan, anna).
parent(henry, anna).
parent(susan, ben).
parent(henry, ben).

parent(jack, daniel).
parent(clara, daniel).
parent(jack, emma).
parent(clara, emma).

parent(lisa, nora).
parent(ethan, nora).
parent(lisa, liam).
parent(ethan, liam).

parent(anna, oliver).
parent(mark, oliver).

/*
  child(X, Y) means X is a child of Y.
  This is derived by reversing the parent relationship.
*/
child(X, Y) :-
    parent(Y, X).

/*
  father(X, Y) means X is the father of Y.
  Prolog infers this when X is both a parent of Y and male.
*/
father(X, Y) :-
    parent(X, Y),
    male(X).

/*
  mother(X, Y) means X is the mother of Y.
  Prolog infers this when X is both a parent of Y and female.
*/
mother(X, Y) :-
    parent(X, Y),
    female(X).

/*
  grandparent(X, Y) means X is a grandparent of Y.
  This succeeds when X is a parent of Z and Z is a parent of Y.
*/
grandparent(X, Y) :-
    parent(X, Z),
    parent(Z, Y).

/*
  sibling(X, Y) means X and Y share at least one parent.
  dif(X, Y) prevents a person from being treated as their own sibling.
  once/1 keeps the result beginner-friendly by avoiding duplicate successes
  when two siblings share both parents.
*/
sibling(X, Y) :-
    dif(X, Y),
    once((
        parent(P, X),
        parent(P, Y)
    )).

/*
  cousin(X, Y) means the parents of X and Y are siblings.
  dif(X, Y) prevents self-cousin matches.
  once/1 helps avoid duplicate answers that could appear through multiple
  parent combinations while keeping the rule easy to explain.
*/
cousin(X, Y) :-
    dif(X, Y),
    once((
        parent(PX, X),
        parent(PY, Y),
        sibling(PX, PY)
    )).

/*
  descendant(X, Y) means Y is a descendant of X.

  Base case:
  If X is a parent of Y, then Y is a direct descendant of X.

  Recursive case:
  If X is a parent of Z, and Y is a descendant of Z, then Y is also
  a descendant of X. This is how Prolog reasons across generations.
*/
descendant(X, Y) :-
    parent(X, Y).
descendant(X, Y) :-
    parent(X, Z),
    descendant(Z, Y).

/*
  run_demo/0 prints a screenshot-friendly summary of several example queries.
  This predicate is called manually with:

      ?- run_demo.

  The demo shows how Prolog answers questions by inference rather than by
  following explicit procedural steps.
*/
show_tree :-
    writeln('========================================'),
    writeln('Family Tree Structure'),
    writeln('========================================'),
    writeln('alen + mary'),
    writeln('|-- susan + henry'),
    writeln('|   |-- anna + mark'),
    writeln('|   |   `-- oliver'),
    writeln('|   `-- ben'),
    writeln('|-- jack + clara'),
    writeln('|   |-- daniel'),
    writeln('|   `-- emma'),
    writeln('`-- lisa + ethan'),
    writeln('    |-- nora'),
    writeln('    `-- liam').

run_demo :-
    writeln('========================================'),
    writeln('Family Tree Demo'),
    writeln('========================================'),
    show_tree,
    writeln('----------------------------------------'),
    findall(C, parent(susan, C), SusanChildren),
    format('Children of susan: ~w~n', [SusanChildren]),
    findall(S, sibling(anna, S), AnnaSiblings),
    format('Siblings of anna: ~w~n', [AnnaSiblings]),
    findall(Cousin, cousin(anna, Cousin), AnnaCousins),
    format('Cousins of anna: ~w~n', [AnnaCousins]),
    (   grandparent(alen, anna)
    ->  writeln('grandparent(alen, anna): true')
    ;   writeln('grandparent(alen, anna): false')
    ),
    (   descendant(alen, oliver)
    ->  writeln('descendant(alen, oliver): true')
    ;   writeln('descendant(alen, oliver): false')
    ),
    findall(D, descendant(alen, D), AlenDescendants),
    format('Descendants of alen: ~w~n', [AlenDescendants]).
