osszeg_szukites(Trees, oszl(Col, NeededSum), DirsIn, DirsOut) :-
	!, helper(col, Col, NeededSum, Trees, DirsIn, DirsOut).
osszeg_szukites(Trees, sor(Row, NeededSum), DirsIn, DirsOut) :-
	!, helper(row, Row, NeededSum, Trees, DirsIn, DirsOut).

helper(Dir, Coord, NeededSum, Trees, DirsIn, DirsOut) :-
	zip(Trees, DirsIn, Zip),
	dir_map(Dir, Zip, Coord, ForcedZip, FreeZip, UselessZip),
	length(ForcedZip, LFo),
	length(FreeZip, LFr),
	MaxSum is LFo + LFr,
	(
		(LFo  >  NeededSum; MaxSum  <  NeededSum) -> (DirsOut = []);
		(
			(
				(LFo =:= NeededSum) -> constrain_from_coord(Dir, Coord, FreeZip, ConstrainedFreeZip);
				(MaxSum =:= NeededSum) -> constrain_to_coord(Dir, Coord, FreeZip, ConstrainedFreeZip);
				(fail)
			),
			union3_sort_unzip(ConstrainedFreeZip, ForcedZip, UselessZip, DirsOut)
		)
	).



dir_map(_, [], _, [], [], []) :- !.
dir_map(Dir, [TY-TX-DirsIn|Is], Coord, ForcedTrees, FreeTrees, UselessTrees) :-
	dir_map(Dir, Is, Coord, FoTs, FrTs, UTs),
	sel(Dir, TY-TX, C),
	(
		(C =:= Coord - 1) -> (dir(Dir, low,  Need, NotNeed));
		(C =:= Coord    ) -> (dir(Dir, mid,  Need, NotNeed));
		(C =:= Coord + 1) -> (dir(Dir, high, Need, NotNeed));
		Need = [] % will never match
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

constrain_to_coord(_, _, [], []) :- !.
constrain_to_coord(Dir, Coord, [X-Y-Dirs|Is], [X-Y-OutDirs|Os]) :-
	constrain_to_coord(Dir, Coord, Is, Os),
	sel(Dir, X-Y, C),
	(
		(C  <  Coord) -> (dir(Dir, low,  Need, _));
		(C =:= Coord) -> (dir(Dir, mid,  Need, _));
		(C  >  Coord) -> (dir(Dir, high, Need, _))
	),
	custom_intersection(Dirs, Need, OutDirs).
	
constrain_from_coord(_, _, [], []) :- !.
constrain_from_coord(Dir, Coord, [X-Y-Dirs|Is], [X-Y-OutDirs|Os]) :-
	constrain_from_coord(Dir, Coord, Is, Os),
	sel(Dir, X-Y, C),
	(
		(C  <  Coord) -> (dir(Dir, low,  _, NotNeed));
		(C =:= Coord) -> (dir(Dir, mid,  _, NotNeed));
		(C  >  Coord) -> (dir(Dir, high, _, NotNeed))
	),
	custom_intersection(Dirs, NotNeed, OutDirs).


dir(col, low, [e], [n,s,w]) :- !.
dir(col, mid, [n,s], [e,w]) :- !.
dir(col, high, [w], [e,n,s]) :- !.

dir(row, low, [s], [e,n,w]) :- !.
dir(row, mid, [e,w], [n,s]) :- !.
dir(row, high, [n], [e,s,w]) :- !.

sel(col, _-TX, TX) :- !.
sel(row, TY-_, TY) :- !.

contains_any(_, []) :- !, fail.
contains_any([], _) :- !, fail.
contains_any([X|Xs], Ys) :-
	member(X, Ys) ->
		true;
		contains_any(Xs, Ys).

zip([], [], []) :- !.
zip([Y|Ys], [X|Xs], [Y-X|Zs]) :-
	zip(Ys, Xs, Zs).

union3_sort_unzip(Set1, Set2, Set3, Result) :-
	custom_union(Set1, Set2, S12),
	custom_union(S12, Set3, S123),
	sort(S123, Sorted),
	zip(_, Result, Sorted).

custom_intersection([], _, []) :- !.
custom_intersection([X|Xs], Ys, Zs) :-
	member(X, Ys) ->
		Zs = [X|Zs1],
		custom_intersection(Xs, Ys, Zs1);
		custom_intersection(Xs, Ys, Zs).

custom_union(Xs, [], Xs) :- !.
custom_union([], Ys, Ys) :- !.
custom_union([X|Xs], Ys, Zs) :-
	member(X, Ys) ->
		custom_union(Xs, Ys, Zs);
		Zs = [X|Zs1],
		custom_union(Xs, Ys, Zs1).
