:- include(directives).

try_dig :-
	not(location(shovel, prot)), !, writefw("You do not have anything with which to dig!\n"), fail.
try_dig :-
	location(prot, Place),
	dig(Place).

try_buy :-
	description(Store, store, _, _),
	location(Store, Place),
	location(prot, Place), !,
	buy(Store).
try_buy :-
	writefw("You do not see a store here.\n").

list_have :-
	location(X, prot),
	description(X, _, Shortname, _),
	writefw("  %s\n", [Shortname]),
	fail.
list_have.

list_people_locations :-
	description(X, person, Name, _),
	location(X, Place),
	description(Place, _, PName, _),
	writefw("%s - %s\n", [Name, PName]),
	fail.
list_people_location.

list_things(Place) :-
	location(X, Place),
	see_object(X),
	fail.
list_things(_).

list_people(Place) :-
	location(X, Place),
	see_person(X),
	fail.
list_people(_).

list_monsters(Place) :-
	location(X, Place),
	see_monster(X),
	fail.
list_monsters(_).

list_connections(Place) :-
	connected(Place, X, Dir, _),
	description(X, _, Shortname, _),
	tab(2),
	writefw("%s (%t)\n", [Shortname, Dir]),
	fail.
list_connections(_).

list_exits(Place) :-
	dark(Place), not(light_source), !,
	findall(X, (connected(Place, To, X, _), not(dark(To))), List),
	sort(List, SList),
	atomic_list_concat(SList, ', ', Full),
	writefw("exits: %t\n", [Full]).

list_exits(Place) :-
	findall(X, (connected(Place, _, X, _); fakeDir(Place, X, _)), List),
	sort(List, SList),
	atomic_list_concat(SList, ', ', Full),
	writefw("exits: %t\n", [Full]).

inventory :-
	location(_, prot), !,
	writefw("You are carrying:\n"),
	list_have, money(X), X > 0,
	writefw("You have $%t\n", [X]).
inventory :-
	money(X), X > 0,
	writefw("You have $%t, but have no objects.\n", [X]).
inventory :-
	writefw("You are not carrying anything.\n").

display_exits(Place) :-
	showall,
	writefw("You can go to:\n"),
	list_connections(Place).
display_exits(Place) :-
	list_exits(Place).

kick_description(Desc) :-
	!, get_object(O, Desc, (can_see(O); location(O, prot)), "There is nothing for you to kick here.\n", "What do you mean by '%t'?\n", "What do you want to kick?\n"), kick(O).

look_description(Desc) :-
	!, get_object(O, Desc, (can_see(O); location(O, prot)), "There is nothing for you to look at here.\n", "What do you mean by '%t'?\n", "What do you want to look at?\n"), look_at(O).

look :-
	state(game_over), !,
	location(prot, Place),
	description(Place, _, Short, Long),
	writefw("\n%s\n\n%s\n", [Short, Long]),
	list_things(Place),
	list_people(Place),
	list_monsters(Place),
	display_ending.

look :-
	location(prot, Place),
	dark(Place), not(light_source), !,
	writefw("\nIt is pitch dark. However, you are unlikely to be eaten by a grue.\n"),
	display_exits(Place).

look :-
	location(prot, Place),
	description(Place, _, Short, Long),
	writefw("\n%s\n\n%s\n", [Short, Long]),
	list_things(Place),
	list_people(Place),
	list_monsters(Place),
	display_exits(Place).

can_dir(Person, Direction, Place) :-
	location(Person, X),
	not(light_source), dark(X),
	((connected(X, Place, Direction, _), dark(Place));
		not(connected(X, _, Direction, _))), !,
	writefw("It is too dark for you to be able to see where to go.\n"),
	fail.
can_dir(Person, Direction, Place) :-
	location(Person, X),
	connected(X, Place, Direction, Comm), !,
	call(Comm).
can_dir(prot, Direction, _) :-
	location(prot, Y),
	fakeDir(Y, Direction, X), !,
	writefw("%s\n", [X]),
	fail.
