% :- module(writefw, [writefw/1, writefw/2]).

write_piece(CurPos, Piece, NextPos, Size) :-
	atom_length(Piece, L),
	C is CurPos + L,
	C =< Size,
	writef("%t", [Piece]), !,
	NextPos = C.
write_piece(_, Piece, NextPos, _) :-
	atom_length(Piece, NextPos),
	writef("\n%t", [Piece]), !.

write_space(CurPos, NextPos, Size) :-
	C is CurPos + 1,
	C =< Size,
	writef(" "),
	NextPos = C.
write_space(_, 0, _) :-
	writef("\n").

write_pieces(_, [], _, _).
write_pieces(CurPos, [First], NextPos, Size) :-
	write_piece(CurPos, First, NextPos, Size), !.
write_pieces(CurPos, [First|Rest], NextPos, Size) :-
	write_piece(CurPos, First, NextPos, Size),
	write_space(NextPos, L, Size),  !,
	write_pieces(L, Rest, _, Size).
	
wrapline(Line, Size) :-
	atomic_list_concat(Pieces, ' ', Line), !,
	write_pieces(0, Pieces, _, Size), !.

wraplines([], _).
wraplines([First], Size) :-
	wrapline(First, Size), !.
wraplines([First|Rest], Size) :-
	wrapline(First, Size), !, writef("\n"),
	wraplines(Rest, Size), !.

writewrap(Format, Arguments, Size) :-
	swritef(S, Format, Arguments),
	atom_codes(Atom, S), !,
	atomic_list_concat(Lines, '\n', Atom), !,
	wraplines(Lines, Size).

writefw(Format) :-
	writefw(Format, []).

writefw(Format, Arguments) :-
	catch((tty_size(_, Width)), [], fail), !,
	Real is Width - 3,
	writewrap(Format, Arguments, Real).

writefw(Format, Arguments) :-
	writef(Format, Arguments).
