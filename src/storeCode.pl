:- include(directives).

description(cStore, store, "Campus Store", "It's the campus store. You can buy all kinds of cool stuff.").
initial(cStore, campusStore).
wares(cStore, [stuffedPenguin-3, screwdriver-7]).

description(unionFood, object, "food", "You see food from the union.  It looks delicious.").
words(unionFood, [food]).
food(unionFood).
initial(unionFood, uStore).
see_object(unionFood) :- writefw("You see food from the union.\n").
pick_up(unionFood) :-
	writefw("You pick up the union food.  It smells great.\n").
put_down(unionFood) :-
	writef("You put down the union food.  Hopefully no one will steal it.\n").

description(uStore, store, "Union Store", "It's the Union.  You can buy stuff here.").
initial(uStore, union).
wares(uStore, [apple-0, unionFood-6]).

description(ssStore, store, "South Side Store", "It's the South Side Cafe.  They are known for selling ice cream and losing money.").
initial(ssStore, southside).
wares(ssStore, [kiwi-0, iceCream-2]).

description(lStore, store, "Cafe Diem", "It's Cafe Diem, the library coffee shop.").
initial(lStore, coffeeShop).
wares(lStore, [coffee-2, nutmeg-6]).

description(coffee, object, "coffee", "It's coffee.  It smells like it might help you last through the night.").
food(coffee).
words(coffee, [coffee, java, joe, starbucks]).
initial(coffee, lStore).
see_object(coffee) :- writefw("You see a cup of coffee sitting on the ground.  It is warm to the touch.\n").
pick_up(coffee) :- writefw("You pick up the cup of coffee.\n").
put_down(coffee) :- writefw("You set down the cup of coffee with a look of regret.\n").
eat(coffee) :- writefw("You drink the coffee. It was very good (and hot).\n").

description(nutmeg, object, "nutmeg", "Nutmeg is an organic substance loved by Boneless Carl.").
food(nutmeg).
words(nutmeg, [nut, meg, nutmeg]).
initial(nutmeg, lStore).
see_object(nutmeg) :- writefw("You see a jar of nutmeg.\n").
purchased(nutmeg) :- writefw("Boneless Carl seems very happy.\n").
pick_up(nutmeg) :-
	location(stuffedPenguin, prot), !,
	writefw("You pick up a jar of nutmeg.\nBoneless Carl seems very happy.\n").
pick_up(nutmeg) :- writefw("You pick up a jar of nutmeg.\n").
put_down(nutmeg) :-
	location(stuffedPenguin, prot), !,
	writefw("You set down the jar of nutmeg.\nBoneless Carl seems rather disappointed.\n").
put_down(nutmeg) :- writefw("You set down the jar of nutmeg.\n").
eat(nutmeg) :-
	location(stuffedPenguin, prot), !,
	writefw("Boneless Carl glares at you as you eat the nutmeg.\n").
eat(nutmeg) :-
	writefw("You eat the nutmeg.\n").

description(screwdriver, object, "screwdriver", "It's a screwdriver. You can use it to screw things in.").
words(screwdriver, [screw, driver, screwdriver]).
initial(screwdriver, cStore).
see_object(screwdriver) :- writefw("You see here a screwdriver.\n").
pick_up(screwdriver) :-
	writefw("You pick up the screwdriver.\n").
put_down(screwdriver) :-
	writefw("You drop the screwdriver.\n").

name_and_cost(A, Thing, String) :-
	get_assoc(Thing, A, Cost),
	description(Thing, _, Name, _),
	swritef(S, "%s - $%t", [Name, Cost]),
	string_to_list(S, String).
	
attempt_purchase(Item, A) :-
	get_assoc(Item, A, Cost),
	money(Money),
	Money >= Cost, !,
	purchased(Item), !,
	description(Item, _, Name, _),
	writefw("You purchase the %s for $%d\n", [Name, Cost]),
	sub_money(Cost),
	move(Item, prot).
attempt_purchase(Item, _) :-
	description(Item, _, Name, _),
	writefw("You do not have enough money to purchase the %s\n", [Name]).

buy(Store) :-
	wares(Store, Wares),
	list_to_assoc(Wares, A),
	pairs_keys(Wares, Items),
	findall(O, location(O, Store), Avail),
	intersection(Items, Avail, CanBuy),
	money(Money),
	writefw("The following items are available. You have $%t. Type a letter to buy the associated item, or Z to quit.\n", [Money]),
	select_thing(CanBuy, name_and_cost(A), Thing), !,
	Thing \= [],
	attempt_purchase(Thing, A).
