% ============== Facts ====================

parent(john, mary).
parent(mary, susan).
parent(mary, bob).
parent(susan, alice).

% ?- parent(john,mary).
% true.

% ?- parent(mary,Who).
% Who = susan ;
% Who = bob.

% ============== Rules =====================

grandparent(X,Y) :- parent(X,Z),parent(Z,Y).

% ?- grandparent(john,susan).
% true.

% ?- grandparent(john,Who).
% Who = susan ;
% Who = bob.

% ============ Variables & Backtracking ========

likes(mary,pizza).
likes(mary,pasta).
likes(jhon,pizza).

% ?- likes(mary,Food).
% Food = pizza ;
% Food = pasta.

% =============== Built-ins =============

% ?- X is 2+3.
% X = 5.

% ?- 3=3.
% true.

% =============== LIST ==================
member(X, [X|_]).
member(X, [_|T]) :- member(X,T).

% ?- member(2,[1,2,3,4]).
% true ;
% false.

% ?- member(X,[a,b,c]).
% X = a ;
% X = b ;
% X = c.