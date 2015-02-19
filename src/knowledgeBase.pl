:- include(directives).

dir(n, north).
dir(e, east).
dir(w, west).
dir(s, south).
dir(nw, northwest).
dir(ne, northeast).
dir(sw, southwest).
dir(se, southeast).
dir(north, north).
dir(east, east).
dir(west, west).
dir(south, south).
dir(northwest, northwest).
dir(northeast, northeast).
dir(southwest, southwest).
dir(southeast, southeast).
dir(in, in).
dir(out, out).
dir(u, up).
dir(d, down).
dir(up, up).
dir(down, down).

% Waypoints are less important points between two locations.
% Places can be dug in.
% rooms and buildings are functionally no different.  (You can not dig in them.)

adjacent(frey, klineJordan, northeast, southwest).
adjacent(union, engle, west, east).
adjacent(northComplex, engle, south, north).
adjacent(southComplex, klineJordan, northwest, southeast).
adjacent(outsideEisenhower, lottieEntrance, in, out).
adjacent(outsideEisenhower, klineJordan, east, west).
adjacent(outsideEisenhower, p2, northeast, southwest).
adjacent(p2, northComplex, northeast, southwest).
adjacent(engle, klineJordan, southwest, northeast).
adjacent(hoffman, frey, east, west).
adjacent(hoffman, boyer, southwest, northeast).
adjacent(hoffman, outsideEisenhower, northwest, southeast).
adjacent(lottieEntrance, eisenhowerLobby, down, up).
adjacent(ecc, eisenhowerLobby, in, out).
adjacent(sports, eisenhowerLobby, south, north).
adjacent(campusStore, eisenhowerLobby, out, in).
adjacent(frey, freyLobby, in, out).
adjacent(officeHallway2, officeHallway3, southeast, northwest).
adjacent(officeHallway1, officeHallway2, southeast, northwest).
adjacent(freyLobby, officeHallway1, southeast, northwest).
adjacent(freyLobby, labs, east, out).
adjacent(library, frey, north, south).
adjacent(insideLibrary, bookStacks, down, up).
adjacent(insideLibrary, coffeeShop, west, east).
adjacent(chapel, library, east, west).
adjacent(chapel, boyer, west, east).
adjacent(ecc, boyer, south, north).
adjacent(oldMain, boyer, east, west).
adjacent(climenhaga, boyer, northeast, southwest).
adjacent(climenhaga, high, west, east).
adjacent(climenhaga, oldMain, north, south).
adjacent(climenhaga, coveredBridge, south, north).
adjacent(high, backEntrance, southwest, northeast).
adjacent(high, oldMain, northeast, southwest).
adjacent(p, oldMain, southwest, northeast).
adjacent(p, ecc, northeast, southwest).
adjacent(mainEntrance, sports, south, north).
adjacent(mainEntrance, safety, northwest, southeast).
adjacent(presidentHouse, k1, southeast, northwest).
adjacent(mainEntrance, northComplex, east, west).
adjacent(dLot, d3, southwest, northeast).
adjacent(d3, d2, southwest, northeast).
adjacent(naugle, d2, northeast, southwest).
adjacent(naugle, northComplex, south, north).
adjacent(northComplex, union, southeast, northwest).
adjacent(union, loft, southeast, northwest).
adjacent(union, southComplex, south, north).
adjacent(loft, southComplex, southwest, northeast).
adjacent(loft, climbingWall, in, out).
adjacent(climenhaga, y1, southeast, northwest). %changed this from the covered bridge, because there shouldn't have been three exits from a bridge.
adjacent(y1, y2, east, west).
adjacent(y2, y3, east, west).
adjacent(swingingBridge, y3, north, south).
adjacent(y3, y4, east, west).
adjacent(y4, y5, east, west).
adjacent(southComplex, y5, south, north).
adjacent(southComplex, mellinger, east, west).
adjacent(mellinger, b2, east, west).
adjacent(b2, b3, east, west).
adjacent(southComplex, witmer, southeast, northwest).
adjacent(mellinger, witmer, south, north).
adjacent(northComplex, fishbowl, in, out).
adjacent(southComplex, southside, in, out).
adjacent(klineJordan, insideKlineJordan, in, out).
adjacent(insideKlineJordan, oakes, in, out).

fasttravel(frey).
fasttravel(boyer).
fasttravel(dLot).
fasttravel(witmer).
fasttravel(climenhaga).
fasttravel(northComplex).
fasttravel(southComplex).
fasttravel(presidentHouse).
fasttravel(swingingBridge).
fasttravel(back40).

initial(prot, rohrbaughOffice).

helplines([
	"Common commands are:\n",
	"  'go <dir>' or '<dir>' where <dir> is one of the following:\n",
	"      north, east, south, west\n",
	"      northeast, southeast, southwest, northwest\n", 
	"      in, out, up, down\n", 
	"      or the shortened versions: n, ne, e, se, s, sw, w, nw, u, d\n", 
	"  'wait' to wait\n",
	"  'talk to <person>', 'talk <person>', or 't <person> to talk to someone\n", 
	"  'get <object>' or 'take <object>' to take an object\n", 
	"  'drop <object>' to drop an object\n", 
	"  'look', 'l', 'examine', or 'x' to look around or at a particular object\n", 
	"  'inventory' or 'i' to list your inventory\n",
	"  'dig' to dig\n",
	"  'buy' to purchase an item at a store\n",
	"  'end', 'quit', or 'halt' to exit the game\n",
	"  'restart' to restart the game\n",
	"  'save <filename>' to save your progress\n"]).
