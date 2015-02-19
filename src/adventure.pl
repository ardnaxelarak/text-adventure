#! /usr/bin/swipl -q -g start_game -s

:- include(directives).
:- dynamic(location/2).
:- dynamic(debugmode/0).
:- dynamic(visited/1).
:- dynamic(locked/1).
:- dynamic(unlocked/1).
:- dynamic(unchecked/1).
:- dynamic(money/1).
:- dynamic(counter/2).
:- dynamic(showall/0).
:- dynamic(just_moved/3).
:- dynamic(dead/1).
:- dynamic(state/1).
:- [knowledgeBase, descriptionBoyer, descriptionFrey, descriptionMaze, descriptionNorth, descriptionSouth, descriptionObject, descriptionPeople, descriptionMonster, storeCode, defaultRules, commands, ending, peopleCode, identificationCode, writewrap, getcommand, keypress]. % consult all files

decrement_counter(Thing) :-
	retract(counter(Thing, X)), !,
	Y is X - 1,
	assertz(counter(Thing, Y)).
decrement_counter(Thing) :-
	assertz(counter(Thing, -1)).

increment_counter(imaginary) :-
	retract(counter(imaginary, X)), !,
	Y is X + 1,
	assertz(counter(imaginary, Y)),
	((Y >= 4, move(prot, dormRoom), end_win, look); true).
increment_counter(Thing) :-
	retract(counter(Thing, X)), !,
	Y is X + 1,
	assertz(counter(Thing, Y)).
increment_counter(Thing) :-
	assertz(counter(Thing, 1)).

set_counter(Thing, _) :-
	retract(counter(Thing, _)), fail.
set_counter(Thing, Value) :-
	assertz(counter(Thing, Value)).

add_money(Y) :-
	retract(money(X)), !,
	Z is X + Y,
	assertz(money(Z)).
add_money(Y) :-
	assertz(money(Y)).

sub_money(Y) :-
	retract(money(X)), !,
	Z is X - Y,
	assertz(money(Z)).
sub_money(Y) :-
	Z is -Y,
	assertz(money(Z)).

set_state(X) :-
	state(X);
	assertz(state(X)).

init_objs :-
	retractall(visited(_)), fail.
init_objs :-
	assertz(visited(rohrbaughOffice)), fail.
init_objs :-
	retractall(money(_)), fail.
init_objs :-
	retractall(state(_)), fail.
init_objs :-
	assert(money(0)), fail.
init_objs :-
	retractall(just_moved(_, _, _)), fail.
init_objs :-
	retractall(dead(_)), fail.
init_objs :-
	retractall(locked(_)), fail.
init_objs :-
	retractall(unlocked(_)), fail.
init_objs :-
	retractall(location(_, _)), fail.
init_objs :-
	retractall(counter(_, _)), fail.
init_objs :-
	initialize_wander_counters, fail.
init_objs :-
	retractall(unchecked(_)), fail.
init_objs :-
	init_state(X),
	assertz(state(X)), fail.
init_objs :-
	assertz(unchecked(importantBook)), fail.
init_objs :-
	initial(X, Place),
	assertz(location(X, Place)),
	fail.
init_objs :-
	init_locked(X),
	assertz(locked(X)), fail.
init_objs :-
	init_unlocked(X),
	assertz(unlocked(X)), fail.
init_objs.

can_see(Thing) :- location(Thing, Place), location(prot, Place).

command_loop :-
	look,
	repeat,
	get_command(List),
	do(List),
	debugmode,
	List = [abort-_ | _].

title("\"Dr. Rohrbaugh and Mr. Tigerram\"").

begin :-
	init_objs,
	title(Title),
	writefw("Welcome to %s.\nYou suddenly find yourself in Dr. Rohrbaugh's office, but Dr. Rohrbaugh is nowhere to be seen. What could have happened to him? You have no recollection of events that just happened. You are carrying a shovel with a slight reddish hue. You think it might be rust...\nThe goal of this game is to figure out what happened to Dr. Rohrbaugh, and to resolve the situation if possible.\n", [Title]),
	print_help.

restart :-
	begin,
	look.

start_game :-
	init_objs,
	begin,
	command_loop.

continue_game :-
	title(Title),
	writefw("Welcome back to %s!\n", [Title]),
	command_loop.

% :- initialization(start_game).
