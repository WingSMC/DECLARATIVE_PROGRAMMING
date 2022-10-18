
s_factorial(0, 1) :- .
s_factorial(N, F) :-
	N1 is N - 1,
	s_factorial(N1, F1),
	F is N * F1.

s_factorial(4, F)

:- F
