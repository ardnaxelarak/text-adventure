:- include(directives).

description(shovel, object, "shovel", "It is a shovel with a vague reddish hue that you hope is rust.").
weapon(shovel).
words(shovel, [reddish, shovel]).
see_object(shovel) :- writefw("You see here a reddish shovel.\n").
pick_up(shovel) :- writefw("You pick up the shovel.\n").
put_down(shovel) :- 
	location(prot, Place),
	room(Place), writefw("You gently lay the shovel on the floor.\n").
put_down(shovel) :- 
	writefw("You gently lay the shovel on the ground.\n").
initial(shovel, prot).

description(basketball, object, "basketball", "It is a basketball.").
weapon(basketball).
words(basketball, [basketball, basket, ball]).
see_object(basketball) :- writefw("You see a basketball.\n").
pick_up(basketball) :- writefw("You pick up the basketball.\n").
put_down(basketball) :- writefw("You drop the basketball.\n").
initial(basketball, sports).

description(lantern, lightsource, "lantern", "It is a lantern. It gives off light.").
look_at(lantern) :-
	state(lantern_on), !, writefw("It is a lantern. It is currently lit.\n").
look_at(lantern) :-
	!, writefw("It is a lantern. It is currently unlit.\n").
init_state(lantern_on).
words(lantern, [lantern, light]).
initial(lantern, nowhere). % dig at back entrance
see_object(lantern) :- writefw("You see a lantern.\n").
pick_up(lantern) :- writefw("You pick up the lantern.\n").
put_down(lantern) :- writefw("You put down the lantern.\n").

description(flashlight, lightsource, "flashlight", "It is a flashlight.").
init_state(flashlight_on).
look_at(flashlight) :-
	state(flashlight_on), !, writefw("It is a flashlight. It is currently turned on.\n").
look_at(flashlight) :-
	!, writefw("It is a flashlight. It is currently turned off.\n").
words(flashlight, [flashlight, flash, light]).
see_object(flashlight) :- writefw("You see here a flashlight.\n").
pick_up(flashlight) :- writefw("You pick up the flashlight.\n").
put_down(flashlight) :- writefw("You drop the flashlight.\n").
initial(flashlight, felix).

% ---imaginary---
description(sword, object, "imaginary sword", "It is a sword that does not actually exist.").
weapon(sword).
words(sword, [imaginary, sword]).
initial(sword, chapel).
see_object(sword) :-
	location(prot, chapel), !, writefw("You see an imaginary sword in one of the bushes.\n").
see_object(sword) :- writefw("You see an imaginary sword.\n").
pick_up(sword) :- increment_counter(imaginary), writefw("You lift the sword as though it were nothing.\n").
put_down(sword) :-
	location(prot, chapel), decrement_counter(imaginary), writefw("You place the sword back in the bushes.\n").
put_down(sword) :- 
	decrement_counter(imaginary), writefw("You put down the imaginary sword.\n").
	
description(apple, object, "imaginary apple", "It is an apple that does not actually exist.").
food(apple).
words(apple, [imaginary, apple]).
initial(apple, uStore).
see_object(apple) :- writefw("You see an imaginary apple.\n").
purchased(apple) :- increment_counter(imaginary).
pick_up(apple) :- increment_counter(imaginary), writefw("You just picked up an imaginary apple!\n").
eat(apple) :- writefw("It isn't real... You can't eat it.\n"), !, fail.
put_down(apple) :- 
	decrement_counter(imaginary), writefw("You put down the imaginary apple.\n").
	
description(kiwi, object, "imaginary kiwifruit", "It is a kiwifruit that does not actually exist.").
food(kiwi).
words(kiwi, [imaginary, kiwi, fruit, kiwifruit]).
initial(kiwi, ssStore).
see_object(kiwi) :- writefw("You see an imaginary kiwifruit.\n").
purchased(kiwi) :- increment_counter(imaginary).
pick_up(kiwi) :- increment_counter(imaginary), writefw("You just picked up an imaginary kiwifruit!\n").
eat(kiwi) :- writefw("It isn't real... You can't eat it.\n"), !, fail.
put_down(kiwi) :- 
	decrement_counter(imaginary), writefw("You put down the imaginary kiwifruit.\n").
