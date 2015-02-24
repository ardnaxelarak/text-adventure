#include <adv3.h>
#include <en_us.h>

p2: OutdoorRoom
    'Path between Eisenhower Campus Center and North Complex'
    'the path between Eisenhower Campus Center and North Complex'
    "You are on a path between North Complex to the northeast and Eisenhower Campus Center to the southwest. Beautiful pink trees line the path. "
    northeast = northComplex
    southwest = outsideEisenhower
;

+Decoration
    'beautiful pink tree/trees'
    'trees'
    isPlural = true
;

outsideEisenhower: HasBikeRack, OutdoorRoom
    'Eisenhower Campus Center'
    'the upstairs entrance to Eisenhow Campus Center'
    "You are standing outside the entrance to the upper floor of Eisenhower Campus Center. There is a bike rack along the path leading to the entrance. "
    in = lottieEntrance
    southeast = hoffman
    east = klineJordan
    northeast = p2
;

lottieEntrance: Room
    'Entrance to Lottie Nelson Dining Hall'
    'the entrance to Lottie Nelson Dining Hall'
    "You are standing outside the Lottie Nelson Dining Hall. "
    in = lottie
    down = eisenhowerLobby
    out = outsideEisenhower
;

lottie: Room
    'Lottie Nelson Dining Hall'
    'Lottie Nelson Dining Hall'
    "You are standing inside the Lottie Nelson Dining Hall. "
    out = lottieEntrance
;

eisenhowerLobby: Room
    'Eisenhower Lobby'
    'Eisenhower Lobby'
    "You are standing in the lobby on the lower floor inside Eisenhower Campus Center. "
    up = lottieEntrance
    out = ecc
    in = campusStore
    north = sports
;

sports: Room
    'Sollenberger Sports Center'
    'Sollenberger Sports Center'
    "You are standing in a hallway inside Sollenberger Sports Center. "
    north = mainEntrance
    south = eisenhowerLobby
;

ecc: OutdoorRoom
    'Eisenhower Circle'
    'Eisenhower Circle'
    "You are standing at the traffic circle outside Eisenhower Campus Center. "
    south = boyer
    southwest = parkingLot
;

campusStore: Room
    'Campus Store'
    "You are standing in the campus bookstore. You might be able to buy something here, if you had the money. "
    out = eisenhowerLobby
;

oldMain: OutdoorRoom
    'Old Main'
    'Old Main'
    "You are standing outside Old Main. "
    east = boyer
    south = climenhaga
    southwest = highCenter
    northeast = parkingLot
;

chapel: OutdoorRoom
    'Hostetter Chapel'
    'Hostetter Chapel'
    "You are standing outside Hostetter Chapel. You aren't really sure what the build is used for, but you are sure it serves some purpose... Bushes line the front of the building. "
    east = library
    west = boyer
;

+Fixture
    'green bush*bushes'
    'bushes'
    "Several green bushes line the front of the chapel. "
    isPlural = true
    cannotTakeMsg = 'You have no use for a bush. '
;

library: OutdoorRoom
    'Murray Library'
    'Murray Library'
    "You are standing outside Murray Library. Several trees are in front of the building. "
    north = frey
    west = chapel
;

+Fixture
    'tree*trees'
    'trees'
    "Several trees stand in front of the library. "
    cannotTakeMsg = 'You do not feel like futily attempting to uproot one of these at the moment. '
    cannotClimbMsg = 'You attempt to climb one of the trees, but are unsuccessful. '
;

parkingLot: OutdoorRoom
    'Visitor Parking Lot'
    "You see a lot of cars. "
    northeast = ecc
    southwest = oldMain
;

hoffman: OutdoorRoom
    'Hoffman'
    'Hoffman'
    "You are outside Hoffman; you can see beautiful flowers, and feel an aura of computing genius. "
    east = frey
    southwest = boyer
    northwest = outsideEisenhower
;

+Decoration
    'beautiful flower*flowers*'
    'flowers'
    isPlural = true
;
