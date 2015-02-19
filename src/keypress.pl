% :- module(keypress, [get_YN/0, get_char_set/2, select_thing/3, get_from_list/2]).

get_char_set(List, Index) :-
	repeat,
	prompt1(''),
	get_single_char(X),
	include(member(X), List, All),
	All = [First | _],
	nth0(Index, List, First), !.

get_list_index(Length, Index) :-
	repeat,
	prompt1(''),
	get_single_char(X),
	Upper is X - 65, Lower is X - 97,
	(((X = 122; X = 90), Index = -1, !);
	(Upper >= 0, Upper < Length, Index = Upper, !);
	(Lower >= 0, Lower < Length, Index = Lower, !)).

list_things(_, []) :-
	writefw("  [Z] Cancel\n").
list_things(Index, [First | Rest]) :-
	Code is Index + 65,
	writefw("  [%n] %s\n", [Code, First]),
	Next is Index + 1,
	list_things(Next, Rest).

get_from_list(List, Index) :-
	list_things(0, List),
	length(List, L),
	get_list_index(L, Index).

select_thing(List, Pred, Thing) :-
	maplist(Pred, List, Display),
	get_from_list(Display, X),
	((X < 0, Thing = []); 
	nth0(X, List, Thing)).

get_YN :-
	get_char_set(["Yy\r", "Nn"], X),
	X = 0.
