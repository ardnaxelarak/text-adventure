:- include(directives).

description(mainEntrance, place, "Main Entrance", "You are standing in the main entrance to Messiah College.\nTo the south is Sollenberger Sports Center.  To the east is north complex, and to the northwest is the safety house.").

description(presidentHouse, building, "President's House", "You are in front of the President's house.\nTo the southeast you see a road leading toward campus.").

description(k1, waypoint, "Near the President's House", "You feel an aura of power emanating from the president's house, even from this far away.\nTo the northwest is the president's house, while to the southeast is the safety house.").
dig(k1) :-
	increment_counter(k1_dug),
	counter(k1_dug, X), X < 4, !,
	Y is random(6 - X) + 1,
	writefw("Digging around the path to the president's house, you find $%t!\n", [Y]), add_money(Y).
dig(k1) :-
	writefw("You continue to dig around the path to the president's house, but find nothing.\n").

description(safety, building, "Safety House", "You are in front of the Safety House.  This is where the president's secret service control access to her house.\nYou see the main entrance to the southeast, and a road leading toward the president's house to the northwest.").
connection(safety, k1, northwest, checkSS).
connection(k1, safety, southeast, []).

checkSS :-
	location(cricket, safety), !,
	writefw("The secret service, upon seeing your cricket and its innate happiness, lets you pass.\n").
checkSS :-
	location(cricket, prot), !,
	writefw("The secret service stops you.  \n\"Sir/Ma'am/Gender-Neutral-Pronoun, please release the cricket.\"\n"),
	fail.
checkSS :-
	writefw("The secret service does not let you pass.\n"), fail.

description(northComplex, building, "North Complex", "You are standing in front of North Complex.  A bike rack is next to the entrance.\nYou see the Engle Center to the south, a path towards Eisenhower to the southwest, the student union to the southeast, the main entrance to campus to the west, Naugle to the north, and a door into the fishbowl.").
initial(bikeRack, northComplex).

description(naugle, building, "Naugle", "You are standing in front of Naugle.  You can hear a train going past, blaring its horn loudly.\nYou see a path toward D-Lot to the northeast and north complex to the south.  For some reason, you don't see any apartment buildings.").

description(d2, waypoint, "Path between Naugle and D-Lot", "You feel as though you are leaving civilization.\nYou see Naugle to the southwest and a path toward D-Lot to the northeast.").
dig(d2) :-
	increment_counter(d2_dug),
	counter(d2_dug, X), X < 4, !,
	Y is random(6 - X) + 1,
	writefw("Digging around the path to D-Lot, you find $%t!\n", [Y]), add_money(Y).
dig(d2) :-
	writefw("You continue to dig around the path to D-Lot, but find nothing.\n").

description(d3, waypoint, "Path between Naugle and D-Lot", "You hear the sounds of civilization, but only barely.\nYou see D-Lot to the northeast and a path toward Naugle to the southwest.").
dig(d3) :-
	increment_counter(d3_dug),
	counter(d3_dug, X), X < 4, !,
	Y is random(6 - X) + 1,
	writefw("Digging around the path to D-Lot, you find $%t!\n", [Y]), add_money(Y).
dig(d3) :-
	writefw("You continue to dig around the path to D-Lot, but find nothing.\n").

description(dLot, place, "D-Lot", "You are in D-Lot.  There are few signs of humanity; civilization is far behind you.\nYou see a path back to campus and civilization to the southwest.").

description(engle, building, "Engle Center", "You are in front of the Engle Center.  You feel healthier just standing here.\nYou see Kline/Jordan to the southwest, the student union to the east, and north complex to the north.").

description(klineJordan, building, "Kline/Jordan", "You are standing in front of Kline and Jordan, home of the chemists and biologists.  A bike rack is next to the entrance.\nYou can see Frey to the southwest, south complex to the southeast, Eisenhower to the west, and the Engle Center to the northeast.").
initial(bikeRack, klineJordan).

description(insideKlineJordan, room, "Inside Kline/Jordan", "You are standing inside of Kline/Jordan.\nYou see doors leading out, and anther set of doors leading into the Oakes Museum.").

description(oakes, room, "The Oakes Museum", "You are standing inside the Oakes Museum.  You are surrounded by lots of cool naturey stuff.\nYou see doors leading out.").

description(union, building, "Larsen Student Union", "You are standing in front of the Larsen Student Union.\nYou see the Engle Center to the west, the Loft to the southeast, south complex to the south, and north complex to the northwest.\nYou can buy stuff here.").

description(loft, building, "Loft", "You are standing in front of the Loft.  You see a door to a garage marked 'Climbing Wall' nearby.\nYou see south complex to the southwest and the student union to the northwest.").

description(climbingWall, room, "Climbing Wall", "You are at the climbing wall.").

description(southComplex, building, "South Complex", "You are at South Complex.  A bike rack is next to the entrance.\nYou see Kline/Jordan to the northwest, the fitness trail to the south, Mellinger to the east, Witmer to the southeast, the student union to the north, a door into South Side, and the Loft to the northeast.").
initial(bikeRack, southComplex).

