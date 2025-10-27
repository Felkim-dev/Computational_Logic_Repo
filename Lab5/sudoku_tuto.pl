:-use_module(library(clpfd)).

add_10(X, Y) :-
    X in 1..9, %Domain
    Y in 1..9,  %Domain
    X + Y #= 10, %Constraint
    label([X, Y]). %Looks for solutions that satifies de restriction

% This program shows all the numbers X and Y that added results 10 if X and Y are between 1 and 9 (Domain)

%Sudoku Solver
sudoku(Rows):-
    append(Rows,Vars), % Convert a list of lists in a 1 dimension List
    Vars ins 1..9, %All the varibles need to be between 1 and 9
    maplist(all_different,Rows), %All the Rows need to have different numbers.
    transpose(Rows,Columns), %Transpose/2 to obtain the columns
    maplist(all_different,Columns), %All the columns need to have different numbers
    blocks(Rows), %Each 3x3 blocks need to have different numbers
    maplist(label,Rows). %Find croncrete values.

blocks([]). %Base case without rows.

%Recursive Case: Process 3 rows ath the time
blocks([A,B,C|Rest]):-
    blocks3(A,B,C), %Process 3 rows
    blocks(Rest).   %Then continue with the rest

blocks3([],[],[]).  %Divides each row in groups of 3

blocks3([A1,A2,A3|R1],[B1,B2,B3|R2],[C1,C2,C3|R3]):-
    all_different([A1,A2,A3,B1,B2,B3,C1,C2,C3]), %This block needs to have all different numbers
    blocks3(R1,R2,R3). %Continue with the next 3 elements


print_sudoku(Rows) :-
    maplist(writeln, Rows). %Print rows

% Puzzle = [
%         [5,3,_,_,7,_,_,_,_],
%         [6,_,_,1,9,5,_,_,_],
%         [_,9,8,_,_,_,_,6,_],
%         [8,_,_,_,6,_,_,_,3],
%         [4,_,_,8,_,3,_,_,1],
%         [7,_,_,_,2,_,_,_,6],
%         [_,6,_,_,_,_,2,8,_],
%         [_,_,_,4,1,9,_,_,5],
%         [_,_,_,_,8,_,_,7,9]
%         ], sudoku(Puzzle), print_sudoku(Puzzle).

% Solution

% [5,3,4,6,7,8,9,1,2]
% [6,7,2,1,9,5,3,4,8]
% [1,9,8,3,4,2,5,6,7]
% [8,5,9,7,6,1,4,2,3]
% [4,2,6,8,5,3,7,9,1]
% [7,1,3,9,2,4,8,5,6]
% [9,6,1,5,3,7,2,8,4]
% [2,8,7,4,1,9,6,3,5]
% [3,4,5,2,8,6,1,7,9]