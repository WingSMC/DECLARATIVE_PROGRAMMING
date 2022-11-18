lepcso(_, [], [], []) :- !.
lepcso(_, [X], [X], [X]) :- !.
lepcso(Dir, [Prev, Current | Xs], L, M) :-
	!,
	((
		Dir == inc -> Prev < Current;
		% Ez az egyértelműsítés nincs a ZHban
		Dir == dec -> Prev > Current
	) -> (
		lepcso(Dir, [Current | Xs], L1, M),
		L = [Prev | L1]
	);(
		M = [Prev, Current | Xs],
		L = [Prev]
	)).

vlepcso([], _) :- !, fail.
vlepcso([_], _) :- !, fail.
vlepcso([X,X|Xs], L) :- !, vlepcso([X|Xs], L).
vlepcso(Xs, L) :-
	(
		lepcso(inc, Xs, L1, M1),
		length(L1, Len1),
		Len1 > 1,
		(L = L1; vlepcso(M1, L))
	);(
		lepcso(dec, Xs, L2, M2),
		length(L2, Len2),
		Len2 > 1,
		(L = L2; vlepcso(M2, L))
	).
