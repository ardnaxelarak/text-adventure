:- include(directives).

description(mazeStart, room, "White Room", "You are in a blank white room. You see an exit out of the building.").
adjacent(mazeStart, chapel, out, in).
adjacent(mazeStart, m1, east, west).
adjacent(mazeStart, m2, south, north).

description(m1, maze, "Orange Room", "You are in a room that is eeriely entirely orange.").
adjacent(m1, m3, south, north).
adjacent(m1, m4, east, north).

description(m2, maze, "Purple Room", "You are in a room that has been painted purple.").
adjacent(m2, m4, east, west).

description(m3, maze, "Yellow Room", "You are in a yellow room.").
adjacent(m3, m4, west, south).
connection(m3, m5, east, []).

description(m4, maze, "Yellow Room", "You are in a yellow room.").
connection(m4, m6, east, []).

description(m5, maze, "Room of Mirrors", "You are in a room filled with mirrors covering each wall.").
adjacent(m5, m6, north, north).
adjacent(m5, m7, west, west).
adjacent(m5, m8, east, north).

description(m6, maze, "Room of Mirrors", "You are in a room filled with mirrors covering each wall.").
adjacent(m6, m7, west, north).
adjacent(m6, m8, east, west).

description(m7, maze, "Living Room", "You are in a room that seems almost alive...").
adjacent(m7, m10, east, north).
connection(m7, mazeStart, south, []).

description(m8, maze, "Living Room", "You are in a room that seems almost alive...").
adjacent(m8, m9, south, west).
connection(m8, mazeStart, east, []).

description(m9, maze, "Twisted Passages", "You see a bunch of winding, twisted passages.").
adjacent(m9, m10, east, west).
adjacent(m9, m11, south, north).
connection(m9, mazeStart, north, []).

description(m10, maze, "Twisted Passages", "You see a bunch of winding, twisted passages.").
adjacent(m10, m13, south, east).
connection(m10, m4, east, []).

description(m11, maze, "Twisted Passages", "You see a bunch of winding, twisted passages.").
adjacent(m11, m12, south, east).
adjacent(m11, m13, west, south).
adjacent(m11, m14, east, north).

description(m12, maze, "Twisted Passages", "You see a bunch of winding, twisted passages.").
connection(m12, m16, north, []).
adjacent(m12, m14, south, west).
connection(m12, m5, west, []).

description(m13, maze, "Twisted Passages", "You see a bunch of winding, twisted passages.").
adjacent(m13, m14, west, south).
connection(m13, m15, north, []).

description(m14, maze, "Twisted Passages", "You see a bunch of winding, twisted passages.").
connection(m14, mazeStart, east, []).

description(m15, maze, "Twisted Passages", "You see a bunch of winding, twisted passages.").
adjacent(m15, m16, south, west).
connection(m15, m14, north, []).
connection(m15, m12, west, []).
connection(m15, l5, east, writefw("You have a feeling of relief as you step into the room; but then the wall closes behind you...\n")).

description(m16, maze, "Twisted Passages", "You see a bunch of winding, twisted passages.").
connection(m16, m10, north, []).
connection(m16, m6, east, []).
connection(m16, m13, south, []).
