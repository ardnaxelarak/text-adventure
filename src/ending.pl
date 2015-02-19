end_win :-
	assertz(state(game_over)).

display_ending :-
	counter(imaginary, X), X >= 4, !,
	writefw("You suddenly wake up in your dorm room. You must have stayed up too late working on your OPL project and dozed off, having a very strange dream that you can't quite remember...\nCongratulations; you have finished the game!\n").

display_ending :-
	counter(violence, X), X >= 4, !,
	writefw("As you enter the main lair, you see Dr. Rohrbaugh's corpse lying on the floor and your memories come back in a rush. Having such violent tendancies, you kidnapped him and murdered him when he would not give in to your demands. It might not have been rust on the shovel after all...\nPerhaps this could have been a happier ending if you hadn't caused so much violence.\nCongratulations; you have finished the game!\n").

display_ending :-
	counter(violence, X), X >= 2, !,
	writefw("As you enter the main lair, you see Dr. Rohrbaugh lying on the floor, and you recall having created the legend of the Tigerram to lure him to your lair, and you were successful. Unfortunately, however, you were followed here, and are arrested by the president's secret service. Needless to say, you failed your OPL project.\nPerhaps this could have been a happier ending if you hadn't been so quick to cause violence.\nCongratulations; you have finished the game!\n").

display_ending :-
	not(state(talked)), !,
	writefw("As you enter the main lair, your memories return to you and you realize that you are Dr. Rohrbaugh. Perhaps if you had talked to someone they would have been able to tell you that...\nCongratulations; you have finished the game!\n").

display_ending :-
	location(stuffedPenguin, prot),
	location(nutmeg, prot), !,
	writefw("As you enter the main lair, you discover the Tigerram! Suddenly springing to life, Boneless Carl grabs your nutmeg and sprinkles it on the Tigerram, who suddenly turns into Dr. Rohrbaugh.  Dr. Rohrbaugh thanks you for ridding him of the curse of the Tigerram, and all ends happily!\nCongratulations; you have finished the game!\n").

display_ending :-
	writefw("As you enter the main lair, you discover Dr. Rohrbaugh. He was kidnapped and brought here by the Tigerram. He thanks you for saving him from this strange underground lair. He hands you a medal, and the game is over. Congratulations!!!\n").
