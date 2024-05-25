% -------------------------------------- GENERATING SOLUTIONS -------------------------------------

/*
    ?X -> X poate fi intrare sau iesire
    +List -> lista este intrare
    is_member(?X,+List)
*/
is_member(X,[X|_]).
is_member(X,[_|T]) :- is_member(X,T).

list_remove(X, [X | T], T).
list_remove(X, [X1 | T1], [X1 | T2]) :- list_remove(X, T1, T2).

list_insert(X, L, R) :- list_remove(X, R, L).

perm([], []).
perm([X | T], P) :- perm(T, P1), list_insert(X, P1, P).

perm2([], []).
perm2(L, [X | P]) :- list_remove(X, L, L1), perm2(L1, P).

% -------------------------------------- CUT EXAMPLE 1 ------------------------------------------

connection(room1, room3).
connection(room1, room2).
connection(room3, room4).
connection(room2, room4).

path(X, Y) :- connection(X, Y), !.
path(X, Y) :- connection(X, Z), path(Z, Y), !.


% path(X, Y) :- connection(X, Y).
% path(X, Y) :- connection(X, Z), path(Z, Y).

% -------------------------------------- CUT EXAMPLE 2 ------------------------------------------

min1(X, Y, Min) :- X < Y, Min = X.
min1(X, Y, Min) :- X >= Y, Min = Y.

min1B(X, Y, Min) :- X < Y, Min = X.
min1B(_, Y, Min) :- Min = Y.

min2(X, Y, Min) :- X < Y, !, Min = X.
min2(X, Y, Min) :- X >= Y, Min = Y.

% min2(X, Y, Min) :- X < Y, Min = X, !.
% min2(X, Y, Min) :- X >= Y, Min = Y.

min2B(X, Y, Min) :- !, X < Y, Min = X.
min2B(X, Y, Min) :- X >= Y, Min = Y.

% Here we use cut to say: "If the first rule succeeds, don't try the second rule. Otherwise, use the second rule."
min3(X, Y, X) :- X =< Y, !.
min3(_, Y, Y).

% -------------------------------------- FALSE -------------------------------------------------

my_reverse(List, Acc, _) :- format('List:~w, Acc:~w~n', [List, Acc]), false.
my_reverse([], Sol, Sol).
my_reverse([Head | Tail], Acc, Sol):-my_reverse(Tail, [Head | Acc], Sol).


% -------------------------------------- GREEN CUTS ---------------------------------------------

f(X, first_interval) :- X < 3.          % (-inf, 3)
f(X, second_interval) :- 3 =< X, X < 6. % [3, 6)
f(X, third_interval) :- 6 =< X.         % [6, +inf)

% trace f(1,Interval).

f1(X, first_interval) :- X < 3, !.
f1(X, second_interval) :- 3 =< X, X < 6, !.
f1(X, third_interval) :- 6 =< X.

% trace f1(1,Interval).

/*
    The answer is still the same, we just avoided some useless backtraking
*/

% -------------------------------------- RED CUTS ---------------------------------------------

g(X, first_interval)  :- X < 3.
g(X, second_interval) :- X < 6.
g(_, third_interval).

% g(1, Interval).

g1(X, first_interval)  :- X < 3, !.
g1(X, second_interval) :- X < 6, !.
g1(_, third_interval).

% g1(1, Interval)

/*
    The answer is not the same => the logic of the predicate changes after adding the cut
    Here, the clauses are not mutually exclusive
*/

% ------------------------------------------------- FINDALL ------------------------------------------------------

/*
    findall(+Template, +Goal, -List)

    Collects a list `List` of all the items of the form `Template` that satisfy some goal `Goal`
*/

believes(john, likes(mary, pizza)).
believes(frank, likes(mary, fish)).
believes(john, likes(mary, apples)).

% findall(X, member(X, [1,2,3]), L).
% findall(X/X, member(X, [1,2,3]), L).
% findall(likes(mary, X), believes(_, likes(mary, X)), Bag).
% findall(X, member(X, [1,2,3]), L), length(L, N).


% ------------------------------------------------- DOUBLE NEGATION ------------------------------------------------------

% double negation -> \+ \+ Goal <=> Goal can be proven

edible(apple).
no_fruit_is_edible(X) :- \+ edible(X).
there_is_at_least_one_edible_fruit(X) :- \+ \+ edible(X).

% there_is_at_least_one_edible_fruit(X). 
% -> true = there is at least one edible fruit but Prolog won't tell you which <=> p(X) can be proven

/*
    If we want to ask if two predicates hold simultaneously
*/
q(4).
q(5).
% there is no X for which q(X) holds and member(X, [1,2,3]) holds.
p(X) :- \+ (q(X), member(X, [1,2,3])).

% there is no X for which q(X) holds and member(X, [1,2,3]) doesn't hold.
% for all X for which q(X) holds, member(X, [1,2,3]) holds.
p1(X) :- \+ (q(X), \+ member(X,[1,2,3])).

% ------------------------------------------------- FORALL ------------------------------------------------------

/*
    forall(Condition, Action):
        - succeeds if for all alternative bindings of Condition, Action can be proven
        - fails if there is at least one alternative binding of Condition, for which Action can't be proven
*/

% There is no instantiation of Cond for which Action can't be proven
foralll(Cond, Action) :- \+ (Cond, \+ Action).

% check if all members of [1,2,3] are in [1,2,3,4] too
% foralll(member(X,[1,2,3]), member(X,[1,2,3,4])).
% L1 = [1,2,3], L2 = [1,2], forall(member(X,L1), member(X, L2)).

% forall -> all members in [1,2,3] are in [1,2,3,4] too
% negation -> there is at least one member in [1,2,3] which IS NOT in [1,2,3,4]
p2(X) :- \+ forall(member(X,[1,2,3]), member(X,[1,2,3,4])).

% negate the Action -> there is at least one member in [1,2,3] which IS in [1,2,3,4]
p3(X) :- \+ forall(member(X,[1,2,3]), \+ member(X,[1,4])).

p4(X) :- \+ \+ (member(X,[1,2,3]), member(X,[1,4])).

foranyy(Cond, Action) :- \+ forall(Cond, \+ Action).

% foranyy(member(X,[1,2,3]), member(X,[1,4])).
