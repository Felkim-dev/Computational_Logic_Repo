%Part 1 - Basics
edge(a,b).
edge(b,c).
edge(a,d).
edge(d,c).

%Path definition
path(X,Y):-edge(X,Y).
path(X,Y):-edge(X,Z),path(Z,Y).

%CONSOLE OUTPUT
% ?- path(a,c).
% true .

% ?- path(b,a).
% false.

%Part 2 - Cycles
edge(c,a).

%Handling Cycles
path(X,Y):-path(X,Y,[]).
path(X,Y,_):-edge(X,Y).
path(X,Y,Visited):-
    edge(X,Z),
    \+ member(Z,Visited),
    path(Z,Y,[X|Visited]).

%CONSOLE OUTPUT
%Whithout List
% ?- path(a,c).
% true ;
% true ;
% true ;
% true ;
% true ;
% true ;
% true ;

%With List
% ?- path(a,c,[a]).
% true ;
% true ;
% false.

%Part 3 - Find all
% Collect all paths with the actual route (list of nodes)
path_with_route(Start, End, Route) :-
    path_with_route_helper(Start, End, [Start], Route).

path_with_route_helper(End, End, Visited, Route) :-
    reverse(Visited, Route).

path_with_route_helper(Current, End, Visited, Route) :-
    edge(Current, Next),
    \+ member(Next, Visited),
    path_with_route_helper(Next, End, [Next|Visited], Route).

% CONSOLE OUTPUT
% ?- path_with_route(a,c,Paths).
% Paths = [a, b, c] ;
% Paths = [a, d, c] ;
% false.