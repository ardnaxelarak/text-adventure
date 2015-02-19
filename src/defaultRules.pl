:- include(directives).

dig(Location) :-
	(place(Location); building(Location); waypoint(Location)), !,
	writefw("You begin digging, but find nothing of interest.\n"), fail.
dig(_) :- writefw("You cannot dig here!\n"), fail.

eat(_) :- writefw("You can't eat that for some reason.\n"), fail.
 
purchased(_).

look_at(CB) :-
	writeable(CB, _, _, _),
	state(message(CB, X)), !,
	description(CB, _, _, Long),
	writefw("%s You see the message \"%s\" written on it.\n", [Long, X]).
look_at(CB) :-
	writeable(CB, _, _, _), !,
	description(CB, _, _, Long),
	writefw("%s It is currently blank.\n", [Long]).
action([read], CB) :-
	writeable(CB, _, _, _),
	state(message(CB, X)), !,
	writefw("You read the message \"%s\".\n", [X]).
action([read], CB) :-
	writeable(CB, Object, _, _), !,
	writefw("There is nothing written on the %s.\n", [Object]).
action([erase], CB) :-
	writeable(CB, Object, _, Eraser),
	retract(state(message(CB, _))), !,
	writefw("Using %s, you erase the %s.\n", [Eraser, Object]).
action([erase], CB) :-
	writeable(CB, Object, _, _),
	writefw("The %s is already erased!.\n", [Object]).
action([write, on], CB) :- action([write], CB).
action([write], CB) :-
	writeable(CB, Object, _, _),
	state(message(CB, _)), !,
	writefw("There's already something written on the %s!\n", [Object]).
action([write], CB) :-
	writeable(CB, Object, Instrument, _),
	writefw("What would you like to write on the %s?\n", [Object]),
	prompt1("message: "),
	read_line_to_codes(user_input, X),
	set_state(message(CB, X)),
	writefw("Using %s, you write on the %s.\n", [Instrument, Object]).

pick_up(Door) :-
	description(Door, door, _, _), !,
	writefw("How would you even do that?\n"), fail.

pick_up(Dead) :-
	description(Dead, dead, Name, _), !,
	writefw("You have no desire to pick up %s.\n", [Name]), fail.

look_at(Thing) :-
	description(Thing, _, _, Long),
	writefw("%s\n", [Long]).

kick(Person) :-
	person(Person),
	get_name(Person, Name),
	writefw("You don't think %s would appreciate that.\n", [Name]).

kick(Thing) :-
	object(Thing),
	get_name(Thing, Name),
	writefw("You kick the %s. Nothing particularly exciting happens.\n", [Name]).

kill(Person, _) :-
	get_name(Person, Name),
	writefw("You don't feel like attacking %s right now; that would be rude.\n", [Name]), !, fail.

toss(Person, Thing) :-
	get_name(Thing, TName),
	get_name(Person, PName),
	writefw("You don't feel like throwing the %s at %s.\n", [TName, PName]).

give(Person, Thing) :-
	get_name(Thing, TName),
	get_name(Person, PName),
	writefw("%s does not want your %s.\n", [PName, TName]),
	fail.

talk_message(Y, List, _) :-
	nth0(Y, List, Statement), !, writefw("\"%s\"\n", [Statement]).
talk_message(_, _, Person) :-
	description(Person, _, Name, _), writefw("%s seems to have nothing more to say.\nYou can repeat the conversation by continuing to talk.\n", [Name]).

talk_to(Person) :-
	sequential_statements(Person, List), !,
	atom_concat('statement_', Person, Counter),
	increment_counter(Counter),
	counter(Counter, X),
	length(List, L),
	Y is (X - 1) mod (L + 1), !,
	talk_message(Y, List, Person).
talk_to(Person) :-
	random_statements(Person, List), !,
	length(List, L),
	atom_concat('statement_', Person, Counter),
	repeat,
	Y is random(L),
	not(counter(Counter, Y)), !,
	set_counter(Counter, Y),
	talk_message(Y, List, Person).

checkDoor(door3) :-
	locked(door3), !, writefw("Why are you trying to get through a bookshelf?\n"), fail.
checkDoor(Door) :-
	locked(Door), !, writefw("You try to open the door, but it is locked.\n"), fail.
checkDoor(_).

leaveDoor(Door) :-
	locked(Door), !, writefw("You hear the door lock shut behind you.\n").
leaveDoor(_) :-
	writefw("You close the door behind you.\n").

connected(P1, P2, Dir, Comm) :- connection(P1, P2, Dir, Comm).
connected(P1, P2, Dir, "") :- adjacent(P1, P2, Dir, _) ; adjacent(P2, P1, _, Dir).

building(X) :- description(X, building, _, _).
place(X) :- description(X, place, _, _).
waypoint(X) :- description(X, waypoint, _, _).
room(X) :- description(X, room, _, _).
maze(X) :- description(X, maze, _, _).
door(X) :- description(X, door, _, _).
key(X) :- description(X, key, _, _).
stuffedanimal(X) :- description(X, sa, _, _).
dead_thing(X) :- description(X, dead, _, _).
object(X) :- description(X, object, _, _).
object(X) :- description(X, fakeobject, _, _).
object(X) :- description(X, lightsource, _, _).
object(X) :- door(X); key(X); stuffedanimal(X); dead_thing(X).
takeable(X) :- description(X, object, _, _); key(X); stuffedanimal(X); description(X, lightsource, _, _).
person(X) :- description(X, person, _, _).
monster(X) :- description(X, monster, _, _).

spot(X) :- building(X); place(X); waypoint(X); room(X); maze(X).

get_name(Thing, Name) :- description(Thing, _, Name, _).

light_source :-
	description(X, lightsource, _, _),
	location(X, prot),
	concat(X, '_on', Y),
	state(Y).
