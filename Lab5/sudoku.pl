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
