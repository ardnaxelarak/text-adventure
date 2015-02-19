% :- module(peopleCode, [update_moves/0, will_move/3, initialize_wander_counters/0]).

encounter :-
	not(just_moved(prot, _, _)),
	location(prot, Current),
	just_moved(Person, _, Current),
	enter(Person),
	fail.
encounter :-
	just_moved(prot, From, To),
	location(Person, To),
	not(just_moved(Person, From, To)),
	enter(Person),
	fail.
encounter.

wandered_messages :-
	just_moved(prot, _, To),
	just_moved(Someone, To, Elsewhere),
	description(Someone, _, PName, _),
	description(Elsewhere, _, EName, _),
	writefw("You see %s leave to go to %s right as you enter.\n", [PName, EName]),
	fail.
wandered_messages :-
	just_moved(prot, From, To),
	just_moved(Someone, TFrom, To),
	From \= TFrom,
	description(Someone, _, PName, _),
	writefw("You see %s enter at the same time as you do.\n", [PName]),
	fail.
wandered_messages :-
	just_moved(prot, From, To),
	just_moved(Someone, From, To),
	description(Someone, _, PName, _),
	writefw("You see %s follow you.\n", [PName]),
	fail.
wandered_messages :-
	not(just_moved(prot, _, _)),
	location(prot, Current),
	just_moved(Someone, _, Current),
	description(Someone, _, PName, _),
	writefw("You see %s enter.\n", [PName]),
	fail.
wandered_messages :-
	not(just_moved(prot, _, _)),
	location(prot, Current),
	just_moved(Someone, Current, To),
	description(Someone, _, PName, _),
	description(To, _, TName, _),
	writefw("You see %s leave to go to %s.\n", [PName, TName]),
	fail.
wandered_messages.

update_locations :-
	just_moved(P, _, X),
	move(P, X),
	fail.
update_locations :-
	location(prot, Here),
	not(visited(Here)),
	asserta(visited(Here)).
update_locations.

wander(Person, Places, Dest) :-
	location(Person, Current),
	findall(X, (connected(Current, X, _, _); Current = X), List),
	intersection(Places, List, Valid),
	length(Valid, L),
	L > 0,
	Y is random(L),
	nth0(Y, Valid, Dest),
	(Current = Dest; will_move(Person, Current, Dest)).

pick_up_stuff(Person) :-
	location(Person, Room),
	location(Object, Room),
	picks_up(Person, Object),
	move(Object, Person),
	location(prot, Room),
	description(Person, _, PName, _),
	get_name(Object, OName),
	writefw("You see %s pick up the %s.\n", [PName, OName]),
	fail.
pick_up_stuff(_).

pickups :-
	person(X),
	pick_up_stuff(X).

wander_person(Person) :-
	wanders(Person, List),
	wander(Person, List, _), !.

check_wander :-
	wanders(P, _),
	not(just_moved(P, _, _)),
	atom_concat(wander_, P, WC),
	decrement_counter(WC),
	counter(WC, X),
	X =< 0,
	wander_person(P),
	Y is random(3) + 2,
	set_counter(WC, Y), fail.
check_wander.

initialize_wander_counters :-
	wanders(P, _),
	atom_concat(wander_, P, WC),
	Y is random(3) + 2,
	set_counter(WC, Y), fail.
initialize_wander_counters.

will_move(Person, From, To) :-
	assert(just_moved(Person, From, To)).

clear_movements :-
	retractall(just_moved(_, _, _)).

update_moves :-
	check_wander,
	wandered_messages,
	update_locations,
	pickups,
	encounter,
	clear_movements.
