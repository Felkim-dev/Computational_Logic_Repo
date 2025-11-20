:-use_module(library(clpfd)).

%Adjacence definition for Australia
adjacent(wa, nt).
adjacent(wa, sa).
adjacent(nt, sa).
adjacent(nt, q).
adjacent(sa, q).
adjacent(sa, nsw).
adjacent(sa, v).
adjacent(q, nsw).
adjacent(nsw, v).

regions_au([wa,nt,sa,q,nsw,v]).

edges_au(Edges) :-
% Findall will recolect all the adjacent countries,
% Findall use a template (A-B(Pair)), that have a solution (adjacent(A,B)) inserting them into a list (Edges)
    findall(A-B, adjacent(A, B), Edges). 
    
% color_names([red,green,blue,yellow]).

color_name(1, red).
color_name(2, green).
color_name(3, blue).
color_name(4, yellow).

color_map(Regions,Edges,K,Vars):-

    % Create variables with same length as regions
    same_length(Regions, Vars),

    %Each variable could be a value between 1 and K
    Vars ins 1..K,

    apply_edge_constraints(Regions,Vars,Edges),

    % Use ffc (first-fail-choice) labeling strategy
    labeling([ffc], Vars).



apply_edge_constraints(_,_,[]).
apply_edge_constraints(Regions,Vars,[R1-R2|RestEdges]):-
    
    %Find the index in the list for R1 and R2 in the list Regions
    nth0(Idx1, Regions, R1),
    nth0(Idx2, Regions, R2),

    %Use the known indexes to save the variable and apply the constraint
    nth0(Idx1, Vars, Var1),
    nth0(Idx2, Vars, Var2),

    %Constraint
    Var1 #\= Var2,

    apply_edge_constraints(Regions,Vars,RestEdges).

% Generic predicate to find minimum colors needed
min_colors(Regions, Edges, MaxK, MinK, Vars) :-
    % Generate K values from 1 to MaxK
    between(1, MaxK, K),
    % Try to color the map with K colors
    color_map(Regions, Edges, K, Vars),
    % If successful, bind MinK to current K
    MinK = K,
    % Cut to stop searching for larger K values
    !.

% Convenience predicate for Australia
min_colors_au(MaxK, MinK, Vars) :-
    regions_au(Rs),
    edges_au(Es),
    min_colors(Rs, Es, MaxK, MinK, Vars).

    
pretty_color_by_region([],[]).
pretty_color_by_region([Region|Regions],[Variable|Variables]):-
    
    color_name(Variable,ColorName),

    format('~w = ~w~n', [Region,ColorName]),

    pretty_color_by_region(Regions,Variables).

colorize_au(K, Vars):-
    regions_au(Regions),
    edges_au(Edges),
    color_map(Regions, Edges, K, Vars).

test_au_3 :-
    writeln('Testing Australia with 3 colors:'),
    colorize_au(3, Vars),
    regions_au(Regions),
    pretty_color_by_region(Regions, Vars).

% Test con 4 colores
test_au_4 :-
    writeln('Testing Australia with 4 colors:'),
    colorize_au(4, Vars),
    regions_au(Regions),
    pretty_color_by_region(Regions, Vars).

test_au_min :-
    writeln('Finding minimum colors for Australia:'),
    min_colors_au(6, MinK, Vars),
    format('Minimum colors needed: ~w~n~n', [MinK]),
    regions_au(Regions),
    pretty_color_by_region(Regions, Vars).
