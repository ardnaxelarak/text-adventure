:- include(directives).

pick_up(Person) :-
	description(Person, person, Name, _), !,
	writefw("You don't think %s would appreciate that.\n", [Name]),
	fail.

description(fish, person, "Dr. Fish", "It's Dr. Fish.  He's supposedly an engineer.").
words(fish, [randall, randy, fish, dr, engineer, engineering, prof, professor]).
wanders(fish, [freyLobby, freySecond, freyThird, labs, fishOffice, frey, klineJordan]).
initial(fish, fishOffice).
see_person(fish) :- writefw("You see Dr. Fish.\n").
sequential_statements(fish,
	["Hello.  I'm Dr. Fish.  Nice to meet you.",
	"Oh, you're looking for Dr. Rohrbaugh?  Give me a moment.",
	"I heard from one of my students that they saw him doing something around the swinging bridge.",
	"Good luck!"]).
toss(fish, Animal) :-
	stuffedanimal(Animal), !,
	get_name(Animal, Name),
	writefw("You throw the %s at Dr. Fish. He doesn't seem to notice.\n", [Name]),
	location(prot, Here),
	move(Animal, Here).

description(owen, person, "Dr. Owen", "It's Dr. Owen, a CIS professor.  He's best known for teaching the programming courses.").
words(owen, [david, owen, dr, cis, prof, professor]).
initial(owen, owenOffice).
wanders(owen, [freyLobby, labs, freySecond, freyThird, officeHallway1, officeHallway2, officeHallway3, owenOffice]).
see_person(owen) :- writefw("You see Dr. Owen.\n").
sequential_statements(owen, ["Hello.  Can I help you with something?",
	"Oh, you're looking for Dr. Rohrbaugh.  Let me think...",
	"Oh, yeah.  This part is tough.",
	"People tend to hide keys and money in the ground.  That may be useful.",
	"Good luck!"]).

description(weaver, person, "Dr. Weaver", "It's Dr. Weaver, a CIS professor.  He teaches the web development and database classes.").
words(weaver, [scott, daniel, weaver, dr, cis, prof, professor]).
initial(weaver, freyLobby).
wanders(weaver, [freyThird, freySecond, freyLobby, officeHallway1, officeHallway2, officeHallway3, weaverOffice, klineJordan, hoffman, lottieEntrance, lottie, outsideEisenhower]).
see_person(weaver) :- writefw("You see Dr. Weaver.\n").
sequential_statements(weaver, ["Hi.  It's good to see you.",
	"You're looking for Dr. Rohrbaugh?  I don't know if...",
	"Have you ever heard the legend of the Tigerram?",
	"Dr. Rohrbaugh was recently obsessed with it.",
	"As the story goes, the tigerram is a terrible monster.",
	"Scholars say it turns up infrequently, usually to some terrible end.",
	"Dr. Rohrbaugh seemed to think there was some connection between himself and the tigerram.",
	"Perhaps he discovered something related to it?"]).

description(hare, person, "Dr. Hare", "It's Dr. Hare, head of the IMS department.  She's good at math.").
words(hare, [angela, hare, dr, math, ims, prof, professor]).
initial(hare, hareOffice).
wanders(hare, [hareOffice, freyThird, freySecond, freyLobby, officeHallway1, officeHallway2, officeHallway3, frey, klineJordan]).
see_person(hare) :- writefw("You see Dr. Hare.\n").
sequential_statements(hare, ["Hi.  How are you doing?",
	"You're looking for Dr. Rohrbaugh?  I'd ask the other CIS professors.",
	"Actually, now that I think about it, there might be something useful near Witmer.",
	"Good luck finding him!"]).

description(chaney, person, "Nathan Chaney", "It's Nathan Chaney, a computer science and engineering major.  He's the coolest person around, by far.").
words(chaney, [chaney, nathan, nrc, nc, nate]).
initial(chaney, northComplex).
wanders(chaney, [northComplex, engle, union, southComplex, klineJordan, frey, freyLobby, freySecond, freyThird, hoffman, lottie, lottieEntrance, outsideEisenhower, p2, fishbowl]).
see_person(chaney) :- writefw("You see Nathan Chaney.\n").
sequential_statements(chaney, ["I hear the president has some special power that no one can identify.",
	"To get to her, you'll need to get past the secret service.  For some reason they really like crickets.",
	"Good luck!"]).
kill(chaney, _) :- !, writefw("That might be a little harsh...\n").

