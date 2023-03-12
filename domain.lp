% Grid
vtx(1..D, 1..D) :- gridsize(D).

% Adyacency
adyacent(vtx(X1, Y1), vtx(X2, Y2)) :- % Vertical
    vtx(X1, Y1), vtx(X2, Y2), % Take any pair or vertex
    X1=X2, Y1!=Y2,            % Same column, but different
    Distance=Y1-Y2,           % Distance in Y coordinate abs(Y1, Y2) <= 1
    Distance>=-1, Distance<=1.

adyacent(vtx(X1, Y1), vtx(X2, Y2)) :- % Horizontal
    vtx(X1, Y1), vtx(X2, Y2), % Take any pair or vertex
    Y1=Y2, X1!=X2,            % Same column, but different
    Distance=X1-X2,           % Distance in X coordinate abs(X1, X2) <= 1
    Distance>=-1, Distance<=1.
