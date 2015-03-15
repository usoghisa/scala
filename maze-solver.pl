%% To lauch  use consult('maze-solver.pl.').
%% solve(From, To, Path)
%% which, given locations From and To, finds a Path going from From to To.
%% From and To are given as two element lists, and Path should be a list of
%% two-element lists. The first element of Path should be From, and the last
%% element should be To. Moves can be made horizontally or vertically, but
%% not diagonally.
%% For example,
%% solve([3,2], [2,6], [[3,2], [3,3], [2,3], [1,3], [1,4], [1,5], [1,6], [2,6]]).
%% -------------------------------------------------------------
% consult('maze.pl').
% CALL ?- solve(From, To, Path). 
% use semicolon ; to see the path

path([0,0], [1,0],[2,0]).
path([2,0], [2,1],[2,2]).
path([2,2], [2,3]).

solve(From, To, Path):-
  solve(From, To, [], Path).

solve(X, X, T, T).
solve(X, Y, T, NT) :-
    (path(X,Z) ; path(Z, X)),
    \+ member(Z,T),
    solve(Z, Y, [Z|T], NT).
	