description(smith, person, "Rebekah Smith", "It's Rebekah Smith.  She's one of the few female CIS majors.  She's also pretty weird...").
words(smith, [rebekah, smith, bekah, rps, rs, recky, paige, female, cis, major]).
initial(smith, y1).
wanders(smith, [y1, y2, y3, y4, y5, swingingBridge, secretLair, climenhaga, coveredBridge, starry]).
see_person(smith) :- writefw("You see Rebekah Smith.\n").
random_statements(smith, ["Oh, I know Dr. Rohrbaugh.  He's my advisor!  He's pretty cool!",
	"I heard that Dr. Rohrbaugh is missing...",
	"I love wandering around here.  There's some really interesting stuff if you know where to look!",
	"Dr. Weaver is an awesome professor! You probably should go talk to him at some point!"]).
give(smith, stuffedDragon) :-
	!, writefw("Recky happily takes the stuffed dragon; her face lights up with a smile filled with madness and she gives you a knife. She then claims that she's not that crazy.\n"),
	move(knife, prot).
toss(smith, stuffedDragon) :-
	!, writefw("Recky catches the stuffed dragon; her face lights up with a smile filled with madness and she gives you a knife. She then claims that she's not that crazy.\n"),
	move(knife, prot),
	move(stuffedDragon, smith).
toss(smith, stuffedFrog) :-
	!, writefw("Rebekah cathes the stuffed frog, and throws it back to you.\n").
toss(smith, Animal) :-
	stuffedanimal(Animal), !,
	get_name(Animal, Name),
	writefw("Rebekah catches the %s and rips it to shreds.\n", [Name]),
	move(Animal, nowhere).
kill(smith, knife) :-
	!, writefw("She gave you that knife! It would be very rude to attack her with it.\n").
kill(smith, sword) :-
	location(knife, smith),
	!, writefw("As you move to attack Bekah with your imaginary sword, she strikes the first blow with her very real knife, killing you.\n"), die.
kill(smith, _) :-
	not(location(knife, smith)), !,
	writefw("It would be very rude to attack her now that she no longer has her knife to defend herself.\n").

description(phipps, person, "Kim Phipps", "It's Kim Phipps, president of the college.  She's immensely powerful.").
words(phipps, [kim, phipps, dr, president, prof, professor]).
initial(phipps, presidentHouse).
see_person(phipps) :- writefw("You see Kim Phipps nearby.\n").
sequential_statements(phipps, ["Hello.  How did you get past my guards?",
	"Well, no matter.  You're looking for Dr. Rohrbaugh?",
	"Actually, I don't know where he is.  But others might.",
	"Give me a moment to gather my power.",
	"Very well.  At some point in your journey you will need three keys.",
	"One is on the Back 40.  Another is in Starry Field.",
	"The last is in Parmer Cinema.",
	"I wish I could help you more, but even my power has limits."]).
kill(phipps, _) :-
	writefw("As you try to attack Kim Phipps, she summons her secret service who kill you (metaphorically and literally speaking, of course)\n"), die, !, fail.

description(thompson, person, "Berte Thompson", "It's Berte Thompson, the director of ITS").
words(thompson, [berte, thompson, its]).
initial(thompson, hoffman).
see_person(thompson) :- writefw("You see Berte Thompson nearby.\n").
sequential_statements(thompson, ["Hello.  You're looking for Dr. Rohrbaugh?",
	"I'm afraid I don't know where he is.",
	"However, I think there's a password you will need.",
	"Each professor in Frey has a part of the password in their office.",
	"There are five pieces in total.  Good luck!"]).

description(felix, person, "Kara Felix", "It's Kara Felix, a mysterious character who throws stuffed animals at people.").
words(felix, [animal, thrower, stuffed, weirdo, mysterious, character, kara, felix, kf]).
initial(felix, southComplex).
wanders(felix, [southComplex, frey, freyLobby, union, northComplex, klineJordan, hoffman, outsideEisenhower, lottieEntrance, lottie]).
picks_up(felix, X) :-
	stuffedanimal(X).
see_person(felix) :- writefw("You see a mysterious character throwing stuffed anmials.\n").
talk_to(felix) :-
	counter(thrower_happiness, X), X >= 2,
	location(stuffedPenguin, cStore), !,
	writefw("\"Hey, I saw a really cool stuffed penguin at the campus store.\"\n").
talk_to(felix) :-
	counter(thrower_happiness, X), X >= 2,
	location(stuffedPenguin, prot),
	not(state(penguin_given)), !,
	writefw("\"Hey, that's a neat stuffed penguin you've got there!\"\n").