% ---imaginary---

description(libraryBookStacks, fakeobject, "book stacks", "Many shelves of books fill the room.").
words(libraryBookStacks, [book, books, shelves, shelf, shelfs, stacks, stack]).
initial(libraryBookStacks, bookStacks).
pick_up(libraryBookStacks) :-
	location(importantBook, nowhere), !,
	writefw("Searching through the book stacks, you find one entitled 42 Ways to Finish a Project, and take it with you.\n"),
	move(importantBook, prot), fail.
pick_up(libraryBookStacks) :-
	writefw("You continue to seach through the book stacks, but find nothing of interest.\n"), fail.
action([search], libraryBookStacks) :-
	location(importantBook, nowhere), !,
	writefw("Searching through the book stacks, you find one entitled 42 Ways to Finish a Project, and take it with you.\n"),
	move(importantBook, prot).
action([search], libraryBookStacks) :-
	writefw("You continue to seach through the book stacks, but find nothing of interest.\n").

description(importantBook, object, "book", "42 Ways to Finish a Project").
unchecked(importantBook).
words(importantBook, [book, ways, project, 42, finish]). 
initial(importantBook, nowhere).
see_object(importantBook) :-
	location(importantBook, l2), !.
see_object(importantBook) :- writefw("There is an important book here!\n").
pick_up(importantBook) :-
	location(importantBook, l2), !,
	writefw("You can't take that back, it is part of the door now...\n"), fail.
pick_up(importantBook) :-
	writefw("You pick up the book.\n").
put_down(importantBook) :-
	location(prot, bookStacks), !,
	writefw("You place the book carefully back into the book shelves where you found it.\n"),
	move(importantBook, nowhere), fail.
put_down(importantBook) :-
	location(prot, l2), !,
	writefw("As you set the book on the shelf, you hear a click and the bookshelf swings forward.\n"),
	retract(locked(door3)),
	assertz(unlocked(door3)).	
put_down(importantBook) :-
	(location(prot, insideLibrary); location(prot, coffeeShop)), !,
	writefw("You should not leave a library book sitting around!\nEither give it to the receptionist or return it downstairs.\n"), fail.
put_down(importantBook) :-
	writefw("You put down the book.\n").

description(knife, object, "knife", "It is a beautiful pocket knife.").
weapon(knife).
words(knife, [pocket, knife, beautiful]).
see_object(knife) :- writefw("You see here a beautiful pocket knife.\n").
pick_up(knife) :- writefw("You pick up the pocket knife.\n").
put_down(knife) :- writefw("You drop the pocket knife.\n").
initial(knife, smith).

description(rohrbaughOfficeKey, key, "blue key", "It is a blue key that looks similar to office keys you have seen before.").
words(rohrbaughOfficeKey, [blue, office, key]).
initial(rohrbaughOfficeKey, nowhere). % dig outside boyer
see_object(rohrbaughOfficeKey) :- writefw("You see a key.\n").
pick_up(rohrbaughOfficeKey) :- writefw("You pick up the key.\n").
put_down(rohrbaughOfficeKey) :- writefw("You put down the key.\n").

description(owenOfficeKey, key, "red key", "It is a red key that looks similar to office keys you have seen before.").
words(owenOfficeKey, [red, office, key]).
initial(owenOfficeKey, nowhere). % dig outside naugle
see_object(owenOfficeKey) :- writefw("You see a key.\n").
pick_up(owenOfficeKey) :- writefw("You pick up the key.\n").
put_down(owenOfficeKey) :- writefw("You put down the key.\n").

description(weaverOfficeKey, key, "yellow key", "It is a yellow key that looks similar to office keys you have seen before.").
words(weaverOfficeKey, [yellow, office, key]).
initial(weaverOfficeKey, nowhere). % dig outside mellinger
see_object(weaverOfficeKey) :- writefw("You see a key.\n").
pick_up(weaverOfficeKey) :- writefw("You pick up the key.\n").
put_down(weaverOfficeKey) :- writefw("You put down the key.\n").