can_dir(prot, Direction, _) :-
	writefw("You cannot go %t from here.\n", [Direction]),
	fail.

move(Thing, Place) :-
	retract(location(Thing, _)),
	asserta(location(Thing, Place)), !.

go_dir(prot, Direction) :-
	can_dir(prot, Direction, Place), !,
	location(prot, Old),
	will_move(prot, Old, Place),
	update_moves,
	look.

fast_travel :-
	location(prot, Here),
	(room(Here); maze(Here)), !,
	writef("You can't bike inside!\n").

fast_travel :-
	location(bike, prot), !,
	findall(X, (fasttravel(X), visited(X)), List),
	writefw("Where would you like to bike to?\n"),
	select_thing(List, get_name, Place),
	get_name(Place, Short),
	writefw("You quickly bike to %s\n", [Short]),
	location(prot, Old),
	will_move(prot, Old, Place), !,
	update_moves, !,
	look.

fast_travel :-
	writefw("You can't bike somewhere without a bike.  You should know that.\n").


give_description(PDesc, TDesc) :-
	!, get_object(T, TDesc, (location(T, prot), object(T)), "You have nothing to give.\n", "You do not have a '%t'.\n", "What do you want to give?\n"),
	!, get_object(P, PDesc, (can_see(P), (person(P); monster(P))), "You see no one to give it to\n", "I don't see a '%t' here.\n", "Who would you like to give it to?\n"),
	!, give(P, T),
	!, move(T, P).

throw_description(TDesc, PDesc) :-
	!, get_object(T, TDesc, (location(T, prot), object(T)), "You have nothing to throw.\n", "You do not have a '%t'.\n", "What do you want to throw?\n"),
	!, get_object(P, PDesc, (can_see(P), (person(P); monster(P))), "You see no one to throw it at.\n", "I don't see a '%t' here.\n", "Who would you like to throw it at?\n"),
	toss(P, T).

kill_description(TDesc, PDesc) :-
	!, get_object(P, PDesc, (can_see(P), (person(P); monster(P))), "There is no one here to attack.\n", "I don't see a '%t' here.\n", "Who would you like to attack?\n"), 
	!, get_object(T, TDesc, (location(T, prot), weapon(T)), "You do not have anything to attack with.\n", "You do not have a '%t'.\n", "With what would you like to attack?\n"),
	!, kill(P, T),
	atom_concat('dead_', P, DP),
	location(P, Place),
	move(DP, Place),
	move(P, nowhere).

eat_description(Desc) :-
	get_object(O, Desc, (location(O, prot), food(O)), "You don't have anything to eat.\n", "You don't have a '%t'.\n", "What do you want to eat?\n"),
	try_eat(O).

try_eat(Object) :-
	eat(Object), !,
	move(Object, nowhere).

unlock_description([]) :-
	!, get_object(O, [], (can_see(O), door(O)), "There is nothing here to unlock.\n", "What do you want to unlock?\n"), unlock(O).
unlock_description(Desc) :-
	get_object(O, Desc, (can_see(O), door(O)), "I don't see any '%t' here.\n", "Which '%t' do you want to unlock?\n"), unlock(O).

unlock(Door) :-
	not(description(Door, door, _, _)), !,
	writefw("You cannot unlock that.\n"), fail.
unlock(Door) :-
	unlocked(Door), !, writefw("That door is already unlocked!\n"), fail.
unlock(Door) :-
	description(Door, _, Desc, _),
	canUnlock(Key, Door),
	location(Key, prot), !,
	writefw("You unlock %s\n", [Desc]),
	retract(locked(Door)),
	assertz(unlocked(Door)).
unlock(Door) :-
	description(Door, _, Desc, _),
	writefw("You do not have anything with which to unlock %s\n", [Desc]), fail.

lock_description([]) :-
	!, get_object(O, [], can_see(O), "There is nothing here to lock.\n", "What do you want to lock?\n"), lock(O).