talk_to(felix) :-
	location(Animal, prot),
	stuffedanimal(Animal),
	(state(penguin_given); Animal \= stuffedPenguin), !,
	get_name(Animal, Name),
	writefw("\"Please return my %s.\"\n", [Name]).
talk_to(felix) :-
	writefw("Kara doesn't seem to have anything to say to you at the moment.\n").

animal_thrown(Animal, 0) :-
	get_name(Animal, Name),
	writefw("You take the %s. Kara does not seem very happy.\n", [Name]),
	decrement_counter(thrower_happiness),
	move(Animal, prot), !.
animal_thrown(Animal, 1) :-
	get_name(Animal, Name),
	increment_counter(thrower_happiness),
	writefw("You throw the %s back at Kara. She catches it and seems grateful that you returned it.\n", [Name]), !.
animal_thrown(Animal, 2) :-
	get_name(Animal, Name),
	writefw("You let the %s rest where it landed.\n", [Name]),
	location(prot, Location),
	move(Animal, Location), !.

enter(felix) :-
	findall(X, (location(X, felix), stuffedanimal(X)), List),
	length(List, L),
	L > 0,
	X is random(L),
	nth0(X, List, Item), !,
	get_name(Item, Name),
	writefw("Kara throws a %s at you!\nYou really shouldn't be surprised by that...\n", [Name]),
	writefw("You can [G]rab it, [T]hrow it back, or [L]eave it on the ground.\n"),
	get_char_set(["Gg", "Tt", "Ll"], Y),
	animal_thrown(Item, Y), !, fail.
enter(felix) :-
	writefw("Kara asks you to return her stuffed animals.\n"), fail.

toss(felix, stuffedPenguin) :-
	not(state(penguin_given)), !,
	counter(thrower_happiness, X),
	writefw("Kara catches the stuffed penguin, and seems extremely pleased with your gift.\n"),
	assert(state(penguin_given)),
	(X < 2;
		writefw("In appreciation for your gift, she gives you a flashlight!\n"),
		move(flashlight, prot)),
	move(stuffedPenguin, felix),
	increment_counter(thrower_happiness),
	increment_counter(thrower_happiness).

give(felix, stuffedPenguin) :-
	not(state(penguin_given)), !,
	counter(thrower_happiness, X),
	writefw("Kara excitedly takes the stuffed penguin, and seems extremely pleased with your gift.\n"),
	assert(state(penguin_given)),
	(X < 2;
		writefw("In appreciation for your gift, she gives you a flashlight!\n"),
		move(flashlight, prot)),
	move(stuffedPenguin, felix),
	increment_counter(thrower_happiness),
	increment_counter(thrower_happiness).

give(felix, Thing) :-
	stuffedanimal(Thing), !,
	get_name(Thing, Name),
	writefw("Kara gratefully takes back her %s.\n", [Name]),
	increment_counter(thrower_happiness).

toss(felix, Thing) :-
	stuffedanimal(Thing), !,
	get_name(Thing, Name),
	writefw("Kara catches the %s, and seems grateful that you returned it.\n", [Name]),
	move(Thing, felix),
	increment_counter(thrower_happiness).

kill(felix, _) :-
	writefw("She's not the villain in this text adventure; why don't you let her live?\n"), !, fail.

description(schenk, person, "Dr. Schenk", "It's Dr. Schenk, a philosophy professor. He teaches the Intro to Logic class.").
words(schenk, [david, schenk, dr, phil, philosophy, prof, professor]).
initial(schenk, boyer).
wanders(schenk, [boyer, boyerFirst, boyerSecond, boyerThird, boyerFourth, philDept, boyerThirdRoom, boyerSecondRoomW, howeAtrium]).
see_person(schenk) :- writefw("You see Dr. Schenk.\n").
random_statements(schenk, ["The mysterious Tigerram will kick your teeth in.",
	"You're looking for Dr. Rohrbaugh? I'm not really sure who he is...",
	"I saw some money around Frey...  Perhaps that could be of use."]).

description(jlong, person, "Jason Long", "It's Jason Long, system administrator and avid board game player.").
words(jlong, [jason, long, its]).
initial(jlong, hoffman).
wanders(jlong, [frey, hoffman, freyLobby, officeHallway1, officeHallway2, officeHallway3, freySecond, freyThird]).
see_person(jlong) :- writefw("You see Jason Long.\n").
sequential_statements(jlong, ["You're looking for Dr. Rohrbaugh?",
	"Sorry, I don't think I can help you with that.",
	"Did you know that 'password' is the most popular password?"]).

