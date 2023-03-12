

% Generate edges between adyacent edges
{ edge(vtx(X1, Y1), vtx(X2, Y2)) } :- 
    adyacent(vtx(X1, Y1), vtx(X2, Y2)),
    X1<=X2, Y1<=Y2,           % Delete repetition: leftmost&downmost vtx first
    (X1, Y1)!=(X2, Y2). 


% Included vertex alias
included(A;B) :- edge(A,B).

% Undirected_edge alias
undirected_edge(A,B; B,A) :- edge(A,B).

% Line cros Vtx straightly
straight(Vtx) :- 
    undirected_edge(Vtx, vtx(X1, Y1)),
    undirected_edge(Vtx, vtx(X2, Y2)),
    Y1=Y2, X1!=X2.
straight(Vtx) :- 
    undirected_edge(Vtx, vtx(X1, Y1)),
    undirected_edge(Vtx, vtx(X2, Y2)),
    Y1!=Y2, X1=X2.

% Line makes an elbow on Vtx
elbow(Vtx) :- 
    undirected_edge(Vtx, vtx(X1, Y1)),
    undirected_edge(Vtx, vtx(X2, Y2)),
    Y1!=Y2, X1!=X2.

% A Vtx is part of the arm of another if is connected with it by a straight line
straightly_connected(Vtx, StrConnected) :-
    undirected_edge(Vtx, StrConnected).
straightly_connected(Vtx, StrConnected) :-
    straightly_connected(Vtx, MiddleVtx),
    straight(MiddleVtx),
    undirected_edge(MiddleVtx, StrConnected),
    Vtx!=StrConnected.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Connected
connected(Vtx1, Vtx2) :- undirected_edge(Vtx1, Vtx2).

% Connected transitivity
connected(Vtx1, Vtx3) :- 
    connected(Vtx1, Vtx2),
    connected(Vtx2, Vtx3),
    Vtx1!=Vtx3.


% Any selected edge must be connected with the rest
:- included(Vtx1), included(Vtx2), Vtx1!=Vtx2, not connected(Vtx1, Vtx2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Each vertex has to have exactly two incoming edges
% In other words, it should be connected with just two vertex
:- 2!=#count{DirectlyConnected: undirected_edge(Vtx, DirectlyConnected)}, included(Vtx).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- white(Vtx,N), not included(Vtx).
:- black(Vtx,N), not included(Vtx).

% Any white/black Vtx should be included and
%  - white must be straight
%  - black must be elbows
:- white(Vtx,N), included(Vtx), not straight(Vtx).
:- black(Vtx,N), included(Vtx), not elbow(Vtx).

% White points
:- white(Vtx,N), N!=#count{StrConnected:straightly_connected(Vtx, StrConnected)}.

% Black points
:- black(Vtx,N), N!=#count{StrConnected:straightly_connected(Vtx, StrConnected)}.


#show edge/2.