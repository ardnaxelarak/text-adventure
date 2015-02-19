% :- module(get_command, [get_command/1]).

strip_irrelevant([First|List], [First|Oldlist]) :-
	subtract(Oldlist, [a, an, the], List).

expand(List, [l|Rest]) :-
	List = [look|Rest], !.
expand(List, [x|Rest]) :-
	List = [examine|Rest], !.
expand(List, [i|Rest]) :-
	List = [inventory|Rest], !.
expand(List, [pick,up|Rest]) :-
	List = [get|Rest], !.
expand(List, [put,down|Rest]) :-
	List = [drop|Rest], !.
expand(List, [t|Rest]) :-
	List = [talk|Rest], !.
expand(List, List).

strip_downcase(In, Out) :-
	atom_codes(Text, In),
	rl_add_history(Text),
	downcase_atom(Text, Lower),
	atom_codes(Lower, String),
	intersection(String, " abcdefghijklmnopqrstuvwxyz0123456789", Cleaned),
	atom_codes(Out, Cleaned).

get_command(Split) :-
	prompt1("> "),
	read_line_to_codes(user_input, X),
	strip_downcase(X, Y),
	atomic_list_concat(Pieces, ' ', Y),
	expand(Full, Pieces),
	strip_irrelevant(List, Full),
	splitList(List, Split).

preposition(to).
preposition(from).
preposition(at).
preposition(for).
preposition(over).
preposition(around).
preposition(up).
preposition(down).
preposition(in).
preposition(out).
preposition(with).
preposition(on).

prep([X|S]-S, X) :-
	preposition(X).

prepp(S-S2, X-D) :-
	prep(S-S1, X),
	descriptor(S1-S2, D).

verb([V|S]-S, V).

verbp(S-S2, X-D) :-
	verb(S-S1, X),
	descriptor(S1-S2, D).

descriptor(S-S1, D) :-
	prep(S1-_, _),
	append(D, S1, S),
	forall(member(X, D), not(preposition(X))).
descriptor(S-[], S) :-
	forall(member(X, S), not(preposition(X))).

piece([]-[], []).

piece(S-S2, Pieces) :-
	prepp(S-S1, L),
	piece(S1-S2, R),
	Pieces = [L|R].

splitList(S, Split) :-
	verbp(S-S1, V),
	piece(S1-[], R),
	Split = [V|R].
