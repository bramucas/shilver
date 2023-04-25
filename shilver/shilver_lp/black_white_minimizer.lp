
% Use only for large problems

% wall whites
edge(vtx(N, Y+1), vtx(N, Y); vtx(N, Y-1), vtx(N, Y)) :- gridsize(N), white(vtx(N, Y), _).

edge(vtx(1, Y+1), vtx(1, Y); vtx(1, Y-1), vtx(1, Y)) :- white(vtx(1, Y), _).

% floor and ceiling whites
edge(vtx(X-1, N), vtx(X, N); vtx(X+1, N), vtx(X, N)) :- gridsize(N), white(vtx(X, N), _).

edge(vtx(X-1, 1), vtx(X, 1); vtx(X+1, 1), vtx(X, 1)) :- white(vtx(X, 1), _).

% wall blacks
edge(vtx(N-1, Y), vtx(N, Y)) :- gridsize(N), black(vtx(N, Y), _).
edge(vtx(2, Y), vtx(1, Y)) :- black(vtx(1, Y), _).

% ceiling and floor blacks
edge(vtx(X, N), vtx(X, N-1)) :- gridsize(N), black(vtx(X, N), _).
edge(vtx(X, 1), vtx(X, 2)) :- black(vtx(X, 1), _).

% corners
edge(vtx(1,1), vtx(1,2); vtx(1,1), vtx(2,1)) :- black(vtx(1,1), _).
edge(vtx(1, N), vtx(1, N-1); vtx(1, N), vtx(2, N)) :- gridsize(N), black(vtx(1,N), _).
edge(vtx(N, 1), vtx(N, 2); vtx(N, 1), vtx(N-1, 1)) :- gridsize(N), black(vtx(N,1), _).
edge(vtx(N, N), vtx(N, N-1); vtx(N, N), vtx(N-1, N)) :- gridsize(N), black(vtx(N,N), _).