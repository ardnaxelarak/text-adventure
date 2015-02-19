:- include(directives).

description(frey, building, "Outside Frey", "You are standing outside Frey. You see a bike rack, a bunch of flowers, and some other stuff.\nYou see Hoffman to the west, the library to the south, and Kline and Jordan to the northeast.").

dig(frey) :-
	increment_counter(frey_dug),
	counter(frey_dug, X), X < 4, !,
	Y is random(4 - X) + 1,
	writefw("Digging around Frey, you find $%t!\n", [Y]), add_money(Y).
dig(frey) :-
	writefw("You continue to dig around Frey, but find nothing.\n").

description(otherStuff, fakeobject, "other stuff", "It's some generic other stuff, typical to expect to see around a college campus.").
words(otherStuff, [other, stuff]).
initial(otherStuff, frey).
pick_up(otherStuff) :- !, writefw("It's not anything you particularly want to carry around with you...\n"), fail.

description(bikeRack, fakeobject, "bike rack", "It's a rack for putting bicycles while students are in class. It is currently empty.").
look_at(bikeRack) :-
	location(prot, Here),
	location(bike, Here), !,
	writefw("It's a rack for putting bicycles while students are in class. There is currently one bike sitting in it.\n").
look_at(bikeRack) :-
	writefw("It's a rack for putting bicycles while students are in class. It is currently empty.\n"), !.
words(bikeRack, [bike, bicycle, rack]).
initial(bikeRack, frey).
pick_up(bikeRack) :- !, writefw("The bike rack is a little big to be carrying around.\n"), fail.

description(freyFlowers, fakeobject, "flowers", "Many colorful flowers line the outside of Frey.").
words(freyFlowers, [colorful, flowers, flower]).
initial(freyFlowers, frey).
pick_up(freyFlowers) :- !, writefw("As you go to pluck a flower, a wild bulbasaur appears!\nYou decide not to take a flower, and the bulbasaur disappears.\n"), fail.

description(freyLobby, room, "Frey Lobby", "You are standing in the lobby of Frey.\nThere are computer labs to the east, an office hallway to the southeast, stairs leading up, and a door leading outside.").
connection(freyLobby, freySecond, up, checkStairs).

description(officeHallway1, room, "Office Hallway", "You are in the first floor office hallway of Frey. You are outside Dr. Rohrbaugh's office. The hallway continues to the southeast, and leads to the lobby of Frey to the northwest.").

description(officeHallway2, room, "Office Hallway", "You are in the first floor office hallway of Frey. You are outside Dr. Owen's office. The hallway continues to the northwest and southeast.").

description(officeHallway3, room, "Office Hallway", "You are in the first floor office hallway of Frey. You are outside Dr. Weaver's office. The hallway continues to the northwest.").

checkCard :-
	location(idCard, prot), !, writefw("The cashier swipes your id card as you enter.\n").
checkCard :-
	location(tumbleweed, lottieEntrance), !, writefw("The cashier is distracted by the tumbleweed and you manage to slip past unnoticed.\n").
checkCard :-
	writefw("The cashier gives you a stern look as you realize you've misplaced your id card.\n"), fail.

checkStairs :-
	writefw("Would you like to take the [S]tairs or the [E]levator?\n"),
	get_char_set(["Ss", "Ee"], X),
	X = 0,
	writefw("You decide to take the stairs.\n").
checkStairs :-
	writefw("As you move toward the elevator, you discover a creeper hiding inside.\nPerhaps you had better take the stairs...\n"), fail.

description(weaverOffice, room, "Dr. Weaver's Office", "You are standing in Dr. Weaver's office. You see a door leading out to the office hallway.").
connection(officeHallway3, weaverOffice, in, checkDoor(weaverDoor)).
connection(weaverOffice, officeHallway3, out, leaveDoor(weaverDoor)).
canLock(weaverOfficeKey, weaverDoor).
canUnlock(weaverOfficeKey, weaverDoor).

description(weaverDoor, door, "Dr. Weaver's door", "It's the door to Dr. Weaver's office. You see a whiteboard on it.").
init_locked(weaverDoor).
words(weaverDoor, [dr, south, s, left, weaver, 'weavers', door]).
initial(weaverDoor, officeHallway3).