description(hareOfficeKey, key, "green key", "It is a green key that looks similar to office keys you have seen before.").
words(hareOfficeKey, [green, office, key]).
initial(hareOfficeKey, nowhere). % dig outside main entrance
see_object(hareOfficeKey) :- writefw("You see a key.\n").
pick_up(hareOfficeKey) :- writefw("You pick up the key.\n").
put_down(hareOfficeKey) :- writefw("You put down the key.\n").

description(fishOfficeKey, key, "orange key", "It is a orange key that looks similar to office keys you have seen before.").
words(fishOfficeKey, [orange, office, key]).
initial(fishOfficeKey, nowhere). % dig outside engle
see_object(fishOfficeKey) :- writefw("You see a key.\n").
pick_up(fishOfficeKey) :- writefw("You pick up the key.\n").
put_down(fishOfficeKey) :- writefw("You put down the key.\n").

dig(boyer) :-
	counter(boyer_dug, X), X \= 0, !, writefw("You continue to dig around outside Boyer hall, but find nothing except strange looks from passers-by.\n"), increment_counter(boyer_dug).
dig(boyer) :-
	!, writefw("Using your shovel you dig around, and to your surprise you find a blue key!\n"), move(rohrbaughOfficeKey, boyer), increment_counter(boyer_dug).
	
dig(naugle) :-
	counter(naugle_dug, X), X \= 0, !, writefw("You continue to dig around outside Naugle, but find nothing except strange looks from passers-by.\n"), increment_counter(naugle_dug).
dig(naugle) :-
	!, writefw("Using your shovel you dig around, and to your surprise you find a red key!\n"), move(owenOfficeKey, naugle), increment_counter(naugle_dug).
	
dig(mellinger) :-
	counter(mellinger_dug, X), X \= 0, !, writefw("You continue to dig around outside Mellinger, but find nothing except strange looks from passers-by.\n"), increment_counter(mellinger_dug).
dig(mellinger) :-
	!, writefw("Using your shovel you dig around, and to your surprise you find a yellow key!\n"), move(weaverOfficeKey, mellinger), increment_counter(mellinger_dug).
	
dig(mainEntrance) :-
	counter(main_dug, X), X \= 0, !, writefw("You continue to dig around the main entrance, but find nothing except strange looks from passers-by.\n"), increment_counter(main_dug).
dig(mainEntrance) :-
	!, writefw("Using your shovel you dig around, and to your surprise you find a green key!\n"), move(hareOfficeKey, mainEntrance), increment_counter(main_dug).

dig(engle) :-
	counter(engle_dug, X), X \= 0, !, writefw("You continue to dig around outside the Engle Center, but find nothing except strange looks from passers-by.\n"), increment_counter(engle_dug).
dig(engle) :-
	!, writefw("Using your shovel you dig around, and to your surprise you find a orange key!\n"), move(fishOfficeKey, engle), increment_counter(engle_dug).


% ---lair objects--- %

description(tunnelKey, key, "rusty key", "It is a key! I wonder which door it gets you through..."). % l4
words(tunnelKey, [rusty, key]).
initial(tunnelKey, nowhere).
see_object(tunnelKey) :- writefw("You see a rusty key.\n").
pick_up(tunnelKey) :- writefw("You pick up the rusty key.\n").
put_down(tunnelKey) :- writefw("You put down the rusty key.\n").

description(lairKey1, key, "brass key", "It is a key that gives you a feeling of finality."). % main lair 
words(lairKey1, [brass, key]).
initial(lairKey1, nowhere).
see_object(lairKey1) :- writefw("You see a brass key.\n").
pick_up(lairKey1) :- writefw("You pick up the brass key.\n").
put_down(lairKey1) :- writefw("You put down the brass key.\n").

description(lairKey2, key, "golden key", "It is a key that gives you a feeling of finality."). % main lair
words(lairKey2, [golden, gold, key]).
initial(lairKey2, nowhere).
see_object(lairKey2) :- writefw("You see a golden key.\n").
pick_up(lairKey2) :- writefw("You pick up the golden key.\n").
put_down(lairKey2) :- writefw("You put down the golden key.\n").

