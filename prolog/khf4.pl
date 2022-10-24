% :- type parcMutató ==   int-int.          % egy parcella helyét meghatározó egészszám-pár
% :- type fák        ==   list(parcMutató). % a fák helyeit tartalmazó lista
% :- type irány    --->   n                 % észak 
%                       ; e                 % kelet 
%                       ; s                 % dél   
%                       ; w.                % nyugat
% :- type sHelyek    ==   list(irany).      % a fákhoz tartozó sátrak irányát megadó lista
% :- type bool       ==   int               % csak 0 vagy 1 lehet
% :- type boolMx     ==   list(list(bool)). % a sátrak helyét leíró 0-1 mátrix
% :- pred satrak_mx(parcMutató::in,         % NM
%                   fák::in,                % Fs
%                   sHelyek::in,            % Ss
%                   boolMx::out).           % Mx
satrak_mx(N-M, Trees, Dirs, Mx) :- 
	zip(Trees, Dirs, TreeAndDirZip),
	make_tent_coords(TreeAndDirZip, TentCoords, N-M),
	generate_matrix(N-M, TentCoords, Mx, 1).

% Zips two lists together.
zip([], [], []) :- !.
zip([H1|T1], [H2|T2], [H1-H2|T]) :-
	zip(T1, T2, T).

% Generates a list of coordinates for tents based on the trees and the tent directions.
% Also validates the tent locations to be within the bounds of the map,
% and that there are no tents on the same spot.
make_tent_coords([], [], _).
make_tent_coords([TH|TT], [Y-X|TentCoordsRest], N-M) :-
	TY-TX-Dir = TH,
	(
		(Dir = n) -> Y is TY-1, X is TX;
		(Dir = e) -> Y is TY, X is TX + 1;
		(Dir = s) -> Y is TY+1, X is TX;
		(Dir = w) -> Y is TY, X is TX - 1
	),
	Y > 0, X > 0, Y =< N, X =< M,
	make_tent_coords(TT, TentCoordsRest, N-M),
	\+ member(Y-X, TentCoordsRest).

% Generates a matrix of 0s and 1s based on the tent coordinates.
generate_matrix(N-M, TentCoords, [Row|MatrixRest], Y) :-
	Y1 is Y + 1,
	(Y1 =< N ->
		generate_matrix(N-M, TentCoords, MatrixRest, Y1);
		MatrixRest = []),
	generate_row(M, TentCoords, Y-1, Row).

% Generates a list as a row for the matrix made of 0s and 1s based on the tent coordinates.
generate_row(M, TentCoords, Y-X, Row) :-
	X1 is X+1,
	(X1 =< M ->
		generate_row(M, TentCoords, Y-X1, RowRest);
		RowRest = []),
	(member(Y-X, TentCoords) ->
		Row = [1|RowRest];
		Row = [0|RowRest]).