description(kilmer, person, "Dr. Kilmer", "It's Dr. Kilmer, a professor of Business and Information Science.").
words(kilmer, [kilmer, robert, bob, dr, business]).
initial(kilmer, freyLobby).
see_person(kilmer) :- writefw("You see Dr. Kilmer.\n").
sequential_statements(kilmer, ["Hello, I'm Dr. Kilmer.",
	"You could get around faster if you had a bicycle.",
	"I saw one around Climenhaga."]).

description(king, person, "Taran King", "It's Taran King, an engineering student.").
words(king, [taran, king]).
initial(king, m5).
wanders(king, [m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15, m16]).
see_person(king) :- writefw("You see Taran King.\n").
picks_up(king, X) :-
	takeable(X).
talk_to(king) :-
	location(X, king), !,
	get_name(X, Name),
	writefw("\"Here, have this %s that I found.\"\n", [Name]),
	move(X, prot).
talk_to(king) :- writefw("\"I'm so lost right now.\"\n").

description(zeigler, person, "Joel Zeigler", "It's Joel Zeigler, engineering student and track team member.").
words(zeigler, [joel, zeigler]).
initial(zeigler, starry).
wanders(zeigler, [starry, coveredBridge, y1, y2, y3, y4, y5, southComplex, climenhaga, high, backEntrance]).
see_person(zeigler) :- writefw("You see Joel Zeigler.\n").
random_statements(zeigler, ["I like trains.",
	"...TRAIN!",
	"First generation diesels... what a beaut.",
	"Well, that's a triple-engine-consist double-stack.",
	"What a Chessie Steam Engine...",
	"Double trainbow!",
	"Intamin, or Bolliger & Mabillard?",
	"It's a Vekoma Boomerang!",
	"You gotta add that slippage.",
	"GCI is dynamo!",
	"HEARTLINE ROLL INTO FLYING SNAKE DIVE!",
	"Schwarzkopf is the man.",
	"Trains and roller coasters are awesome!"]).

description(brisbin, person, "Andew Brisbin", "It's Andrew Brisbin, CIS major.").
words(brisbin, [andrew, andy, brisbin]).
initial(brisbin, starry).
wanders(brisbin, [starry, coveredBridge, y1, y2, y3, y4, y5, climenhaga, high, backEntrance, boyer, oldMain, hoffman, frey]).
see_person(brisbin) :- writefw("You see Andrew Brisbin.\n").
random_statements(brisbin, ["There's a troll on the bridge to Starry Field.  I think it's hungry.",
	"Man, installing Oracle is really tough.",
	"Dr. Rohrbaugh is missing? I wish I'd known so I didn't drive all the way over here for class..."]).

description(llong, person, "Lauren Long", "It's Lauren Long, a sophomore engineering major.").
words(llong, [lauren, long]).
initial(llong, southComplex).
wanders(llong, [northComplex, fishbowl, engle, union, klineJordan, frey, freyLobby, hoffman, p2, outsideEisenhower, lottieEntrance, lottie]).
see_person(llong) :- writefw("You see Lauren Long.\n").
random_statements(llong, ["I saw a lantern around the back entrance to campus.  It might come in handy if you need to see in the dark.",
	"I hope you find Dr. Rohrbaugh!",
	"I think there's important stuff in the offices in Frey."]).

description(kelley, person, "Josiah Kelley", "It's Josiah Kelley, a sophomore engineering student.").
words(kelley, [josiah, kelley]).
initial(kelley, southComplex).
wanders(kelley, [southComplex, fishbowl, union, klineJordan, frey, freyLobby, hoffman, p2, outsideEisenhower, lottieEntrance, lottie, southside]).
see_person(kelley) :- writefw("You see Josiah Kelley.\n").
random_statements(kelley, ["I hear there's a key hidden at the main entrance.",
	"This chair is sticky....",
	"Have you seen Zach Felix?  He throw stuffed animals at people.  It's really weird.",
	"I just fell out of a tree."]).
toss(kelley, Animal) :-
	stuffedanimal(Animal), !,
	get_name(Animal, Name),
	writefw("You throw the %s at Josiah. He catches it, and throws it into a trash can. You retrieve it.\n", [Name]).

