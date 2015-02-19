:- include(directives).

description(hoffman, building, "Hoffman", "You are outside Hoffman; you can see beautiful flowers, and feel an aura of computing genius. You can go east to Frey, southwest to Boyer, and northwest to Eisenhower.").


description(high, building, "High Center", "You are outside the High Center, you can see beautiful flowers, and hear beautiful praise music. Yeah Jesus! You may venture on to the Back Entrance (southwest), Old Main (northeast), or Climenhaga(east).").


description(backEntrance, place, "Back Entrance", "You are next to the Back Entrance, and you can hear the sounds of the train in the distance. you may head back to the High Center to the northeast").

dig(backEntrance) :-
	counter(backEntrance_dug, X), X > 1, !,
	writefw("Is it really important to dig this much?\n"), increment_counter(backEntrance_dug).
dig(backEntrance) :-
	counter(backEntrance_dug, X), X = 1, !,
	writefw("Using your shovel you dig around, and you uncover a lantern!\n"), move(lantern, backEntrance), increment_counter(backEntrance_dug).
dig(backEntrance) :-
	writefw("Using your shovel you dig around, but find nothing after a brief search.\n"), increment_counter(backEntrance_dug).


description(climenhaga, building, "Climenhaga", "Outside Climenhaga you notice a much better looking building in the distance. There are many places you may now go: Old Main to the north, High Center to the west, the Covered Bridge to the south, the fitness trail to the southeast, and Boyer to the northeast.").
initial(bikeRack, climenhaga).


description(coveredBridge, place, "Covered Bridge", "You are on the Covered Bridge. You can go to Climenhaga to the north, and Starry Fields to the south.").


description(starry, place, "Starry Fields", "In Starry Fields, you feel a sudden urge to stargaze, and you feel compelled to lie down, but don't. You can leave Starry Fields over the Covered Bridge to the north.").
lie_down :-
	location(prot, starry), 
	location(lairKey1, nowhere), !,
	writefw("You lie down; you wanted to see the stars, but something pokes you in the back. You realize that there's a brass key on the ground. You take it; it seems important. \n"),
	move(lairKey1, prot).
lie_down :-
	location(prot, starry), !,
	writefw("You lie down, look at the stars and then get back up.\n").
lie_down :-
	!, writefw("You aren't in starry field, you can't see the stars anywhere but there.\n").


description(y1, waypoint, "Fitness Trail", "You are on the fitness trail. You can stay on the fitness trail to the east and head to Climenhaga to the northwest; don't run, running is silly and makes you tired.").
dig(y1) :-
	writefw("Digging on the fitness trail seems dangerous; someone might trip.\n").


description(y2, waypoint, "Fitness Trail", "You are on the fitness trail. You can stay on the fitness trail to the west or the east; don't run, running is silly and makes you tired.").
dig(y2) :-
	writefw("Digging on the fitness trail seems dangerous; someone might trip.\n").


description(y3, waypoint, "Fitness Trail", "You can stay on the fitness trail to the west or the east, and you can go onto the Swinging Bridge to the south; don't run, running is silly and makes you tired.").
dig(y3) :-
	writefw("Digging on the fitness trail seems dangerous; someone might trip.\n").


description(y4, waypoint, "Fitness Trail", "You can stay on the fitness trail to the west or the east; don't run, running is silly and makes you tired.").
dig(y4) :-
	writefw("Digging on the fitness trail seems dangerous; someone might trip.\n").


description(y5, waypoint, "Fitness Trail", "You are on the fitness trail. You can stay on the fitness trail to the west and head to South Complex to the north; don't run, running is silly and makes you tired.").
dig(y5) :-
	writefw("Digging on the fitness trail seems dangerous; someone might trip.\n").


run :- (location(prot, y1); location(prot, y2); location(prot, y3); location(prot, y4), location(prot, y5)), !, writefw("You start to run, but realize you really don't want to do something that tiresome.\n").
run :- writefw("You think about running, but decide not to.\n").


description(swingingBridge, place, "Swinging Bridge", "You are on the Swinging Bridge. Don't jump too much, you might break the bridge! There are trees all around you, the sound of water and bubbling is everywhere. You really wish you could see the water under the bridge... You may go back to the fitness trail to the north.").


