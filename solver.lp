
% Any vertex can be included or not
{included(vtx(X,Y))} :- vtx(X,Y).

% Generate edges between adyacent edges
2{ edge(V1, V2): adyacent(V1, V2)} 2 :- included(V1).

% edge/2 is undirected
edge(V2,V1) :- edge(V1,V2).
% 
included(A;B) :- edge(A,B).

% Line cross Vtx straightly
straight(Vtx) :- 
    edge(Vtx, vtx(X1, Y1)),
    edge(Vtx, vtx(X2, Y2)),
    Y1=Y2, X1!=X2.
straight(Vtx) :- 
    edge(Vtx, vtx(X1, Y1)),
    edge(Vtx, vtx(X2, Y2)),
    Y1!=Y2, X1=X2.

% Line makes an elbow on Vtx
elbow(Vtx) :- 
    edge(Vtx, vtx(X1, Y1)),
    edge(Vtx, vtx(X2, Y2)),
    Y1!=Y2, X1!=X2.

% A Vtx is part of the arm of another if is connected with it by a straight line
straightly_connected(Vtx, StrConnected) :-
    edge(Vtx, StrConnected).
straightly_connected(Vtx, StrConnected) :-
    straightly_connected(Vtx, MiddleVtx),
    straight(MiddleVtx),
    edge(MiddleVtx, StrConnected),
    Vtx!=StrConnected.

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Connected
connected(Vtx1, Vtx2) :- edge(Vtx1, Vtx2).

% Connected transitivity
connected(Vtx1, Vtx3) :- 
    connected(Vtx1, Vtx2),
    connected(Vtx2, Vtx3),
    Vtx1!=Vtx3.


% % Any selected edge must be connected with the rest
:- included(Vtx1), included(Vtx2), Vtx1!=Vtx2, not connected(Vtx1, Vtx2).

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % Each vertex has to have exactly two incoming edges
% % In other words, it should be connected with just two vertex
% :- 2!=#count{DirectlyConnected: undirected_edge(Vtx, DirectlyConnected)}, included(Vtx).


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