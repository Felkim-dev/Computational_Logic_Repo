% Maze Representation

%Connected
edge(entrance,a).
edge(a,b).
edge(c,d).
edge(d,c).
edge(d,c).
edge(d,e).
edge(e,d).
edge(e,exit).
edge(a,f).
edge(f,a).
edge(b,g).
edge(c,h).
edge(h,c).
edge(i,d).
edge(d,i).
edge(k,e).
edge(f,g).
edge(g,f).
edge(g,h).
edge(i,j).
edge(k,l).
edge(f,w).
edge(w,f).
edge(g,m).
edge(m,g).
edge(h,n).
edge(n,h).
edge(s,i).
edge(i,s).
edge(j,t).
edge(j,u).
edge(u,k).
edge(v,l).
edge(l,k).
edge(m,n).
edge(n,m).
edge(n,s).
edge(s,t).
edge(t,s).
edge(t,u).
edge(u,v).
edge(v,o).
edge(o,v).
edge(z,t).
edge(t,z).
edge(s,y).
edge(x,n).
edge(w,x).
edge(x,w).
edge(x,y).
edge(y,x).
edge(y,z).
edge(z,y).
edge(z,e).
edge(e,z).


%Blocked
blocked(d,e).
blocked(c,h).
blocked(h,c).
blocked(f,g).
blocked(m,g).
blocked(u,k).
blocked(t,z).
blocked(z,t).
blocked(y,x).

%TESTS
% ?- can_move(d,e).
% false.

% ?- can_move(e,d).
% true.

% ?- can_move(f,g).
% false.

% ?- can_move(g,f).
% true.

% ?- can_move(v,o).
% true.

% ?- can_move(o,v).
% true.

% ?- can_move(t,u).
% true.

% ?- can_move(u,t).
% false.

%Rules 

% Reasoning Predicates
can_move(X,Y):- 
    edge(X,Y),
    \+ blocked(X,Y).

reason(X, Y, 'leads directly to exit') :-
    can_move(X, Y),
    can_move(Y, exit),
    Y \== exit,
    !.

reason(X, Y, 'multiple options available') :-
    can_move(X, Y),
    findall(Z, can_move(X, Z), Options),
    length(Options, Count),
    Count > 2.

reason(X, Y, 'only path forward') :-
    can_move(X, Y),
    findall(Z, can_move(X, Z), Options),
    length(Options, 1).

reason(_, exit, 'destination reached').

reason(entrance, _, 'starting from entrance').

reason(X,Y,'path is open'):- 
    can_move(X,Y).

% Recursive Traversal 

%BASE CASE
move(X,Y,Visited,[Y|Visited]):-
    can_move(X,Y),
    reason(X, Y, Reason),
    format('Moving from ~w to ~w.~n', [X,Y]),
    format('  Reason: ~w~n', [Reason]).

%RECUSRIVE CASE
move(X,Y,Visited, Path):-
    can_move(X,Z),
    \+ member(Z,Visited),
    reason(X, Z, Reason),
    format('Exploring from ~w to ~w...~n',[X,Z]),
    format('  Reason: ~w~n', [Reason]),
    move(Z,Y,[Z|Visited],Path).
    

%Putting All Together

find_path(X, Y, Path) :-
    format('~n========================================~n'),
    format('Starting path search from ~w to ~w~n', [X, Y]),
    format('========================================~n~n'),
    move(X, Y, [X], RevPath),
    reverse(RevPath, Path),
    format('========================================~n'),
    format('Path found: ~w~n', [Path]),
    format('========================================~n~n').