lock_description(Desc) :-
	get_object(O, Desc, can_see(O), "I don't see any '%t' here.\n", "Which '%t' do you want to lock?\n"), lock(O).

lock(Door) :-
	not(description(Door, door, _, _)), !,
	writefw("You cannot lock that.\n"), fail.
lock(Door) :-
	locked(Door), !, writefw("That door is already locked!\n"), fail.
lock(Door) :-
	canUnlock(Key, Door),
	description(Door, door, Desc, _),
	location(Key, prot), !,
	writefw("You lock %s\n", [Desc]),
	retract(unlocked(Door)),
	assertz(locked(Door)).
lock(Door) :-
	description(Door, _, Desc, _),
	writefw("You do not have anything with which to lock %s\n", [Desc]), fail.

warp(Place) :-
	spot(LPlace),
	location(prot, Old),
	downcase_atom(LPlace, Place),
	description(LPlace, _, Short, _), !,
	writefw("You teleport to %s\n", [Short]),
	will_move(prot, Old, LPlace), !,
	update_moves, !,
	look.
warp(Place) :-
	writefw("Unrecognized place: '%t'\n", [Place]).

show_money :-
	money(Money),
	writef("You currently have $%t\n", [Money]).

go(Dir) :- dir(Dir, LongDir) , !, go_dir(prot, LongDir), !.
go(Dir) :- writefw("'%t' is not a valid direction\n", [Dir]), fail.

wait :-
	writefw("You wait for a bit.\n"),
	update_moves.

acquire_description(Desc) :-
	!, get_object(O, Desc, (takeable(O), not(location(O, prot))), "There are no objects to acquire.\n", "There is no '%t' that you can acquire.\n", "What do you want to acquire?\n"),
	get_name(O, Name),
	writefw("You magically acquire the %s.\n", [Name]),
	move(O, prot).

take_description(Desc) :-
	!, get_object(O, Desc, can_see(O), "There is nothing here to take.\n", "I don't see any '%t' here.\n", "What do you want to take?\n"), take(O).

take(Thing) :-
	can_see(Thing), !,
	pick_up(Thing), !,
	move(Thing, prot).

talk_to_description(Desc) :-
	!, get_object(O, Desc, (can_see(O), (person(O); monster(O))), "You don't see anyone to talk to.\n", "You don't see a '%t' to talk to.\n", "Who do want to talk to?\n"),
	set_state(talked), !,
	talk_to(O).

put_description(Desc) :-
	!, get_object(O, Desc, location(O, prot), "You aren't carrying anything to drop.\n", "Which '%t' do you want to drop?\n", "What do you want to drop?\n"), drop(O).

drop(Thing) :-
	put_down(Thing), !,
	location(prot, Place),
	move(Thing, Place).

show_counters :-
	counter(X, Y),
	writefw("%t - %t\n", [X, Y]),
	fail.
show_counters.

attempt_quit :-
	halt.

