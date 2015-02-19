% :- module(identification, [identify/3, get_objects/4, get_object/5, get_object/6]).

identify(Object, Description, Pred) :-
	words(Object, List),
	subset(Description, List),
	call(Pred).

get_objects(List, Object, Description, Pred) :-
	findall(Object, identify(Object, Description, Pred), List).

choose(_, [], Description, None, _) :-
	!, writefw(None, [Description]), fail.
choose(Object, List, _, _, _) :-
	length(List, 1), !, List = [Object].
choose(Object, List, Description, _, Many) :-
	!, writefw(Many, [Description]),
	select_thing(List, get_name, Object),
	Object \= [].

get_object(Object, Description, Pred, None, Many) :-
	get_objects(List, Object, Description, Pred),
	atomic_list_concat(Description, ' ', Full),
	!, choose(Object, List, Full, None, Many).

get_object(Object, [], Pred, None, _, Many) :-
	get_objects(List, Object, [], Pred),
	!, choose(Object, List, '', None, Many).

get_object(Object, Description, Pred, _, None, Many) :-
	get_objects(List, Object, Description, Pred),
	atomic_list_concat(Description, ' ', Full),
	!, choose(Object, List, Full, None, Many).
