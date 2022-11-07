osszeg_szukites(Trees, oszl(Col, S), DirsIn, DirsOut) :-
	!,
	zip(Trees, DirsIn, Zip),
	W is Col - 1,
	E is Col + 1.
	

osszeg_szukites(Trees, sor(Row, S), DirsIn, DirsOut) :-
	!,
	zip(Trees, DirsIn, Zip).


zip([], [], []) :- !.
zip([Y|Ys], [X|Xs], [X-Y|Zs]) :-
	zip(Ys, Xs, Zs).


col_map([], _, S, []) :-
	!,
	S =< 0.
col_map([TY-TX-DirsIn|Is], Col, Sum, [Ds|DsOutRest]) :-
	(
		TX < Col   -> (
			member(e, DirsIn),
			S1 is Sum - 1
		);
		TX > Col   ->  (
			member(w, DirsIn),
			S1 is Sum - 1
		);
		TX =:= Col ->  (
			(member(n, DirsIn);
			member(s, DirsIn)),
			S1 is Sum - 1
		)
	).
