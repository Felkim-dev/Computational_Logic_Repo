:-use_module(library(clpfd)).

add_10(X, Y) :-
    X in 1..9, %Domain
    Y in 1..9,  %Domain
    X + Y #= 10, %Constraint
    label([X, Y]). %Looks for solutions that satifies de restriction

% This program shows all the numbers X and Y that added results 10 if X and Y are between 1 and 9 (Domain)
