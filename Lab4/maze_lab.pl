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

%Rules 

% Reasoning Predicates
can_move(X,Y):- 
    edge(X,Y),
    \+ blocked(X,Y).

count_options(X, Count) :-
    findall(Z, can_move(X, Z), Options),
    length(Options, Count).

reason(X,Y,'path is blocked'):-
    blocked(X,Y).

reason(X,Y,'edge does not exist'):-
    \+ edge(X,Y).

reason(X, Y, 'leads directly to exit') :-
    can_move(X, Y),
    can_move(Y, exit),
    Y \== exit,
    !.

reason(X, Y, 'destination reached') :-
    can_move(X, Y),
    Y == exit,
    !.

reason(entrance, Y, 'starting from entrance') :-
    can_move(entrance, Y),
    !.

reason(X, Y, 'only path forward') :-
    can_move(X, Y),
    count_options(X, 1),
    !.

reason(X, Y, 'bidirectional path available') :-
    can_move(X, Y),
    can_move(Y, X),
    Y \== exit,
    entrance \== X,
    !.

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


%OPTIONALS

% Preferences
preferred_path(s,y).
preferred_path(y,z).
preferred_path(v,o).
preferred_path(a,f).

can_move_preference(X, Y) :-
    can_move(X, Y),
    preferred_path(X, Y).

can_move_preference(X, Y) :-
    can_move(X, Y),
    \+ preferred_path(X, Y).

move_preferred(X, Y, Visited, [Y|Visited]) :-
    can_move_preference(X, Y),
    reason(X, Y, Reason),
    (   preferred_path(X, Y)
    ->  format('Moving from ~w to ~w (PREFERRED)~n', [X, Y])
    ;   format('Moving from ~w to ~w~n', [X, Y])
    ),
    format('Reason: ~w~n~n', [Reason]).

move_preferred(X, Y, Visited, Path) :-
    can_move_preference(X, Z),
    \+ member(Z, Visited),
    reason(X, Z, Reason),
    (   preferred_path(X, Z)
    ->  format('Moving from ~w to ~w (PREFERRED)~n', [X, Z])
    ;   format('Moving from ~w to ~w~n', [X, Z])
    ),
    format('  Reason: ~w~n~n', [Reason]),
    move_preferred(Z, Y, [Z|Visited], Path).

find_path_preferred(X, Y, Path) :-
    format('~n========================================~n'),
    format('Path search WITH PREFERENCES~n'),
    format('========================================~n~n'),
    move_preferred(X, Y, [X], RevPath),
    reverse(RevPath, Path),
    format('========================================~n'),
    format('Final path: ~w~n', [Path]),
    format('========================================~n~n').

%WHY
why(X, Y) :- 
    format(' Edge Analysis:~n'),
    (   edge(X, Y)
    ->  format(' Edge exists: YES~n')
    ;   format(' Edge exists: NO~n')
    ),

    format('~n Blockage Analysis:~n'),
    (   blocked(X, Y)
    ->  format(' Path is blocked: YES~n')
    ;   format(' Path is blocked: NO~n')
    ),

    format('~n Movement Analysis:~n'),
    (   can_move(X, Y)
    ->  format(' Can move: YES~n')
    ;   format(' Can move: NO~n')
    ),

    format('~n Preference Analysis:~n'),
    (   preferred_path(X, Y)
    ->  format(' This path is preferred~n')
    ;   format(' This path is NOT preferred~n')
    ),

    format('~n All Applicable Reasons:~n'),
    findall(R, reason(X, Y, R), Reasons),
    (   Reasons = []
    ->  format('  (No specific reasons found)~n')
    ;   print_reasons_list(Reasons)
    ).

% Auxiliar Predicate to print list
print_reasons_list([]).
print_reasons_list([R|Rest]) :-
    format(' ~w~n', [R]),
    print_reasons_list(Rest).

%Performance Tracking

move_tracking(X, Y, Visited, [Y|Visited], Steps, FinalSteps) :-
    can_move(X, Y),
    FinalSteps is Steps + 1,
    reason(X, Y, Reason),
    format(' Step ~w: Moving from ~w to ~w~n', [FinalSteps, X, Y]),
    format(' Reason: ~w~n~n', [Reason]).

move_tracking(X, Y, Visited, Path, Steps, FinalSteps) :-
    can_move(X, Z),
    \+ member(Z, Visited),
    Steps1 is Steps + 1,  % Increments de counter
    reason(X, Z, Reason),
    format(' Step ~w: Moving from ~w to ~w~n', [Steps1, X, Z]),
    format(' Reason: ~w~n~n', [Reason]),
    move_tracking(Z, Y, [Z|Visited], Path, Steps1, FinalSteps).

find_path_tracking(X, Y, Path, Steps) :-
    format('~n========================================~n'),
    format('Path search WITH Tracking~n'),
    format('========================================~n~n'),
    move_tracking(X, Y, [X], RevPath, 0, Steps),
    reverse(RevPath, Path),

    length(Path, PathLength),
    format('~n Tracking Data: ~n'),
    format('- Total steps taken: ~w~n',[Steps]),
    format('- Path length (nodes): ~w~n',[PathLength]),
    format('- Final Path: ~w~n',[Path]).
