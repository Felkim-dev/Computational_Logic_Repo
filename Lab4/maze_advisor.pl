
% LAB SETUP

edge(entrance,a).
edge(a,b).
edge(a,c).
edge(b,exit).
edge(c,b).
blocked(a,c).

% Reasoning Predicates

can_move(X,Y):- edge(X,Y),\+ blocked(X,Y).
reason(X,Y,'path is open'):- can_move(X,Y).
reason(X,Y,'path is blocked'):- blocked(X,Y).

% Recursive Traversal with Explanation
move(X,Y,Visited,[Y|Visited]):-
    can_move(X,Y),
    format('Moving from ~w to ~w.~n', [X,Y]).
move(X,Y,Visited, Path):-
    can_move(X,Z),
    \+ member(Z,Visited),
    format('Exploring from ~w to ~w...~n',[X,Z]),
    move(Z,Y,[Z|Visited],Path).

%Main Predicate

find_path(X,Y,Path):-
    move(X,Y,[X],RevPath),
    reverse(RevPath,Path).
    