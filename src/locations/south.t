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
    southeast = fitnessTrail
    northeast = boyer
;
