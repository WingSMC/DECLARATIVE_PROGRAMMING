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

% TODO: Signature
iranylistak(N-M, Trees, AvailableDirs) :-
	iranylistak_h(N-M, Trees, Result, Trees),
	(member([], Result) ->
		AvailableDirs = [];
		AvailableDirs = Result).

sator_szukites(Trees, I, DirsIn, DirsOut) :- !.

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

test_coord(N-M, Y-X, Dir, AllTrees) :-
	convert_to_coord(Y-X, Dir, Y1-X1),
	1 =< Y1,
	1 =< X1,
	Y1 =< N,
	X1 =< M,
	\+ member(Y1-X1, AllTrees).

convert_to_coords([], _, []) :- !.
convert_to_coords([Tree|TRest], [Dir|DRest], [Coord|CRest]) :-
	convert_to_coord(Tree, Dir, Coord),
	convert_to_coords(TRest, DRest, CRest).

convert_to_coord(Y-X, Dir, Y1-X1) :-
	Dir = n -> Y1 is Y-1, X1 is X;
	Dir = e -> Y1 is Y,   X1 is X+1;
	Dir = s -> Y1 is Y+1, X1 is X;
	Dir = w -> Y1 is Y,   X1 is X-1.

get_and_test_nth_tree([TH|_], [DH|_], 0, Coord) :-
	!,
	length(DH, 1),
	[Dir] = DH,
	convert_to_coord(TH, Dir, Coord).
get_and_test_nth_tree([_|TRest], [_|DRest], N, Coord) :-
	N1 is N - 1,
	get_and_test_nth_tree(Trest, DRest, N1, Coord).
