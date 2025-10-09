% Graph edges
edge(a, b).
edge(a, c).
edge(b, d).
edge(c, d).
edge(c, e).
edge(e, f).

% path(Start, End, Path): finds a valid path from Start to End
path(Start, End, Path) :-
    path_helper(Start, End, [Start], Path).

path_helper(End, End, Visited, Path) :-
    reverse(Visited, Path).

path_helper(Current, End, Visited, Path) :-
    edge(Current, Next),
    \+ member(Next, Visited),
    path_helper(Next, End, [Next|Visited], Path).

% shortest_path(Start, End, Shortest): finds the shortest path
shortest_path(Start, End, Shortest) :-
    findall(Path, path(Start, End, Path), Paths),
    shortest_in_list(Paths, Shortest).

shortest_in_list([Path], Path).
shortest_in_list([Path1, Path2|Rest], Shortest) :-
    length(Path1, L1),
    length(Path2, L2),
    (L1 =< L2 ->
        shortest_in_list([Path1|Rest], Shortest)
    ;
        shortest_in_list([Path2|Rest], Shortest)
    ).

%ADRIAN FELIPE QUILUMBANGO ESCOBAR