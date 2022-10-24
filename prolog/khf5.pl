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
iranylistak(N-M, Trees, AvailableDirs) :-
	iranylistak_h(N-M, Trees, Result, Trees),
	(member([], Result) ->
		AvailableDirs = [];
		AvailableDirs = Result).

iranylistak_h(  _,              [],                            [],        _) :- !.
iranylistak_h(N-M, [TH | TreeRest], [AvailableDirs | OutDirsRest], AllTrees) :-
	find_dirs(N-M, TH, [e, n, s, w], AvailableDirs, AllTrees),
	iranylistak_h(N-M, TreeRest, OutDirsRest, AllTrees).

find_dirs(_  ,   _,              [],            [],        _) :- !.
find_dirs(N-M, Y-X, [DH | DirsRest], AvailableDirs, AllTrees) :-
	find_dirs(N-M, Y-X, DirsRest, AvailableDirsRest, AllTrees),
	(test_coord(N-M, Y-X, DH, AllTrees) ->
		AvailableDirs = [DH | AvailableDirsRest];
		AvailableDirs = AvailableDirsRest).

test_coord(N-M, Y-X, Dir, AllTrees) :-
	notrace,
	(
		Dir = n -> Y1 is Y-1, X1 is X;
		Dir = e -> Y1 is Y, 	X1 is X+1;
		Dir = s -> Y1 is Y+1, X1 is X;
		Dir = w -> Y1 is Y, 	X1 is X-1
	),
	1 =< Y1,
	1 =< X1,
	Y1 =< N,
	X1 =< M,
	\+ member(Y1-X1, AllTrees).
