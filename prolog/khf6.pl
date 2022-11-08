osszeg_szukites(Trees, oszl(Col, NeededSum), DirsIn, DirsOut) :-
	!,
	zip(Trees, DirsIn, Zip),
	dir_map(col, Zip, Col, ForcedZip, FreeZip, UselessZip),
	length(ForcedZip, LFo),
	(
		(LFo  > NeededSum ) -> (DirsOut = []);
		%(LFo =:= NeededSum) -> (
		%	contstrain free trees (remove ones inside)
		%);
		(
			length(FreeZip, LFr),
			MaxSum is LFo + LFr,
			(
				(MaxSum < NeededSum) -> (DirsOut = []);
				%(MaxSum = NeededSum) -> (
				%	constrain free trees (remove ones outside)
				%);
				DirsOut = [ForcedZip, FreeZip, UselessZip]
			)
		)
	).

%osszeg_szukites(Trees, sor(Row, NeededSum), DirsIn, DirsOut) :-
%	!,
%	zip(Trees, DirsIn, Zip).


dir(col, low, [e], [n,s,w]) :- !.
dir(col, mid, [n,s], [e,w]) :- !.
dir(col, high, [w], [e,n,s]) :- !.

dir(row, low, [s], [e,n,w]) :- !.
dir(row, mid, [e,w], [n,s]) :- !.
dir(row, high, [n], [e,s,w]) :- !.

sel(col, _-TX, TX) :- !.
sel(row, TY-_, TY) :- !.

dir_map(_, [], _, [], [], []) :- !.
dir_map(Dir, [TY-TX-DirsIn|Is], Coord, ForcedTrees, FreeTrees, UselessTrees) :-
	dir_map(Dir, Is, Coord, FoTs, FrTs, UTs),
	sel(Dir, TY-TX, C),
	(
		(C  <  Coord) -> (dir(Dir, low,  Need, NotNeed));
		(C =:= Coord) -> (dir(Dir, mid,  Need, NotNeed));
		(C  >  Coord) -> (dir(Dir, high, Need, NotNeed))
	),
	(contains_any(DirsIn, Need) -> (
		UselessTrees = UTs,
		(contains_any(DirsIn, NotNeed) -> (
			ForcedTrees = FoTs,
			FreeTrees = [TY-TX-DirsIn|FrTs]
		);(
			ForcedTrees = [TY-TX-DirsIn|FoTs],
			FreeTrees = FrTs
		))
	);(
		ForcedTrees = FoTs,
		FreeTrees = FrTs,
		UselessTrees = [TY-TX-DirsIn|UTs]
	)).

contains_any([], []) :- !.
contains_any([X|Xs], Ys) :-
	notrace,
	member(X, Ys) ->
		true;
		contains_any(Xs, Ys).

zip([], [], []) :- !.
zip([Y|Ys], [X|Xs], [Y-X|Zs]) :-
	zip(Ys, Xs, Zs).