jump :- location(prot, swingingBridge), !, writefw("You almost jump, but you realize that the bridge is pretty unstable and jumping wouldn't be a good idea.\n").
jump :- writefw("You jump. You go up into the air, and then land on the ground. Nothing else happens, but it was pretty exciting.\n").


% ---secretLair---
description(secretLair, place, "Secret Lair", "This room is dark, and musty... There is dirt under your feet, and stuff hanging from the ceiling... There is a strange high tech door with a keyboard on it.").
description(door1, door, "the pathway door", "There is a strange high tech door with a keyboard on it... How does it open?").
init_locked(door1).
words(door1, [door, strange, high, tech]).
initial(door1, secretLair).
dig(secretLair) :-
	counter(secretLairDug, X), X \= 0, !, writefw("Still nothing here...\n"), increment_counter(secretLairDug).
dig(secretLair) :-
	writefw("You dig for a while, and realize there is nothing here...\n"), increment_counter(secretLairDug).

description(stuffHanging, fakeobject, "hanging stuff", "There is stuff hanging from the ceiling!").
pick_up(stuffHanging) :- !, writefw("You can't reach it...\n"), fail.
words(stuffHanging, [stuff, hanging]).
initial(stuffHanging, secretLair).

description(keypad, fakeobject, "keyboard", "This is a keyboard.").
words(keypad, [keypad, key, pad, board]).
initial(keypad, secretLair).
pick_up(keypad) :- !, writefw("You can't take that...\n"), fail.
action([type], keypad) :-
	prompt1("Type Password Here: "),
	read_line_to_codes(user_input, "password"), !, 
	writefw("You hear a click.\n"),
	retract(locked(door1)),
	assertz(unlocked(door1)).
action([type], keypad) :-
	writefw("Nothing seems to happen.\n").
% ---secretLair---


% ---l1---
description(l1, waypoint, "Pathway", "This room is just a metal box with a door at both ends, and a lightbulb hanging from the ceiling. The far door looks like it has a card swiper thing next to it.").
description(door2, door, "the pathway door", "There is another door here, this one has a thing next to it that looks strangely like a card swiper; chapel credit?").
init_locked(door2).
words(door2, [chapel, card, swiper, door]).
initial(door2, l1).
canUnlock(idCard, door2).

description(hangingLightbulb, fakeobject, "Lightbulb", "There is a lightbulb hanging from the ceiling!").
pick_up(hangingLightbulb) :- !, writefw("You can't reach it...\n"), fail.
words(hangingLightbulb, [lightbulb, light, bulb, hanging]).
initial(hangingLightbulb, l1).
% ---l1---


% ---l2---
description(l2, waypoint, "Pathway", "When you enter this room you see a bookshelf at one end, and solid wood walls all around you.").
description(door3, fakeobject, "the bookshelf", "").
init_locked(door3).
look_at(door3) :-
	location(importantBook, l2), !,
	writefw("This bookshelf seems happy to be full once again.\n").
look_at(door3) :-
	!, writefw("This bookshelf is sad... maybe there is a book missing.\n").
words(door3, [bookshelf, book, shelf]).
initial(door3, l2).
pick_up(door3) :- !, writefw("You can't take that... It is built into the wall...\n"), fail.
% ---l2---


% ---l3---
description(l3, waypoint, "Pathway", "This is another dark room; the ground is squishy, and there are bugs everywhere. The light in this room comes from the room behind you and a little light through the keyhole in the door.").
description(door4, door, "the pathway door", "There is another door here with a key hole; it probably takes a key.").
init_locked(door4).
words(door4, [door]).
initial(door4, l3).
canUnlock(tunnelKey, door4).

description(bugs, fakeobject, "bugs", "Ewwwwwww... There are bugs all around you.").
pick_up(bugs) :- !, writefw("These are bugs you found in a subterranean cavern, why under earth would you want them...\n"), fail.
words(bugs, [bugs, bug]).
initial(bugs, l3).

dig(l3) :-
	counter(l3Dug, X), X \= 0, !, writefw("You continue to dig around this small room, but there's nothing else here.\n"), increment_counter(l3Dug).
