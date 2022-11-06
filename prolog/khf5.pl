% :- type parcMutató ==    int-int.          % egy parcella helyét meghatározó egészszám-pár
% :- type fák ==           list(parcMutató). % a fák helyeit tartalmazó lista
% :- type irány    --->    n                 % észak 
%                        ; e                 % kelet 
%                        ; s                 % dél   
%                        ; w.                % nyugat
% :- type iránylista ==    list(irany).      % egy adott fához rendelt sátor
%                                            % lehetséges irányait megadó lista
% :- type iránylisták ==   list(iránylista). % az összes fa iránylistája
% :- pred iranylistak(parcMutató::in         % NM
%                     fák::in,               % Fs
%                     iránylisták::out)      % ILs
% :- pred sator_szukites(fák::in,            % Fs
%                        int::in,            % I
%                        iránylisták::in,    % ILs0
%                        iránylisták::out)   % ILs[[]]

iranylistak(N-M, Trees, ILs) :-
	iranylistak_h(N-M, Trees, Result, Trees),
	(member([], Result) ->
		ILs = [];
		ILs = Result).

sator_szukites(Trees, I, DirsIn, ILs) :-
	get_and_test_nth_tree(Trees, DirsIn, I, TentBoundry),
	test_trees(Trees, DirsIn, TentBoundry, DirsOut, I),
	(\+ member([], DirsOut) ->
		ILs = DirsOut;
		ILs = []).

iranylistak_h(_, [], [], _) :- !.
iranylistak_h(N-M, [TH | TreeRest], [AvailableDirs | OutDirsRest], AllTrees) :-
	find_dirs(N-M, TH, [e, n, s, w], AvailableDirs, AllTrees),
	iranylistak_h(N-M, TreeRest, OutDirsRest, AllTrees).

find_dirs(_, _, [], [], _) :- !.
find_dirs(Size, Tree, [DH | DirsRest], AvailableDirs, AllTrees) :-
	find_dirs(Size, Tree, DirsRest, AvailableDirsRest, AllTrees),
	(test_coord(Size, Tree, DH, AllTrees) ->
		AvailableDirs = [DH | AvailableDirsRest];
		AvailableDirs = AvailableDirsRest).

convert_to_coords([], _, []) :- !.
convert_to_coords([Tree|TRest], [Dir|DRest], [Coord|CRest]) :-
	convert_to_coord(Tree, Dir, Coord),
	convert_to_coords(TRest, DRest, CRest).

convert_to_coord(Y-X, Dir, Y1-X1) :-
	Dir = n -> Y1 is Y-1, X1 is X;
	Dir = e -> Y1 is Y,   X1 is X+1;
	Dir = s -> Y1 is Y+1, X1 is X;
	Dir = w -> Y1 is Y,   X1 is X-1.

get_and_test_nth_tree([TH|_], [DH|_], 1, Y1-Y2-X1-X2) :-
	!,
	length(DH, 1),
	[Dir] = DH,
	convert_to_coord(TH, Dir, Y-X),
	Y1 is Y - 1,
	Y2 is Y + 1,
	X1 is X - 1,
	X2 is X + 1.

get_and_test_nth_tree([_|TRest], [_|DRest], N, Boundry) :-
	N1 is N - 1,
	get_and_test_nth_tree(TRest, DRest, N1, Boundry).

is_tree_near_boundry(Y-X, Y1-Y2-X1-X2) :-
	Y >= Y1 - 1,
	Y =< Y2 + 1,
	X >= X1 - 1,
	X =< X2 + 1.
is_tent_in_boundry(Y-X, Y1-Y2-X1-X2) :-
	Y >= Y1,
	Y =< Y2,
	X >= X1,
	X =< X2.
test_coord(N-M, Y-X, Dir, AllTrees) :-
	convert_to_coord(Y-X, Dir, Y1-X1),
	1 =< Y1,
	1 =< X1,
	Y1 =< N,
	X1 =< M,
	\+ member(Y1-X1, AllTrees).

test_trees([], _, _, [], _) :- !.
test_trees([_|TRest], [D|DRest], Boundry, [D|DirsOutRest], 1) :-
	!, test_trees(TRest, DRest, Boundry, DirsOutRest, 0).
test_trees([Tree|TRest], [Dirs|DRest], Boundry, DirsOut, N) :-
	N1 is N - 1,
	test_trees(TRest, DRest, Boundry, DirsOutRest, N1),
	(is_tree_near_boundry(Tree, Boundry) ->
		(
			test_dirs(Tree, Dirs, Boundry, TDirsOut),
			DirsOut = [TDirsOut | DirsOutRest]
		);
		DirsOut = [Dirs|DirsOutRest]).

test_dirs(_, [], _, []) :- !.
test_dirs(Tree, [Dir|DRest], Boundry, DirsOut) :-
	convert_to_coord(Tree, Dir, Y-X),
	test_dirs(Tree, DRest, Boundry, DirsOutRest),
	(is_tent_in_boundry(Y-X, Boundry) ->
		DirsOut = DirsOutRest;
		DirsOut = [Dir | DirsOutRest]).
