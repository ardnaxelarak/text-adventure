#include <adv3.h>
#include <en_us.h>

mainEntrance: OutdoorRoom
    'Main Entrance'
    "You are standing at the main entrance to Messiah College. To the south is Sollenberger Sports Center, to the east is north complex, and to the northwest is the safety house. "
    south = sports
    east = northComplex
    northwest = safety
;

presidentHouse: OutdoorRoom
    'President\'s House'
    "You are in front of the President's house. To the southeast you see a road leading toward campus. "
    southeast = k1
;

k1: OutdoorRoom
    'Near the President\'s house'
    'the path to the president\'s house'
    "You feel an aura of power emanating from the president's house, even from this far away. To the northwest is the president's house, while to the southeast is the safety house. "
    northwest = presidentHouse
    southeast = safety;
;

safety: OutdoorRoom
    'Safety House'
    'the Safety House'
    "You are in front of the Safety House. This is where the president's secret service control access to her house. You see the main entrance to campus to the southeast, and a road leading toward the president's house to the northwest. "
    northwest = k1
    southeast = mainEntrance
;

northComplex: HasBikeRack, OutdoorRoom
    'North Complex'
    'North Complex'
    "You are standing in front of North Complex. A bike rack is next to the entrance. You see the Engle Center to the south, a path towards Eisenhower to the southwest, the student union to the southeast, the main entrance to campus to the wests, Naugle to the north, and a door into the fishbowl. "
    south = engle
    southwest = d1
    southeast = union
    west = mainEntrance
    north = naugle
    in = fishbowl
;

naugle: OutdoorRoom
    'Naugle'
    'Naugle'
    "You are standing in front of Naugle. You can hear a train going past, blaring its horn loudly. You see a path toward D-Lot to the northeast and north complex to the south. For some reason, you don't see any apartment buildings. "
    northeast = d2
    south = northComplex
;

d2: OutdoorRoom
    'Path between Naugle and D-Lot'
    'the path between Naugle and D-Lot'
    "You feel as though you are leaving civilization. You see Naughle to the southwest and a path toward D-Lot to the northeast. "
    southwest = naugle
    northeast = d3
;

d3: OutdoorRoom
    'Path between Naugle and D-Lot'
    'the path between Naugle and D-Lot'
    "You hear the sounds of civilization, but only barely. You see D-Lot to the northeast and a path toward Naugle to the southwest. "
    northeast = dLot
    southwest = d2
;

dLot: OutdoorRoom
    'D-Lot'
    'D-Lot'
    "You are in D-Lot. There are few signs of humanity; civilization is far behind you. You see a path back to campus and civilization to the southwest. "
    southwest = d3
;

engle: OutdoorRoom
    'Engle Center'
    'the Engle Center'
    "You are in front of the Engle Center. You feel healthier just standing here. You see Kline/Jordan to the southwest, the student union to the east, and north complex to the north. "
    southwest = klineJordan
    east = union
    north = northComplex
;

klineJordan: HasBikeRack, OutdoorRoom
    'Kline/Jordan'
    'Kline/Jordan'
    "You are standing in front of Kline and Jordan, home of the chemists and biologists. A bike rack is next to the entrance. You can see Frey to the southwest, south complex to the southeast, Eisenhower Campus Center to the west, and the Engle Center to the northeast. "
    southwest = frey
    southeast = southComplex
    west = eisenhower
    northeast = engle
    in = insideKlineJordan
;

insideKlineJordan: Room
    'Inside Kline/Jordan'
    'inside Kline/Jordan'
    "You are standing inside of Kline/Jordan. You see doors leading out, and another set of doors leading into the Oakes Museum. "
    in = oakes
    out = klineJordan
;

oakes: Room
    'The Oakes Museum'
    'the Oakes Museum'
    "You are standing inside the Oakes Museum. You are surrounded by lots of cool naturely stuff. You see doors leading out. "
    out = insideKlineJordan
;

union: OutdoorRoom
    'Larsen Student Union'
    'Larsen Student Union'
    "You are standing in front of the Larsen Student Union. You see the Engle Center to the west, the Loft to the southeast, south complex to the south, and north complex to the northwest. You can buy stuff here. "
    west = engle
    southeast = loft
    south = southComplex
    northwest = northComplex
;

loft: OutdoorRoom
    'Loft'
    "You are standing in front of the Loft. You see a door to a garage marked <q>Climbing Wall</q> nearby. You see south complex to the southwest and the student union to the northwest. "
    in = climbingWall
    southwest = southComplex
    northwest = union
;

climbingWall: Room
    'Climbing Wall'
    "You are at the climbing wall. "
    out = loft;
;

southComplex: HasBikeRack, OutdoorRoom
    'South Complex'
    'South Complex'
    "You are at South Complex. A bike rack is next to the entrance. You see Kline/Jordan to the northwest, the fitness trail to the south, Mellinger to the east, Witmer to the southeast, the student union to the north, a door into the South Side Cafe, and the Loft to the northeast. "
    northwest = klineJordan
    south = y5
    east = mellinger
    southeast = witmer
    north = union
    in = southside
    northeast = loft
;

southside: Room
    'South Side Cafe'
    'the South Side Cafe'
    "You're in the South Side Cafe. You see a door leading out. You can buy stuff here. "
    out = southComplex
;

mellinger: OutdoorRoom
    'Mellinger Apartments'
    'Mellinger Apartments'
    "You are standing in front of Mellinger Apartments. You see a path to the Back 40 to the east, Witmer to the south, and south complex to the west. "
    east = b2
    south = witmer
    west = southComplex
;

b2: OutdoorRoom
    'On the Back 40 Path'
    'the Back 40 path'
    "You are surrounded by trees and underbrush. To the west you see Mellinger. The path continues to the east. "
    west = mellinger
    east = b3
;

b3: OutdoorRoom
    'On the Back 40 Path'
    'the Back 40 path'
    "You are surrounded by trees and underbrush. To the east you see the Back 40. The path back to campus continues to the west. "
    east = back40
    west = b2
;

back40: OutdoorRoom
    'Back 40'
    'the Back 40'
    "You are in the Back 40. It seems pretty empty... You see a path back to campus to the west. "
    west = b3
;

witmer: OutdoorRoom
    'Witmer'
    'Witmer'
    "You are at Witmer. You remember that it is commonly considered to be the best first-year dorm. You see south complex to the northwest and Mellinger to the north. "
    northwest = southComplex
    north = mellinger
;

fishbowl: Room
    'Fishbowl'
    "You're in the Fishbowl. "
    out = northComplex
;