dig(l3) :-
	writefw("Using your shovel you dig around, and find a rusty key!\n"), move(tunnelKey, l3), increment_counter(l3Dug).
% ---l3---


% ---l4---
description(l4, waypoint, "Pathway", "Yet another room with a door, and some way to get through it. Though the keyboard on the door may prove useful!").

description(door5, door, "the pathway door", "There's another keyboard; is this yet another password?").
init_locked(door5).
words(door5, [door]).
initial(door5, l4).

description(keypad1, fakeobject, "keyboard", "This is a keyboard.").
words(keypad1, [keypad, key, pad, board]).
initial(keypad1, l4).
pick_up(keypad1) :- !, writefw("You can't take that...\n"), fail.
action([type], keypad1) :-
	prompt1("Type Password Here: "),
	read_line_to_codes(user_input, "sausageroll"), !, 
	writefw("You hear a click.\n"),
	retract(locked(door5)),
	assertz(unlocked(door5)).
action([type], keypad1) :-
	writefw("Nothing seems to happen.\n").
% ---l4---


% ---l5---
description(l5, waypoint, "Pathway", "There is a blue door at the other side of this room. There is a console thing in the centre, but it doesn't do anything. The whole look of the room reminds you of a show you watch; is the room bigger on the inside, or smaller on the outside?").

description(door6, door, "the pathway door", "There are three keyholes; did you find all the keys?").
init_locked(door6).
words(door6, [door]).
initial(door6, l5).

description(console, fakeobject, "console", "This the Tardis console!").
words(console, [console, tardis]).
initial(console, l5).
pick_up(console) :- !, writefw("You can't take that. If you did, the Doctor would be mad at you!\n"), fail.
% --l5---


% ---mainLair---
description(mainLair, place, "Main Lair", "In The Main Lair.").
% ---mainLair---


% ---OTHER STUFF---
checkBungee :- 
	location(bungeeCord, prot), 
	location(prot, swingingBridge), !, 
	writefw("With this cord you safely bungee off the bridge.\n").	
checkBungee :- 
	location(bungeeCord, prot), 
	location(prot, secretLair), !, 
	writefw("You throw one end of the bungee up to the bridge and climb back up.\n").
checkBungee :- 
	location(prot, swingingBridge), !,
	writefw("You are missing something. Be safe when you jump.\n"), fail.
checkBungee :- 
	location(prot, secretLair), !,
	writefw("You are missing something. You are unable to climb back up!\n"), fail.


unlock(door6) :-
	unlocked(door6), !, writefw("That door is already unlocked!\n"), fail.
unlock(door6) :-
	location(lairKey1, prot),
	location(lairKey2, prot),
	location(lairKey3, prot), !,
	writefw("After putting in all three keys, you have unlocked this door!\n"),
	retract(locked(door6)),
	assertz(unlocked(door6)).
unlock(door6) :-
	!, writefw("You need three keys to unlock this door...\n"), fail.


checkCardLair :-
	location(idCard, prot), !, writefw("You swipe your card to get through this door.\n").
checkCardLair :-
	writefw("You have no way to get through this door; you may need to find an ID card.\n"), fail.


% secretLair & swingingBridge 
connection(swingingBridge, secretLair, down, checkBungee).
connection(secretLair, swingingBridge, up, checkBungee).

% secretLair & l1
connection(secretLair, l1, in, checkDoor(door1)).
connection(l1, secretLair, out, leaveDoor(door1)).

% l1 & l2
connection(l1, l2, in, checkCardLair).
connection(l2, l1, out, leaveDoor(door2)).

% l2 & l3
connection(l2, l3, in, checkDoor(door3)).
connection(l3, l2, out, leaveDoor(door3)).

% l3 & l4
connection(l3, l4, in, checkDoor(door4)).
connection(l4, l3, out, leaveDoor(door4)).

% l4 & l5
connection(l4, l5, in, checkDoor(door5)).
connection(l5, l4, out, leaveDoor(door5)).

% l5 & mainLair
connection(l5, mainLair, in, (checkDoor(door6), end_win)).
connection(mainLair, l5, out, leaveDoor(door6)).
