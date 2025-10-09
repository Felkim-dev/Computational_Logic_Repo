%Maze Definition

%a is the entrance node
%i is the exit node

edge(a,b). 
edge(b,c).
edge(c,d).
edge(d,e).
edge(e,f).
edge(f,g).
edge(g,h).
edge(h,s).
edge(s,i).
edge(c,j).
edge(j,k).
edge(k,l).
edge(l,m).
edge(m,n).
edge(m,o).
edge(o,p).
edge(d,q).
edge(g,r).
edge(r,s).
edge(c,l).
edge(n,t).
edge(t,g).

% Colect and shows the paths
path_route(Start, End, Route) :-
    path_route_helper(Start, End, [Start], Route).

path_route_helper(End, End, Visited, Route) :-
    reverse(Visited, Route).

path_route_helper(Current, End, Visited, Route) :-
    edge(Current, Next),
    \+ member(Next, Visited),
    path_route_helper(Next, End, [Next|Visited], Route).

% OUTPUT:
% ?- path_route(a, i, Route).
% Route = [a,b,c,d,e,f,g,h,s,i] ;
% Route = [a,b,c,d,e,f,g,r,s,i] ;
% Route = [a,b,c,j,k,l,m,n,t,g,h,s,i] ;
% Route = [a,b,c,j,k,l,m,n,t,g,r,s,i] ;
% Route = [a,b,c,l,m,n,t,g,h,s,i] ;
% Route = [a,b,c,l,m,n,t,g,r,s,i] ;
% false.