description(musselman, person, "Matt Musselman", "It's Matt Musselman, a junior CIS major.").
words(musselman, [matt, mat, matthew, musselman]).
initial(musselman, northComplex).
wanders(musselman, [northComplex, fishbowl, engle, union, klineJordan, frey, freyLobby, hoffman, p2, outsideEisenhower, lottieEntrance, lottie]).
see_person(musselman) :- writefw("You see Matt Musselman.\n").
random_statements(musselman, ["I think there's a key around Naugle.", 
	"No. No, I will not fix your computer. GO AWAY!!",
	"Mwahahahahahaha!!! I am a villain, and I'm getting royalties for this game!",
	"I'm off to work. Again. Money doesn't grow on trees. Some people have to work for a living.", 
	"What did I tell you? 88 miles per hour."]).

description(macgregor, person, "Dan MacGregor", "It's Dan MacGregor, a marketing major.").
words(macgregor, [dan, daniel, mac, gregor, macgregor]).
initial(macgregor, northComplex).
wanders(macgregor, [northComplex, fishbowl, engle, union, klineJordan, frey, freyLobby, hoffman, p2, outsideEisenhower, lottieEntrance, lottie]).
see_person(macgregor) :- writefw("You see Dan MacGregor.\n").
random_statements(macgregor, ["I saw a key around the Engle Center.",
	"Did you see the new Doctor Who episode last night?",
	"I have to update Messiah Terminal, talk to you later!",
	"I'm off to a pulse meeting!"]).

description(stauffer, person, "Jillana Stauffer", "It's Jillana Stauffer, an engineering student.").
words(stauffer, [jillana, stauffer]).
initial(stauffer, northComplex).
wanders(stauffer, [northComplex, fishbowl, union, loft, climbingwall]).
see_person(stauffer) :- writefw("You see Jillana Stauffer.\n").
random_statements(stauffer, ["I'm pretty sure there's a key somewhere near Mellinger.", 
	"Have you seen Rebekah Smith yet? She's my roommate, and she's a bit strange.",
	"I'm headed for the climbing wall! Hooray for downtime!",
	"Engineering is FUN!"]).

description(shuck, person, "Peter Shuck", "It's Pete Shuck, sophomore CIS major, president of the Democrats Club, president of the Swing Club, and tennis player.").
words(shuck, [pete, peter, shuck]).
initial(shuck, southside).
wanders(shuck, [southside, southComplex, northComplex, fishbowl, union, klineJordan, frey, freyLobby, y1, y2, y3, y4, y5, climenhaga, coveredBridge, starry]).
see_person(shuck) :- writefw("You see Peter Shuck.\n").
random_statements(shuck, ["I got lost trying to find my way around the chapel.", 
	"...I am the Lord of Scrum. Why won't anyone believe me???",
	"I just came from a meeting, and now I'm going to a group meeting. Later I have Swing Dance Club. Wow, I'm really busy.",
	"Did you know that I play the bagpipes?"]).

description(degruchy, person, "Avery deGruchy", "It's Avery deGruchy, a junior CIS major. He is very friendly!"). % key at boyer
words(degruchy, [avery, degruchy, de, gruchy, cis]).
initial(degruchy, northComplex).
wanders(degruchy, [northComplex, fishbowl, engle, union, klineJordan, frey, freyLobby, hoffman, p2, outsideEisenhower, lottieEntrance, lottie]).
see_person(degruchy) :- writefw("You see Avery deGruchy.\n").
random_statements(degruchy, ["I think Dr. Rohrbaugh's key is near Boyer.  He teaches linguistics classes, so he has conenctions there.",
	"Have a great day! Keep smiling!",
	"I'm really busy, shoot me a text and I will try to get back to you!"]).

description(caracci, person, "Kayla Caracci", "A very awesome and lovely film major!").
words(caracci, [kayla, caracci]).
initial(caracci, parmerCinema).
see_person(caracci) :- writefw("You see Kayla Caracci\n").
random_statements(caracci, ["For some reason I think that Bekah likes that strange stuffed dragon.",
	"My toes are cold. Where is my blanket?",
	"Apples are too loud to eat in here.",
	"The projector is broken; we can't watch the movie."]).

description(trinkle, person, "Mark Trinkle", "A very awesome film major!").
words(trinkle, [mark, trinkle]).
initial(trinkle, parmerCinema).
see_person(trinkle) :- writefw("You see Mark Trinkle\n").
random_statements(trinkle, ["I like trains.",
	"You should watch Fringe, it's an awesome show!",
	"I really wish I could travel the world, but I am stuck in Parmer..."]).
