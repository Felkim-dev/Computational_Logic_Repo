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

edges(Edges) :-
% Findall will recolect all the adjacent countries,
% Findall use a template (A-B(Pair)), that have a solution (adjacent(A,B)) inserting them into a list (Edges)
    findall(A-B, adjacent(A, B), Edges). 
    
% color_names([red,green,blue,yellow]).

color_name(1, red).
color_name(2, green).
color_name(3, blue).
color_name(4, yellow).

map_color(Vars,Edges,K):-

    %Each variable could be a value between 1 and K
    Vars ins 1..K,

    apply_edge_constraints(Vars,Edges),

    label(Vars).



apply_edge_constraints(_,[]).
apply_edge_constraints(Vars,[R1-R2|RestEdges]):-
    
    regions_au(Regions),

    %Find the index in the list for R1 and R2 in the list Regions
    nth0(Idx1, Regions, R1),
    nth0(Idx2, Regions, R2),

    %Use the known indexes to save the variable and apply the constraint
    nth0(Idx1, Vars, Var1),
    nth0(Idx2, Vars, Var2),

    %Constraint
    Var1 #\= Var2,

    apply_edge_constraints(Vars,RestEdges).

colorize_au(K,Vars):-
    regions_au(Regions),
    edges(Edges),

    length(Regions, N),
    length(Vars, N),

    map_color(Vars,Edges,K).

    
pretty_color_by_region([],[]).
pretty_color_by_region([Region|Regions],[Variable|Variables]):-
    
    color_name(Variable,ColorName),

    format('~w = ~w~n', [Region,ColorName]),

    pretty_color_by_region(Regions,Variables).
    
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