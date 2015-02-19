:- multifile description/4.
:- multifile words/2.
:- multifile initial/2.

description(secretService, monster, "the secret service", "It's the secret service.  They protect the president.").
words(secretService, [secret, service]).
initial(secretService, safety).
see_monster(secretService) :- writefw("You see many secret service agents nearby.  There are probably others who aren't nearby.  It is the secret service, after all.\n").

description(troll, monster, "a troll", "It's a big, mean, angry troll.  It seems dangerous, and it doesn't seem to like you.").
words(troll, [troll]).
initial(troll, secretLair).
see_monster(troll) :- writefw("You see an angry troll guarding the area.\n").
