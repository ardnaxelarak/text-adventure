:- include(directives).

description(secretService, monster, "the secret service", "It's the secret service.  They protect the president, and they are not to be trifled with.").
words(secretService, [secret, service, ss]).
initial(secretService, safety).
see_monster(secretService) :- writefw("You see many secret service agents nearby.  There are probably others nearby who you can't see.  It is the secret service, after all.\n").
talk_to(secretService) :-
	location(cricket, prot), !,
	writefw("\"You should release the cricket.\"\n").
talk_to(secretService) :-
	location(cricket, safety), !,
	writefw("\"Look at that cricket.  It seems so happy.  You must be a good person, allowing it to roam free like that.\"\n").
talk_to(secretService) :- writefw("\"Please be careful.  We can't let anyone do anything to threaten the president.\"\n").

description(troll, monster, "a troll", "It's a big, mean, angry troll.  It seems dangerous, and it doesn't seem to like you.").
words(troll, [troll]).
initial(troll, coveredBridge).
see_monster(troll) :- writefw("You see an angry troll guarding the area.\n").
give(troll, Food) :- food(Food), !, move(troll, nowhere), writefw("You give food to the troll, and it leaves.  You can't see where it went.\n").
talk_to(troll) :- writefw("\"Grrr!\"\n").

description(dead_troll, dead, "a dead troll", "It's a big, mean, dead, angry troll.  It doesn't seem so dangerous any more.").
words(dead_troll, [dead, troll]).
initial(dead_troll, nowhere).
see_object(dead_troll) :- writefw("You see a dead troll.\n").
pick_up(dead_troll) :- writefw("You really don't want to pick up a dead troll.\n"), fail.

kill(troll, sword) :-
	!, writefw("Using your imaginary sword, you attack the troll. To your surprise, you manage to kill the troll!\n"),
	increment_counter(violence),
	increment_counter(imaginary).

kill(troll, knife) :-
	!, writefw("Using your knife, you manage to kill to the troll.\n"),
	increment_counter(violence).

kill(troll, shovel) :-
	!, writefw("You can't kill a big, mean troll with your puny shovel!\n"), fail.

description(loudCrowd, monster, "a noisy crowd of people", "It is a large group of obnoxiously loud people hanging out in the fishbowl.").
words(loudCrowd, [loud, crowd, obnoxious, people, obnoxiously]).
initial(loudCrowd, fishbowl).
see_monster(loudCrowd) :- writefw("You see a noisy crowd of people.\n").
talk_to(loudCrowd) :- writefw("You try to talk to the crowd, but cannot be heard over the cacaphonous noise.\n").

kill(loudCrowd, Weapon) :-
	!, get_name(Weapon, Name),
	writefw("You attack a member of the loud crowd with your %s, but are overwhelmed by the sheer volume of the crowd and are prevented from doing much damage.\n", [Name]),
	increment_counter(violence), fail.

description(awkwardCouple, monster, "an awkward couple", "It's an awkward couple.  It's... awkward... to discuss.").
words(awkwardCouple, [awkward, couple]).
initial(awkwardCouple, b2).
see_monster(awkwardCouple) :- writefw("You see an awkward couple.\n").
kill(awkwardCouple, Weapon) :-
	!, get_name(Weapon, Name),
	writefw("You kill the awkward couple with your %s! You have a bad feeling about this...\n", [Name]),
	increment_counter(violence),
	increment_counter(violence),
	increment_counter(violence).
talk_to(awkwardCouple) :- writefw("The awkward couple doesn't respond.  It's awkward.\n").

description(dead_awkwardCouple, dead, "a dead awkward couple", "It's a (formerly) awkward couple that met an untimely demise at your hands.").
words(dead_awkwardCouple, [dead, awkward, couple]).
initial(dead_awkwardCouple, nowhere).
see_object(dead_awkwardCouple) :- writefw("You see here the remains of an awkward couple.\n").
