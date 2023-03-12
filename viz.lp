
% node((X,Y)) :- vtx(X,Y).
% edge( ((X,Y),(X2,Y2)) ) :- edge(vtx(X,Y), vtx(X2,Y2)).
% % aspect config
% attr(node,(X,Y),label,".")  :- vtx(X,Y).
% attr(node,(X,Y),pos,@pos(X,Y))  :- vtx(X,Y).
% attr(node,(X,Y),shape,circle)  :- vtx(X,Y).
% attr(node,(X,Y),style,filled)   :- vtx(X,Y).
% attr(node,(X,Y), color, black) :- vtx(X,Y).

constraint_node(V) :- white(V,N).
constraint_node(V) :- black(V,N).
constraint_node(V,N) :- white(V,N).
constraint_node(V,N) :- black(V,N).

% --- Nodes
node((X,Y)) :- vtx(X,Y).
attr(node,(X,Y),width,"0.2") :- vtx(X,Y).
% Fixed position
attr(node,(X,Y),pos,@pos(X,Y)):- vtx(X,Y).
attr(node,(X,Y),shape,"point") :- vtx(X,Y), not constraint_node(vtx(X,Y)).



attr(node, (X,Y), style, filled) :- constraint_node(vtx(X,Y)).
attr(node, (X,Y), label, N)      :- constraint_node(vtx(X,Y),N).
attr(node, (X,Y), width, "0.5")  :- constraint_node(vtx(X,Y)).
attr(node, (X,Y), fontname, "mono bold")  :- constraint_node(vtx(X,Y)).
% white
attr(node, (X,Y), fillcolor, white) :- white(vtx(X,Y), N).
attr(node, (X,Y), textcolor, black) :- white(vtx(X,Y), N).
% black
attr(node, (X,Y), fillcolor, black) :- black(vtx(X,Y), N).
attr(node, (X,Y), fontcolor, white) :- black(vtx(X,Y), N).

% Edges
edge(((X1,Y1),(X2,Y2))) :- edge(vtx(X1,Y1),vtx(X2,Y2)).
attr(edge, ((X1,Y1),(X2,Y2)), penwidth, "3.25") :- edge(vtx(X1,Y1),vtx(X2,Y2)).


