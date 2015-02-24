#include <adv3.h>
#include <en_us.h>

highCenter: OutdoorRoom
    'Calvin & Janet High Center'
    'the High Center'
    "You are outside the High Center. You see beautiful flowers, and hear beautiful praise music. "
    southwest = backEntrance
    northeast = oldMain
    east = climenhaga
;

+Decoration
    'beautiful flower*flowers'
    'flowers'
    isPlural = true
;

backEntrance: OutdoorRoom
    'Back Entrance'
    "You are next to the back entrance, and can hear the sounds of a train in the distance. "
    northeast = highCenter
;

climenhaga: HasBikeRack, OutdoorRoom
    'Climenhaga'
    'Climenhaga'
    "Outside Climenhaga, you notice a much better-looking building in the distance. "
    north = oldMain
    west = highCenter
    south = coveredBridge
    southeast = y1
    northeast = boyer
;

coveredBridge: OutdoorRoom
    'Covered Bridge'
    "You are on the covered bridge. "
    south = starry
    north = climenhaga
;

starry: OutdoorRoom
    'Starry Fields'
    'Starry fields'
    "You are in Starry fields. You feel a sudden urge to stargaze and feel compelled to lie down, but don't. "
    north = coveredBridge
;

class FitnessTrail: OutdoorRoom
    dobjFor(Dig)
    {
        check()
        {
            checkFail('Digging on the fitness trail seems dangerous; someone might trip. ');
        }
    }
;

y1: FitnessTrail
    'Fitness Trail'
    "You are on the fitness trail. Climenhaga is located to the northwest; the trails continues to the east. "
    east = y2
    northwest = climenhaga
;

y2: FitnessTrail
    'Fitness Trail'
    "You are on the fitness trail. It continues to the east and west. "
    west = y1
    east = y3
;

y3: FitnessTrail
    'Fitness Trail'
    "You are on the fitness trail. It continues to the east and west, and the swinging bridge is located to the south. "
    west = y2
    east = y4
    south = swingingBridge
;

y4: FitnessTrail
    'Fitness Trail'
    "You are on the fitness trail. It continues to the east and west. "
    west = y3
    east = y5
;

y5: FitnessTrail
    'Fitness Trail'
    "You are on the fitness trail. It leads to the west, and South Complex is located to the north. "
    west = y4
    north = southComplex
;

