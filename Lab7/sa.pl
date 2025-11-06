:-use_module(library(clpfd)).

%Adjacence definition from South America
adjacent_sa(ar, bo).
adjacent_sa(ar, br).
adjacent_sa(ar, cl).
adjacent_sa(ar, py).
adjacent_sa(ar, uy).
adjacent_sa(bo, br).
adjacent_sa(bo, cl).
adjacent_sa(bo, py).
adjacent_sa(bo, pe).
adjacent_sa(br, co).
adjacent_sa(br, gy).
adjacent_sa(br, gfr).
adjacent_sa(br, py).
adjacent_sa(br, pe).
adjacent_sa(br, su).
adjacent_sa(br, uy).
adjacent_sa(br, ve).
adjacent_sa(cl, pe).
adjacent_sa(co, ec).
adjacent_sa(co, pe).
adjacent_sa(co, ve).
adjacent_sa(ec, pe).
adjacent_sa(gy, su).
adjacent_sa(gy, ve).
adjacent_sa(gfr, su).

regions_sa([ar, bo, br, cl, co, ec, gy, gfr, py, pe, su, uy, ve]).

edges_sa(Edges) :-
% Findall will recolect all the adjacent countries,
% Findall use a template (A-B(Pair)), that have a solution (adjacent(A,B)) inserting them into a list (Edges)
    findall(A-B, adjacent_sa(A, B), Edges). 


% color_names([red,green,blue,yellow]).

color_name(1, red).
color_name(2, green).
color_name(3, blue).
color_name(4, yellow).

map_color(Vars,Edges,K):-

    %Each variable could be a value between 1 and K
    Vars ins 1..K,

    apply_edge_constraints(Vars,Edges),

    labeling([ff],Vars). %Tested with ffc,ff,min,max,



apply_edge_constraints(_,[]).
apply_edge_constraints(Vars,[R1-R2|RestEdges]):-
    
    regions_sa(Regions),

    %Find the index in the list for R1 and R2 in the list Regions
    nth0(Idx1, Regions, R1),
    nth0(Idx2, Regions, R2),

    %Use the known indexes to save the variable and apply the constraint
    nth0(Idx1, Vars, Var1),
    nth0(Idx2, Vars, Var2),

    %Constraint
    Var1 #\= Var2,

    apply_edge_constraints(Vars,RestEdges).

colorize_sa(K,Vars):-
    regions_sa(Regions),
    edges_sa(Edges),

    length(Regions, N),
    length(Vars, N),

    map_color(Vars,Edges,K).

    
pretty_color_by_region([],[]).
pretty_color_by_region([Region|Regions],[Variable|Variables]):-
    
    color_name(Variable,ColorName),

    format('~w = ~w~n', [Region,ColorName]),

    pretty_color_by_region(Regions,Variables).

% There is no way to coloring the map with 3 colores
test_sa_3 :-
    writeln('Testing South America with 3 colors:'),
    colorize_sa(3, Vars),
    regions_sa(Regions),
    pretty_color_by_region(Regions, Vars).

% Test with 4 colors
test_sa_4 :-
    writeln('Testing South America with 4 colors:'),
    colorize_sa(4, Vars),
    regions_sa(Regions),
    pretty_color_by_region(Regions, Vars).