do([restart-_|_]) :- !, restart, !.
do([help-[]]) :- !, print_help.
do([quit-[]]) :- !, attempt_quit.
do([halt-[]]) :- !, attempt_quit.
do([end-[]]) :- !, attempt_quit.
do(_) :- dead(prot), !, writefw("You are dead. You can restart or quit.\n").
do(_) :- state(game_over), !, writefw("The game is over! You may restart or quit.\n").
do([save-[FName|_]]) :- !, qsave_program(FName, [goal(continue_game), stand_alone(true)]), !.
do([die-[]|_]) :- !, writefw("Well, then. You die.\n"), die, !.
do([buy-[]]) :- !, try_buy, !.
do([money-[]]) :- !, show_money, !.
do([inventory-[]]) :- !, inventory, !.
do([look-[]]) :- !, look, !.
do([dig-[]]) :- !, try_dig, !.
do([goto-[]|_]) :- writefw("Edsger Dijsktra would not approve.\n").
do([go-[],to-_|_]) :- writefw("Edsger Dijsktra would not approve.\n").
do([wait-_|_]) :- !, wait.
do([bike-[]]) :- !, fast_travel.
do([war-_|_]) :- !, writefw("Why do you want to go to war?\n").
do([go-[]]) :- !, writefw("Where do you want to go?\n").
do([go-[Dir|_]|_]) :- !, go(Dir), !.
do([go-[], Dir-[]|_]) :- !, go(Dir), !.
do([get-Rest]) :- !, take_description(Rest).
do([grab-Rest]) :- !, take_description(Rest).
do([take-Rest]) :- !, take_description(Rest).
do([talk-Rest]) :- !, talk_to_description(Rest).
do([talk-[], to-Rest]) :- !, talk_to_description(Rest).
do([put-Rest]) :- !, put_description(Rest).
do([lie-[],down-[]]) :- !, lie_down.
do([drop-Rest]) :- !, put_description(Rest).
do([[kick-Rest]|_]) :- !, kick_description(Rest).
do([eat-Rest]) :- !, eat_description(Rest).
do([consume-Rest]) :- !, eat_description(Rest).
do([ingest-Rest]) :- !, eat_description(Rest).
do([swallow-Rest]) :- !, eat_description(Rest).
do([unlock-Rest]) :- !, unlock_description(Rest).
do([lock-Rest]) :- !, lock_description(Rest).
do([examine-Rest]) :- !, look_description(Rest).
do([look-[], at-Rest]) :- !, look_description(Rest).
do([look-Rest]) :- !, look_description(Rest).
do([Dir-[]]) :- dir(Dir, _), !, go(Dir), !.
do([throw-Thing, at-Person]) :- !, throw_description(Thing, Person).
do([throw-Thing, to-Person]) :- !, throw_description(Thing, Person).
do([throw-Thing]) :- !, throw_description(Thing, []).
do([give-Thing, to-Person]) :- !, give_description(Person, Thing).
do([give-Thing]) :- !, give_description([], Thing).
do([attack-Person, with-Thing]) :- !, kill_description(Thing, Person).
do([attack-Person]) :- !, kill_description([], Person).
do([kill-Person, with-Thing]) :- !, kill_description(Thing, Person).
do([kill-Person]) :- !, kill_description([], Person).
do([fly-_|_]) :- !, writefw("This isn't some silly fantasy game.  You can't fly.\n").
do([jump-_|_]) :- !, jump.
do([run-_|_]) :- !, run.
do([Comm-Rest]) :- identify(O, Rest, (can_see(O); location(O, prot))), action([Comm], O), !.
do([Comm1-[],Comm2-Rest]) :- identify(O, Rest, (can_see(O); location(O, prot))), action([Comm1,Comm2], O), !.
do([Comm1-[Comm2|Rest]]) :- identify(O, Rest, (can_see(O); location(O, prot))), action([Comm1,Comm2], O), !.
do([debug-[]]) :- retract(debugmode), !, writefw("Debug mode: OFF\n").
do([debug-[]]) :- assertz(debugmode), !, writefw("Debug mode: ON\n").
do([Blah-_|_]) :- not(debugmode), !, writefw("I don't understand the word '%t'\n", [Blah]).
do([export-[FName|_]]) :- !, init_objs, retract(debugmode), qsave_program(FName, [goal(start_game), stand_alone(true)]), assertz(debugmode), !.
do([warp-[To|_]]) :- !, warp(To).
do([showpeople-[]]) :- !, list_people_locations.
do([counters-[]]) :- !, show_counters.
do([acquire-Rest]) :- !, acquire_description(Rest).
do([showall-[]]) :- !, assertz(showall).
do([hideall-[]]) :- !, retract(showall).
do([Blah-_|_]) :- writefw("I don't understand the word '%t'\n", [Blah]).

print_help :-
	writefw("\n"),
	helplines(Lines),
	maplist(writefw, Lines).

die :-
	assert(dead(prot)).