description(wb1, fakeobject, "whiteboard", "It's a whiteboard hanging on Dr. Weaver's door.").
writeable(wb1, "whiteboard", "a dry erase marker", "your hand").
words(wb1, [white, board, whiteboard]).
initial(wb1, officeHallway3).
init_state(message(wb1, "us")).
pick_up(wb1) :-
	writefw("You have no use for Dr. Weaver's whiteboard.\n"), !, fail.

description(pen, fakeobject, "whiteboard pen", "It's a whiteboard pen.").
words(pen, [pen, whiteboard]).
initial(pen, officeHallway3).
pick_up(pen) :-
	writefw("You don't need a whiteboard pen.\n"), fail.

description(owenOffice, room, "Dr. Owen's Office", "You are standing in Dr. Owen's office. There are many papers lying about the office. You see a door leading out to the office hallway.").
connection(officeHallway2, owenOffice, in, checkDoor(owenDoor)).
connection(owenOffice, officeHallway2, out, leaveDoor(owenDoor)).
canLock(owenOfficeKey, owenDoor).
canUnlock(owenOfficeKey, owenDoor).

description(owenDoor, door, "Dr. Owen's door", "It's the door to Dr. Owen's office.").
init_locked(owenDoor).
words(owenDoor, [dr, southwest, sw, owen, middle, 'owens', door]).
initial(owenDoor, officeHallway2).

description(rohrbaughOffice, room, "Dr. Rohrbaugh's Office", "You are in Dr. Rohrbaugh's office.\nVarious papers are strewn about, and Dr. Rohrbaugh is nowhere to be seen.\nOutside is the office hallway.").
connection(officeHallway1, rohrbaughOffice, in, checkDoor(rohrbaughDoor)).
connection(rohrbaughOffice, officeHallway1, out, leaveDoor(rohrbaughDoor)).
canLock(rohrbaughOfficeKey, rohrbaughDoor).
canUnlock(rohrbaughOfficeKey, rohrbaughDoor).

description(rohrbaughDoor, door, "Dr. Rohrbaugh's door", "It's the door to Dr. Rohrbaugh's office.").
init_locked(rohrbaughDoor).
words(rohrbaughDoor, [dr, rohrbaugh, west, w, right, 'rohrbaughs', door]).
initial(rohrbaughDoor, officeHallway1).

description(papers, fakeobject, "papers", "They are a bunch of miscellaneous papers such as you would expect to find in any professor's office.").
look_at(papers) :-
	location(prot, hareOffice), !,
	writefw("They are a bunch of miscellaneous papers such as you would expect to find in any professor's office. On one of them the letters 'sa' have been neatly written.\n").
look_at(papers) :-
	location(prot, weaverOffice), !,
	writefw("They are a bunch of miscellaneous papers such as you would expect to find in any professor's office. Oddly enough, they all seem to be blank.\n").
look_at(papers) :-
	location(prot, rohrbaughOffice), !,
	writefw("They are a bunch of miscellaneous papers such as you would expect to find in any professor's office. On one of them you see written the word 'age'.\n").
look_at(papers) :-
	location(prot, fishOffice), !,
	writefw("They are a bunch of miscellaneous papers such as you would expect to find in any professor's office. Scribbled on the back of one, you observe the digraph 'ro'.\n").
look_at(papers) :-
	location(prot, owenOffice), !,
	writefw("They are a bunch of miscellaneous papers such as you would expect to find in any professor's office. On one of them you find the letters 'll'\n").
words(papers, [papers, paper]).
initial(papers, rohrbaughOffice).
initial(papers, owenOffice).
initial(papers, fishOffice).
initial(papers, hareOffice).
initial(papers, weaverOffice).
pick_up(papers) :- writefw("You have no use for these papers.\n"), fail.

description(freySecond, room, "Second Floor Frey", "You are in the lobby of the second floor of Frey. Inexplicably, the only room you can see is Dr. Fish's office.\nThere are stairs leading both up and down.").
connection(freySecond, freyThird, up, checkStairs).
connection(freySecond, freyLobby, down, checkStairs).

