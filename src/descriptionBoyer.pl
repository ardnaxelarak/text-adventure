:- include(directives).

description(boyer, building, "Boyer", "You feel a shudder as you watch humanities majors scurry into and out of Boyer as though they actually had something important to do. The building looks dark and foreboding. You see Hostetter chapel to the east, Hoffman to the northeast, and Eisenhower circle to the north, as well as Old Main in the distance to the west and Climenhaga off to the southwest.").
connection(boyer, boyerFirst, in, (light_source; (state(boyer_tried), writefw("You reluctantly enter the dark building.\n")); (writefw("You don't want to go in there; it is dark and scary!\n"), set_state(boyer_tried), fail))).

description(boyerFirst, room, "First Floor Hallway", "You are in the first floor hallway of Boyer. You see Howe Atrium to the west, Parmer Cinema to the east, and stairs leading up to the second floor.").
dark(boyerFirst).
connection(boyerFirst, boyer, out, writefw("You exit Boyer.\n")).

description(parmerCinema, room, "Parmer Cinema", "You are in Parmer Cinema; there are a bunch of seats and a giant screen in the front of the room. The first floor hallway is to the west.").
dark(parmerCinema).
adjacent(boyerFirst, parmerCinema, east, west).

description(parmerSeats, fakeobject, "seats", "You see several rows of seats filling the room.").
words(parmerSeats, [seats, seat, row, chair]).
initial(parmerSeats, parmerCinema).
pick_up(parmerSeats) :-
	writefw("The seats are screwed to the floor, but there might be some junk you could find by searching around the seats.\n"),
	fail.
action([search], parmerSeats) :-
	location(lairKey3, parmerSeats), !,
	writefw("Searching under the seats, you find a silver tarnished key, and pick it up.\n"),
	move(lairKey3, prot).
action([search], parmerSeats) :-
	writefw("You continue to seach through the seats, but find nothing you would want to take...\n").

description(howeAtrium, room, "Howe Atrium", "You are in Howe Atrium; you see tables and chairs, and no windows for some strange reason. The hallway is to the east.").
dark(howeAtrium).
adjacent(boyerFirst, howeAtrium, west, east).

description(boyerSecond, room, "Second Floor Hallway", "You are in the second floor hallway of Boyer. You see classrooms to the east and west, and stairs leading up and down.").
dark(boyerSecond).
adjacent(boyerFirst, boyerSecond, up, down).

description(boyerSecondRoomE, room, "Classroom", "You are in a classroom on the second floor of boyer. You see several rows of chairs, and a chalkboard in the front of the room. There is a door leading to the hallway to the west.").
dark(boyerSecondRoomE).
adjacent(boyerSecond, boyerSecondRoomE, east, west).

description(bb1, fakeobject, "chalkboard", "It a big chalkboard on the wall of the room.").
writeable(bb1, "chalkboard", "a piece of chalk", "the eraser").
words(bb1, [black, chalk, board, blackboard, chalkboard]).
initial(bb1, boyerSecondRoomE).
init_state(message(bb1, "Beware the Tigerram!")).
pick_up(bb1) :-
	writefw("It's a big chalkboard on the wall; there's no way you could take it.\n"), fail.

description(boyerSecondRoomW, room, "Classroom", "You are in a classroom on the second floor of boyer. You see many chairs and desks, and a blackboard. There is a door leading to the hallway to the east.").
dark(boyerSecondRoomW).
adjacent(boyerSecond, boyerSecondRoomW, west, east).

description(bb2, fakeobject, "chalkboard", "It a big chalkboard on the wall of the room.").
writeable(bb2, "chalkboard", "a piece of chalk", "the eraser").
words(bb2, [black, chalk, board, blackboard, chalkboard]).
initial(bb2, boyerSecondRoomW).
init_state(message(bb2, "By the mystic regulation of our dark association...")).
pick_up(bb2) :-
	writefw("It's a big chalkboard on the wall; there's no way you could take it.\n"), fail.

description(boyerThird, room, "Third Floor Hallway", "You are in the third floor hallway of Boyer. You see stairs leading up and down.").
dark(boyerThird).
adjacent(boyerSecond, boyerThird, up, down).

description(boyerThirdRoom, room, "Classroom", "You are in a classroom on the third floor of boyer. There are many tables, as well as chairs and a blackboard. There is a door leading to the hallway to the east.").
dark(boyerThirdRoom).
adjacent(boyerThird, boyerThirdRoom, west, east).

description(bb3, fakeobject, "chalkboard", "It a big chalkboard on the wall of the room.").
writeable(bb3, "chalkboard", "a piece of chalk", "the eraser").
words(bb3, [black, chalk, board, blackboard, chalkboard]).
initial(bb3, boyerThirdRoom).
% init_state(message(bb3, "See wes ne!")).
pick_up(bb3) :-
	writefw("It's a big chalkboard on the wall; there's no way you could take it.\n"), fail.

description(boyerFourth, room, "Fourth Floor Hallway", "You are in the fourth floor hallway of Boyer. You see the philosophy department to the southeast, and stairs leading down.").
dark(boyerFourth).
adjacent(boyerThird, boyerFourth, up, down).

%description(philDept, room, "Philosophy Department", "You are standing between the offices of the four philosophy professors; to the south you see Dr. Schenk's office; to the southeast, Dr. Collins's office; to the east, Dr. Schoettle's office, and to the northeast, Dr. Miller's office. The fourth floor hallway is to the northwest.").
description(philDept, room, "Philosophy Department", "You are standing between the offices of the four philosophy professors. The fourth floor hallway is to the northwest.").
dark(philDept).
adjacent(philDept, boyerFourth, northwest, southeast).

description(chalk, fakeobject, "chalk", "It's a piece of chalk sitting on the tray under the chalkboard.").
words(chalk, [chalk, piece]).
initial(chalk, boyerSecondRoomE).
initial(chalk, boyerSecondRoomW).
initial(chalk, boyerThirdRoom).
pick_up(chalk) :-
	writefw("You don't need a piece of chalk.\n"), fail.

description(eraser, fakeobject, "chalkboard eraser", "It's an eraser for erasing the chalkboard.").
words(eraser, [eraser]).
initial(eraser, boyerSecondRoomE).
initial(eraser, boyerSecondRoomW).
initial(eraser, boyerThirdRoom).
pick_up(eraser) :-
	writefw("You have no use for a chalkboard eraser.\n"), fail.
