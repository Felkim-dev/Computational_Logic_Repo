:-use_module(library(clpfd)).

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

% Enhanced print
print_row([]) :- nl. %Base Case:New_Line(Salto de Linea)

print_row([H|T]) :- %Recursive Case: Print all the elements of an individual row
    write(H),  %print Number
    write(' '), %Print Space
    print_row(T). %Recurssion with the rest

print_sudoku([]). %Base Case: Without files

print_sudoku([Row|Rows]) :- %Recursive Case: Process row by row
    print_row(Row), %Prints the actual row
    print_sudoku(Rows). %Recurssion with the rest


%Validation that the sudoku is 9x9
validate_sudoku(Rows) :-
    length(Rows, 9), %Columns = 9?
    maplist(validate_row, Rows). % Rows = 9?

validate_row(Row) :- 
    length(Row, 9),
    maplist(valid_cell, Row).

valid_cell(X) :- var(X), !.
valid_cell(X) :- integer(X), X >= 1, X =< 9.

%Puzzles Tested
% Puzzle1 = [
%     [5,3,_,_,7,_,_,_,_],
%     [6,_,_,1,9,5,_,_,_],
%     [_,9,8,_,_,_,_,6,_],
%     [8,_,_,_,6,_,_,_,3],
%     [4,_,_,8,_,3,_,_,1],
%     [7,_,_,_,2,_,_,_,6],
%     [_,6,_,_,_,_,2,8,_],
%     [_,_,_,4,1,9,_,_,5],
%     [_,_,_,_,8,_,_,7,9]
% ], validate_sudoku(Puzzle1),sudoku(Puzzle1), print_sudoku(Puzzle1).

% Puzzle2 = [
%     [_,_,_,2,6,_,7,_,1],
%     [6,8,_,_,7,_,_,9,_],
%     [1,9,_,_,_,4,5,_,_],
%     [8,2,_,1,_,_,_,4,_],
%     [_,_,4,6,_,2,9,_,_],
%     [_,5,_,_,_,3,_,2,8],
%     [_,_,9,3,_,_,_,7,4],
%     [_,4,_,_,5,_,_,3,6],
%     [7,_,3,_,1,8,_,_,_]
% ], validate_sudoku(Puzzle2), sudoku(Puzzle2), print_sudoku(Puzzle2).

% Puzzle3 = [
%     [_,_,_,_,_,_,_,_,_],
%     [_,_,_,_,_,3,_,8,5],
%     [_,_,1,_,2,_,_,_,_],
%     [_,_,_,5,_,7,_,_,_],
%     [_,_,4,_,_,_,1,_,_],
%     [_,9,_,_,_,_,_,_,_],
%     [5,_,_,_,_,_,_,7,3],
%     [_,_,2,_,1,_,_,_,_],
%     [_,_,_,_,4,_,_,_,9]
% ], validate_sudoku(Puzzle3), sudoku(Puzzle3), print_sudoku(Puzzle3).

% Puzzle4 = [
%     [_,_,_,_,_,_,_,_,_],
%     [_,_,_,_,_,3,_,8,5],
%     [_,_,1,_,2,_,_,_,_],
%     [_,_,_,5,_,7,_,_,_],
%     [_,_,4,_,_,_,1,_,_],
%     [5,_,_,_,_,_,_,7,3],
%     [_,_,2,_,1,_,_,_,_],
%     [_,_,_,_,4,_,_,_,9]
% ], validate_sudoku(Puzzle4), sudoku(Puzzle4), print_sudoku(Puzzle4).