description(fishOffice, room, "Dr. Fish's Office", "You are standing inside Dr. Fish's office. It looks surprisingly neat, with a stack of papers on his desk.").
connection(freySecond, fishOffice, in, checkDoor(fishDoor)).
connection(fishOffice, freySecond, out, leaveDoor(fishDoor)).
canLock(fishOfficeKey, fishDoor).
canUnlock(fishOfficeKey, fishDoor).
dig(fishOffice) :-
	writefw("You dig a hole in Dr. Fish's floor, and fall through into Dr. Rohrbaugh's office. The hole somehow closes up after you fall through.\n"),
	will_move(prot, fishOffice, rohrbaughOffice),
	update_moves,
	look.

description(fishDesk, fakeobject, "Dr. Fish's desk", "It's a scaly desk shaped like a fish.").
words(fishDesk, [fish, fishs, desk]).
initial(fishDesk, fishOffice).
pick_up(fishDesk) :-
	writefw("Dr. Fish's desk is a little big to be carrying around.\n"), fail.

description(fishDoor, door, "Dr. Fish's door", "It's the door to Dr. Fish's office.").
init_locked(fishDoor).
words(fishDoor, [dr, fish, 'fishs', door]).
initial(fishDoor, freySecond).

description(freyThird, room, "Third Floor Frey", "You are in the lobby of the third floor of Frey. Be careful you don't fall!\nYou see a door into Dr. Hare's office, and stairs leading down.").
connection(freyThird, freySecond, down, checkStairs).

description(hareOffice, room, "Dr. Hare's Office", "You are standing inside Dr. Hare's office. You see a stack of papers on a filing cabinet.").
connection(freyThird, hareOffice, in, checkDoor(hareDoor)).
connection(hareOffice, freyThird, out, leaveDoor(hareDoor)).
canLock(hareOfficeKey, hareDoor).
canUnlock(hareOfficeKey, hareDoor).
dig(hareOffice) :-
	writefw("You dig a hole in Dr. Hare's floor, and fall through into Dr. Fish's office. The hole somehow closes up after you fall through.\n"),
	will_move(prot, hareOffice, fishOffice),
	update_moves,
	look.

description(hareDoor, door, "Dr. Hare's door", "It's the door to Dr. Hare's office.").
init_locked(hareDoor).
words(hareDoor, [dr, hare, 'hares', door]).
initial(hareDoor, freyThird).

description(hareCabinet, fakeobject, "Dr. Hare's filing cabinet", "It's Dr. Hare's filing cabinet. It holds papers and stuff.").
words(hareCabinet, [dr, hare, hares, cabinet, filing]).
initial(hareCabinet, hareOffice).
pick_up(hareCabinet) :-
	writefw("You try to pick up the filing cabinet, but it's way too heavy.\n"), fail.
action([search], hareCabinet) :-
	writefw("You attempt to search through Dr. Hare's cabinet, but it is locked, presumably to prevent snooping students such as yourself from getting into it.\n").

description(labs, room, "Computer Labs", "You are standing in a computer lab. You see a bunch of computers and a few printers.").

description(labPrinter, fakeobject, "lab printer", "Two printers sit at the front of the room to meet the printing needs of students.").
words(labPrinter, [lab, printer, printers]).
initial(labPrinter, labs).
pick_up(labPrinter) :-
	writefw("The printers are far too heavy, and would be of no use to you once disconnected from the network anyway.\n"), fail.

description(labComputer, fakeobject, "lab computers", "Several rows of computers fill the room.").
words(labComputer, [lab, computer, computers]).
initial(labComputer, labs).
pick_up(labComputer) :-
	writefw("The computers are tied down. Even if you wanted to take one of these heavy machines, you would be unable to.\n"), fail.

description(p2, waypoint, "Path between Eisenhower and North Complex", "You are on a path between North Complex to the northeast and Eisenhower to the southwest.\nBeautiful pink trees line the path.").

description(outsideEisenhower, building, "Outside Eisenhower", "You are standing outside an entrance to the upstairs of Eisenhower. You see a bike rack, a door leading in, Hoffman to the southeast, Kline and Jordan to the east, and a path leading to North Complex to the northeast.").
initial(bikeRack, outsideEisenhower).

description(lottieEntrance, room, "Entrance to Lottie", "You are standing outside the Lottie Nelson Dining Hall.\nYou see a door leading outside, and some stairs leading down.").

description(lottie, room, "Lottie Nelson Dining Hall", "You are standing inside the Lottie Nelson Dining Hall.").
connection(lottieEntrance, lottie, in, checkCard).
connection(lottie, lottieEntrance, out, []).