description(lairKey3, key, "silver tarnished key", "It is a key that gives you a feeling of finality."). % main lair
words(lairKey3, [silver, tarnished, tarnish, key]).
initial(lairKey3, parmerSeats).
see_object(lairKey3) :- writefw("You see a silver tarnished key.\n").
pick_up(lairKey3) :- writefw("You pick up the silver tarnished key.\n").
put_down(lairKey3) :- writefw("You put down the silver tarnished key.\n").

description(bungeeCord, object, "bungee cord", "It is a Bungee Cord, I wonder how strong this is?").
words(bungeeCord, [bungee, cord]).
initial(bungeeCord, climbingWall).
see_object(bungeeCord) :- writefw("You see a bungee cord.\n").
pick_up(bungeeCord) :- writefw("You pick up the bungee cord.\n").
put_down(bungeeCord) :- writefw("You put down the bungee cord.\n").

% ---end lair objects--- %

description(idCard, object, "ID card", "It is a student ID card. You cannot make out the name.").
words(idCard, [id, card]).
initial(idCard, witmer).
see_object(idCard) :- writefw("You see an id card laying on the ground.\nWhoever left it behind seems unlikely to find it all the way out here...\n").
pick_up(idCard) :- writefw("You pick up the id card, hoping its owner will not return for it.\n").
put_down(idCard) :- !, writefw("You have no reason to put it back!\n"), fail.

description(tumbleweed, object, "tumbleweed", "It is a tumbleweed.  You don't know how it got here.").
words(tumbleweed, [tumbleweed, weed, tumble, tw]).
initial(tumbleweed, dLot).
see_object(tumbleweed) :- writefw("You see a tumbleweed tumble past.\n").
pick_up(tumbleweed) :-
	counter(tw, 4), !,
	writefw("You finally grab the tumbleweed.  It's so exciting!  What will you do with it?\n"),
	set_counter(tw, 0).
pick_up(tumbleweed) :-
	increment_counter(tw),
	writefw("You try to grab the tumbleweed, but it tumbles past your hands.\n"),
	fail.
put_down(tumbleweed) :- writefw("You drop the tumbleweed.  It starts to tumble around.  You watch it for a moment, entranced.\n").

description(bike, object, "bike", "It's a bike.  You can use it to go to places you have visited.").
words(bike, [bike, bicycle, trike, tricycle, motorcycle, motorbike]).
initial(bike, climenhaga).
see_object(bike) :-
	location(prot, Here),
	location(bikeRack, Here), !,
	writefw("You see a bike sitting in the bike rack. It doesn't seem to belong to anyone nearby.\n").
see_object(bike) :-
	writefw("You see a bike lying on the ground.  It doesn't seem to belong to anyone nearby.\n").
pick_up(bike) :- writefw("You take the bike and put it in your apparently bottomless pockets.  You can now use it to revisit some places you have already been by using the 'bike' command.  Hopefully its owner won't return looking for it in the near future.\n").
put_down(bike) :-
	location(prot, Here),
	location(bikeRack, Here), !,
	writefw("You place the bike in the bike rack, ready for the next passerby to st- er, borrow.\n").
put_down(bike) :-
	location(prot, Here),
	(room(Here); maze(Here)), !,
	writefw("You leave the bike lying on the floor, ready for the next passerby to st- er, borrow.\n").
put_down(bike) :- writefw("You leave the bike lying on the ground, ready for the next passerby to st- er, borrow.\n").

description(cars, fakeobject, "cars", "Many cars are parked here.").
words(cars, [car, cars]).
initial(cars, p).
initial(cars, dLot).
pick_up(cars) :-
	writefw("Being a puny computer science major, there is no way you could lift one of these heavy cars.\n"), fail.
action([vandalize], cars) :-
	writefw("Why would you want to do that!?\n").

description(lottieFood, object, "Lottie Food", "Food from Lottie.").
words(lottieFood, [lottie, food]).
initial(lottieFood, lottie).
see_object(lottieFood) :- writefw("You see some food from Lottie.\n").
food(lottieFood).
eat(lottieFood) :- writefw("Yummy, it IS lottie food, but it is good!\n").
pick_up(lottieFood) :-
	writefw("You grab the food.  It is from Lottie, so you question its quality, but it is food nonetheless.\n").
