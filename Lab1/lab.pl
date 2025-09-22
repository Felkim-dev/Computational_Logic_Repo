% ============ Family Tree Knowledge Base ==========
% ======= FACTS ========

parent(alberto, miriam).
parent(alberto, javier).
parent(miriam,karina).
parent(javier,nicolas).
parent(karina,leya).
parent(maria,olga).
parent(maria,anita).
parent(anita,felipe).
parent(olga,sofia).
parent(sofia,mateo).

% ========== RULES ======

grandparent(X,Y) :- parent(X,Z), parent(Z,Y).

sibling(X, Y) :- parent(Z, X), parent(Z, Y), X \= Y.

ancestor(X, Y) :- parent(X,Y).
ancestor(X, Y) :- parent(X,Z),ancestor(Z,Y).

% ?- ancestor(alberto,Who).
% Who = miriam ;
% Who = javier ;
% Who = karina ;
% Who = leya ;
% Who = nicolas ;
% false.

% ?- subling(X,Y).
% X = miriam,
% Y = javier ;
% X = javier,
% Y = miriam ;
% X = olga,
% Y = anita ;
% X = anita,
% Y = olga ;
% false.

% ============= FOOD Preferences ==============
%================ FACTS ======================
likes(felipe,bolon).
likes(juan,encebollado).
likes(isamel,sandwiches).
likes(anita,hamburger).
likes(javier,bolon).
likes(adrian,lasagna).
likes(nicolas,bolon).
likes(domenica,sandwiches).

food_friend(X, Y) :- likes(X, Z), likes(Y, Z), X \= Y.

% ?- food_friend(X,Y).
% X = felipe,
% Y = javier ;
% X = felipe,
% Y = nicolas ;
% X = isamel,
% Y = domenica ;
% X = javier,
% Y = felipe ;
% X = javier,
% Y = nicolas ;
% X = nicolas,
% Y = felipe ;
% X = nicolas,
% Y = javier ;
% X = domenica,
% Y = isamel ;
% false.

% ============= Math Utility ====================
%================ Factorial recursively ==========

factorial(0, 1).
factorial(N, F) :- 
    N > 0, 
    N1 is N - 1, 
    factorial(N1,F1),
    F is N * F1.

% ?- factorial(6,F).
% F = 720 ;
% false.

% ========== Sum List ===========

sum_list([], 0).

sum_list([H|T], Sum) :-
    sum_list(T, SumTail),
    Sum is H + SumTail.

% ?- sum_list([2,4,6,8], Sum).
% Sum = 20.

% =================== List Processing =================
% ============== Lenght List ==============

length_list([], 0).

length_list([_|T], Length) :-
    length_list(T, LengthT),
    Length is 1 + LengthT. 

% ?- length_list([a,b,c,d],Len).
% Len = 4.

% =============== Append List ============

append_list([], L, L).

append_list([H|T1], L2, [H|T3]) :- 
    append_list(T1, L2, T3).

% ?- append_list([1,2],[3,4], Result).
% Result = [1, 2, 3, 4].