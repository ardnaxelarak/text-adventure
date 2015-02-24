#include <adv3.h>
#include <en_us.h>

frey: HasBikeRack, OutdoorRoom
    'Frey Hall'
    'the outside of Frey Hall'
    "You are stainding outside Frey Hall. You see a bike rack, a bunch of flowers, and some other stuff. You see Hoffman to the west, the library to the south, and Kline and Jordan to the northeast. "
    in = freyLobby
    west = hoffman
    south = library
    northeast = klineJordan
;

+Fixture
    'other stuff'
    'other stuff'
    "It's some generic other stuff, typical to expect to see around a college campus. "
    cannotTakeMsg = 'It\'s not anything {you/he} particularly want{s} to carry around with {you/him}... '
;

+Immovable
    'colorful flower*flowers*'
    'colorful flowers'
    "Many colorful flowers line the outside of Frey Hall. "
    isPlural = true
    cannotTakeMsg = 'As {you/he} {goes} to pluck a flower, a wild bulbasaur appears! {You/he} decide{s} not to take a flower, and the bulbasaur disappears. '
;

freyLobby: Room
    'Frey Lobby'
    'the first floor lobby'
    "You are standing in the lobby of Frey Hall. There are computer labs to the east, an office hallway to the southeast, stairs leading up, and a door leading outside. "
    southeast = officeHallway1
    east = labs
    out = frey
    up = freySecond
;

officeHallway1: Room
    'Office Hallway'
    "You are in the first floor office hallway of Frey Hall. You are outside Dr.\ Rohrbaugh's office. The hallway continues to the southeast, and leads to the first floor lobby of Frey Hall to the northwest. "
    southeast = officeHallway2
    northwest = freyLobby
    in = rohrbaughOffice
    out asExit(northwest)
;

officeHallway2: Room
    'Office Hallway'
    "You are in the first floor office hallway of Frey Hall. You are outside Dr.\ Owen's office. The hallway continues to the northwest and southeast. "
    southeast = officeHallway3
    northwest = officeHallway1
    in = owenOffice
;

officeHallway3: Room
    'Office Hallway'
    "You are in the first floor office hallway of Frey Hall. You are outside Dr.\ Weaver's office. The hallway continues to the northwest. "
    northwest = officeHallway2
    in = weaverOffice
;

weaverOffice: Room
    'Dr.\ Weaver\'s Office'
    'Dr.\ Weaver\'s office'
    "You are standing in Dr.\ Weaver's office. You see a door leading out to the office hallway. "
    out = officeHallway3
;

owenOffice: Room
    'Dr.\ Owen\'s Office'
    'Dr.\ Owen\'s office'
    "You are standing in Dr.\ Owen's office. There are many papers lying about the office. You see a door leading out to the office hallway. "
    out = officeHallway2
;

rohrbaughOffice: Room
    'Dr.\ Rohrbaugh\'s Office'
    'Dr.\ Rohrbaugh\'s office'
    "You are in Dr.\ Rohrbaugh's office. Various papers are strewn about, and Dr.\ Rohrbaugh is nowhere to be seen. Outside is the office hallway. "
    out = officeHallway1
;

freySecond: Room
    'Second Floor Frey'
    'the second floor lobby'
    "You are in the lobby on the second floor of Frey Hall. Inexplicably, the only room you can see is Dr.\ Fish's office. There are stairs leading both up and down. "
    down = freyLobby
    up = freyThird
    in = fishOffice
;

fishOffice: Room
    'Dr.\ Fish\'s Office'
    'Dr.\ Fish\'s office'
    "You are standing inside Dr.\ Fish's office. It looks surprisingly neat, with a stack of papers on his desk. "
    out = freySecond
;

+Heavy
    'fish desk'
    'desk'
    "It's a scaly desk shaped like a fish. "
    cannotTakeMsg = 'Dr.\ Fish\'s desk is a little bit to be carrying around. '
;

freyThird: Room
    'Third Floor Frey'
    'the third floor lobby'
    "You are in the lobby on the third floor of Frey Hall. Be careful not to fall! You see a door into Dr.\ Hare's office, and stairs leading down. "
    in = hareOffice
    down = freySecond
;

hareOffice: Room
    'Dr.\ Hare\'s Office'
    'Dr.\ Hare\'s office'
    "You are standing inside Dr.\ Hare's office. You see a stack of papers on a filing cabinet. "
    out = freyThird
;

+Heavy
    '(filing) cabinet'
    'filing cabinet'
    "It's Dr.\ Hare's filing cabinet. It holds papers and stuff. "
    cannotTakeMsg = '{You/he} tr{ies} to pick up the filing cabinet, but it\'s way too heavy. '
;

labs: Room
    'Computer Lab'
    "You are standing in a computer lab. You see a bunch of computers and a few printers. "
    out = freyLobby
    west asExit(out)
;

+Heavy
    '(lab) printer*printers*'
    'lab printers'
    "Two printers sit at the front of the room to meet the printing needs of students. "
    isPlural = true
    cannotTakeMsg = 'The printers are far too heavy, and would be of little use to {you/him} once disconnected from the network in any case. '
;

+Fixture
    '(lab) computer*computers'
    'lab computers'
    "Several rows of computers fill the room. "
    isPlural = true
    cannotTakeMsg = 'The computers are tied down. Even if {you/he} wanted to take one of these heavy machines, {you/he} would be unable to. '
;