put_down(lottieFood) :-
	writef("You drop the food.  It seems strange to waste it so.\n").
	
description(iceCream, object, "ice cream", "Ice Cream sold by South Side!").
words(iceCream, [ice, cream, food]).
food(iceCream).
initial(iceCream, ssStore).
see_object(iceCream) :- writefw("You see some Ice Cream from South Side!\n").
eat(iceCream) :- writefw("Mmmm, ice cream is good!\n").
pick_up(iceCream) :-
	writefw("You grab the ice cream. Don't eat food off the ground.\n").
put_down(iceCream) :-
	writef("You drop the ice cream.  It seems strange to waste it so, and now you probably shouldn't eat it.\n").	

description(cricket, object, "cricket", "It's a cricket.  It seems happy, chirping like that.").
words(cricket, [cricket, crickets]).
initial(cricket, dLot).
see_object(cricket) :- writefw("You hear a cricket chirping nearby.\n").
pick_up(cricket) :-
	counter(cricket, 2), !,
	writefw("You grab the cricket!\n"),
	set_counter(cricket, 0).
pick_up(cricket) :-
	counter(cricket, 1), !,
	increment_counter(cricket),
	writefw("You try to grab the cricket, but it hops away from you.  It wasn't even close.\n"),
	fail.
pick_up(cricket) :-
	increment_counter(cricket),
	writefw("You try to grab the cricket, but it hops away.  You think you were close, though.\n"),
	fail.
put_down(cricket) :- writefw("You drop the cricket.  It hops away, chirping happily.\n").

description(tukufu, fakeobject, "Tukufu the skeletal elephant", "It's Tukufu, a skeletal elephant belonging to the Oakes Museum.").
words(tukufu, [tukufu, elephant, skeletal, skeleton, tkf]).
initial(tukufu, insideKlineJordan).
see_object(tukufu) :- writefw("You see Tukufu.\n").
pick_up(tukufu) :-
	writefw("You can't take an elephant with you.  Or a skeleton.  Or a skeletal elephant.  Or break the case it's inside.  What were you thinking?\n"),
	fail.

description(stuffedAnteater, sa, "stuffed anteater", "It's a stuffed anteater.").
words(stuffedAnteater, [stuffed, anteater, animal]).
initial(stuffedAnteater, felix).

description(stuffedDragon, sa, "stuffed dragon", "It's a stuffed dragon.").
words(stuffedDragon, [stuffed, dragon, animal]).
initial(stuffedDragon, felix).

description(stuffedKiwi, sa, "stuffed kiwi", "It's a stuffed kiwi.").
words(stuffedKiwi, [stuffed, kiwi, animal]).
initial(stuffedKiwi, felix).

description(stuffedFrog, sa, "stuffed frog", "It's a stuffed frog.").
words(stuffedFrog, [stuffed, frog, animal]).
initial(stuffedFrog, felix).

description(stuffedDolphin, sa, "stuffed dolphin", "It's a very colorful stuffed dolphin.").
words(stuffedDolphin, [stuffed, dolphin, animal]).
initial(stuffedDolphin, felix).

description(stuffedPenguin, sa, "stuffed penguin", "It's a stuffed penguin. His name is Boneless Carl.").
words(stuffedPenguin, [stuffed, penguin, animal]).
initial(stuffedPenguin, cStore).

see_object(SA) :-
	description(SA, sa, Name, _), !,
	writefw("You see here a %s\n", [Name]).
pick_up(SA) :-
	description(SA, sa, Name, _), !,
	writefw("You pick up the %s, though you are not sure why...\n", [Name]).
put_down(SA) :-
	description(SA, sa, Name, _),
	location(prot, Here),
	location(felix, Here), !,
	writefw("As you lower the %s, the stuffed animal thrower quickly grabs it.\n", [Name]),
	move(SA, felix), fail.
put_down(SA) :-
	description(SA, sa, Name, _),
	writefw("You drop the %s.\n", [Name]).