description(eisenhowerLobby, room, "Lobby of Eisenhower", "You are standing in the lobby inside Eisenhower.\nYou see stairs leading up, a door leading outside, a door leading into the campus store, and Sollenberger Sports Center to the north.").

description(sports, room, "Sollenberger Sports Center", "You are standing in a hallway inside Sollenberger Sports Center.\nYou see the main entrance to campus to the north, and Eisenhower to the south.").

description(ecc, building, "Eisenhower Circle", "You are standing at the Eisenhower circle.\nYou see a door leading back into Eisenhower, as well as Boyer to the south, and a parking lot to the southwest.").

description(campusStore, room, "Campus Store", "You are standing in the campus store. You might be able to buy something here, if you had the money.\nYou see a door leading outside to the lobby in Eisenhower.").

description(oldMain, building, "Old Main", "You are standing outside Old Main.\nYou see Boyer hall in the distance to the east, as well as the much nearer Climenhaga and High Centers to the south and southwest, and a parking lot to the northeast.").

description(chapel, building, "Hostetter Chapel", "You are standing outside of Hostetter Chapel. You aren't really sure what the building is used for, but you are sure it serves some purpose...\nBushes line the front of the building.\nTo the east you see the library, and to the west you see Boyer.").

description(chapelBushes, fakeobject, "bushes", "Several green bushes line the front of the chapel.").
words(chapelBushes, [bushes, bush, green]).
initial(chapelBushes, chapel).
pick_up(chapelBushes) :- !, writefw("You have no use for a bush.\n"), fail.

description(library, building, "Murray Library", "You are standing outside the Murray Library.\nSeveral trees are in front of the building.\nYou see Frey to the north and Hostetter chapel to the west.").

description(libraryTrees, fakeobject, "trees", "Several trees stand in front of the library.").
words(libraryTrees, [tree, trees]).
initial(libraryTrees, library).
pick_up(libraryTrees) :-
	writefw("You do not feel like futily attempting to uproot one of these at the moment.\n"), fail.
action([climb], libraryTrees) :-
	writefw("You attempt to climb one of the trees, but are unsuccessful.\n").

checkBook :-
	location(importantBook, prot),
	unchecked(importantBook), !,
	writefw("As you begin to leave the library, the alarm goes off and you realize you did not check out the book you are carrying. You return to the lobby.\n"), fail.
checkBook.

action([check,out], importantBook) :-
	location(prot, coffeeShop), !, writefw("The circulation desk is located in the lobby, to the east.\n").
action([check,out], importantBook) :-
	location(prot, bookStacks), !, writefw("The circulation desk is located upstairs.\n").
action([check,out], importantBook) :-
	not(location(prot, insideLibrary)), !, writefw("How can you check something out when you are not in the library?\n").
action([check,out], importantBook) :-
	not(unchecked(importantBook)), !, writefw("You already checked out your book. There is no need to do so again.\n").
action([check,out], importantBook) :-
	not(location(idCard, prot)), !, writefw("You go to the circulation desk to check out your book, but realize you do not have your id card. The receptionist takes the book to return to the book stacks.\n"), move(importantBook, nowhere).
action([check,out], importantBook) :-
	!, writefw("You go to the circulation desk and give your id card and the book to the receptionist.\nHe or she (you can't really be sure of the gender) scans the book and returns it and the card to you.\nYour book is due at some irrelevant point in the future past the ending of this game.\n"),
	retract(unchecked(importantBook)).

description(insideLibrary, room, "Library Lobby", "You are standing in the lobby of Murray Library. A coffee shop is located to the west, and stairs lead down to the main book stacks.").
connection(library, insideLibrary, in, []).
connection(insideLibrary, library, out, checkBook).

description(bookStacks, room, "Main Book Stacks", "You are standing among the main stacks. Stairs lead up to the lobby.").

description(coffeeShop, room, "Cafe Diem", "You are standing at the coffee shop in the library. You can buy stuff here. The lobby is to the east.").

description(p, waypoint, "Visitor Parking Lot", "You see a lot of cars.\nYou see Eisenhower circle to the northeast and Old Main to the southwest.").

description(dormRoom, room, "Dorm Room", "You are in your dorm room.").

