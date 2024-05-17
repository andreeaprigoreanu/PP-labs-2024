% ex 1
om(mary).
om(helen).
om(john).

bea(mary, cafea).
bea(mary, ceai).
bea(helen, ceai).
bea(john, cafea).

mananca(mary, ciocolata).
mananca(helen, ciocolata).
mananca(helen, biscuiti).
mananca(john, alune).

fericit(X) :- om(X), bea(X, cafea), mananca(X, ciocolata).

client(nume(ion, popescu), carte(aventuri, 2002)).

% ex 2
parent(mary, hazel).
parent(john, jake).
parent(john, suzy).
parent(john, mike).
parent(jake, helen).

siblings(X, Y) :- parent(Z, X), parent(Z, Y), X \= Y.

% variabile anonime:
has_siblings(X) :- siblings(X, _).

/*
    functie pentru a calcula lungimea unei liste
    my_length(+list, -length)
    +Lista input
    -Lungime output

    Haskell:
    length [] = 0
    length (_ : rest) = length(rest) + 1
 */
my_length([], 0).
my_length([_ | Rest], Len) :- my_length(Rest, Len1), Len is Len1 + 1.


/*
    my_member(+X, +L)

    member x [] = false
    member x (y : rest) = x == y | member (x, rest)
*/
% my_member(_, []):- false.
my_member(X, [X | _]).
my_member(X, [_ | T]) :- my_member(X, T).
