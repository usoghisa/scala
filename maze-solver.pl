%% To lauch  use consult('maze-solver.pl.').
%% solve(From, To, Path)
%% which, given locations From and To, finds a Path going from From to To.
%% From and To are given as two element lists, and Path should be a list of
%% two-element lists. The first element of Path should be From, and the last
%% element should be To. Moves can be made horizontally or vertically, but
%% not diagonally.
%% For example,
%% solve([3,2], [2,6], [[3,2], [3,3], [2,3], [1,3], [1,4], [1,5], [1,6], [2,6]]).
%% ---
u(m,1).
mazeSize(3, 3).
barrier(2, 2).
barrier(3, 2).

%% We start by defining the database of facts which describe the paths between points
path([1,1],[1,2]).
path([1,2],[1,3]).
path([2,3],[3,3]).
route(X,X).
route(X,Y) :- path(X,Z),
			\+ barrier(X, Y),
			route(Z,Y) .

%% CALL route(X,Y).