description(southside, room, "South Side Cafe", "You're in the South Side Cafe.  You see a door leading out.\nYou can buy stuff here.").

description(mellinger, building, "Mellinger", "You are standing in front of Mellinger Appartments.\nYou see a path to the Back 40 to the east, Witmer to the south, and south complex to the west.").

description(b2, waypoint, "On the Back 40 Path", "You are surrounded by trees and underbrush.\nTo the west you see Mellinger.  The path continues to the east.").
connection(b2, back40, east, checkAwkward).
connection(back40, b2, west, []).
action([confront], awkwardCouple) :- action([scare], awkwardCouple).
action([shoo], awkwardCouple) :- action([scare], awkwardCouple).
action([intimidate], awkwardCouple) :- action([scare], awkwardCouple).
action([scare], awkwardCouple) :- location(awkwardCouple, b2), !, writefw("You scream and rudely scare the awkward couple.  On the bright side, you can now continue down the path.\n"), move(awkwardCouple, southside).
action([scare], awkwardCouple) :- location(awkwardCouple, southside), !, writefw("You scare away the awkward couple again.\n"), move(awkwardCouple, fishbowl).
action([scare], awkwardCouple) :- writefw("You scare away the awkward couple again.\n"), move(awkwardCouple, southside).
checkAwkward :- location(awkwardCouple, b2), !, writefw("You attempt to go down the path, but the awkward couple is blocking it.  It's really rather awkward, but you can't think of a good way to resolve it without confronting them.\n"), fail.
checkAwkward.

dig(b2) :- writefw("You try to dig, but you don't find anything.\n").
dig(back40) :- writefw("You try to dig, but you don't find anything.\n").

toss(awkwardCouple, basketball) :-
	!, writefw("You throw the basketball at the awkward couple! You feel that may have been a little harsh, but they run away...\n"),
	increment_counter(violence),
	location(prot, X),
	move(basketball, X),
	((location(awkwardCouple, southside), move(awkwardCouple, fishbowl));
	move(awkwardCouple, southside)), !.

toss(awkwardCouple, Animal) :-
	stuffedanimal(Animal),
	!, writefw("You don't know what the awkward couple might do to your stuffed animal...\n"),
	fail.

description(b3, waypoint, "On the Back 40 Path", "You are surrounded by trees and underbrush.  To the east you see the Back 40.  The path back to campus continues to the west.").

connection(coveredBridge, starry, south, checkFood).
connection(starry, coveredBridge, north, []).
checkFood :-
	location(troll, coveredBridge), location(X, coveredBridge), food(X), !, writefw("The troll, upon seeing the food on the ground, lets you pass.  Your generosity was noted.\n"), move(troll, nowhere), move(X, nowhere).
checkFood :-
	location(troll, coveredBridge), !, writefw("The troll blocks your path.  It looks hungry, and you feel like you don't want to be its next meal.\n"), fail.
checkFood.

description(back40, place, "Back 40", "You are in the Back 40.  It seems pretty empty...\nYou see a path back to campus to the west.").
description(largeTree, fakeobject, "large tree", "It's a large tree with many branches.").
words(largeTree, [large, big, tree]).
initial(largeTree, back40).
initial(lairKey2, largeTree).
pick_up(largeTree) :-
	writefw("It's a tree.  A big tree.  How are you going to move it?  And why would you want to?\n"),
	fail.
action([shake], largeTree) :- action([search], largeTree).
action([search], largeTree) :-
	location(lairKey2, largeTree), !,
	writefw("You search the tree and find a magnificent golden key hidden in the crook of a branch.  You take the key.\n"),
	move(lairKey2, prot).
action([search], largeTree) :-
	writefw("You continue to search the tree, but find nothing of interest.\n").
see_object(largeTree) :- writefw("You see a large tree in the middle of the field.\n").
action([climb], largeTree) :-
	counter(tree, 2), !,
	increment_counter(tree),
	writefw("You climb to the top of the tree.  You pause, and see four columns of light appear in the field and coalesce into humans wearing futuristic uniforms.  They start to move away, but one, wearing a red shirt, lags a little behind.  A troll suddenly appears and sprints through the field, grabbing him and sprinting away.  The remaining people continue on their journey.\n"),
	increment_counter(imaginary).
action([climb], largeTree) :-
	location(lairKey2, largeTree), !,
	increment_counter(tree),
	writefw("You attempt to climb the tree.  You don't get very far, but you do see a golden key on one of the branches.  You take it.\n"),
	move(lairKey2, prot).
action([climb], largeTree) :-
	increment_counter(tree),
	writefw("You climb to the top of the tree.  Seeing nothing of interest, and suddenly discovering a personal fear of heights, you quickly climb back down.\n").

description(witmer, building, "Witmer", "You are at Witmer.  You remember that it is commonly considered to be the best first-year dorm.\nYou see south complex to the northwest and Mellinger to the north.").

description(fishbowl, room, "Fishbowl", "You're in the Fishbowl.").
