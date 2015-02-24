#include <adv3.h>
#include <en_us.h>

boyer: OutdoorRoom
    'Boyer Hall'
    'Boyer Hall'
    "You feel a shudder as you watch humanities majors scurry into and out of Boyer Hall as though they actually had something important to do. The building looks dark and foreboding. "
    in = boyerFirst
    northeast = hoffman
    north = ecc
    west = oldMain
    southwest = climenhaga
    east = chapel
    unknownDestinations = [in]

    dobjFor(DigWith)
    {
        action()
        {
            if (!rohrbaughOfficeKey.discovered)
            {
                "Using {your/his} <<gIobj.name>> {you/he} dig{s} around, and to {your/his} surprise {you/he} find{s} <<rohrbaughOfficeKey.aName>>! ";
                rohrbaughOfficeKey.discover();
            }
            else
                inherited;
        }
    }
;

boyerFirst: DarkRoom 'First Floor Hallway'
    "You are in the first floor hallway of Boyer Hall. You see Howe Atrium to the west, Parmer Cinema to the east, and stairs leading up to the second floor. "
    out = boyer
    east = parmerCinema
    west = howeAtrium
    up = boyerSecond
;

parmerCinema: DarkRoom 
    'Parmer Cinema'
    'Parmer Cinema'
    "You are in Parmer Cinema; there are a bunch of seats and a giant screen in the front of the room. "
    west = boyerFirst
    out asExit(west)
;

+parmerSeats: Fixture
    'seat*seats/row/chair*chairs'
    'seats'
    "You see several rows of seats filling the room. "
    isPlural = true
    cannotTakeMsg = 'The seats are screwed to the floor, but there might be some junk you could find by searching under the seats. '
    actionDobjSearch()
    {
        if (lairKey3.discovered)
        {
            "{You/he} continue{s} to search through the seats, but find{s} nothing {you/he} would want{s} to take... ";
        }
        else
        {
            "Searching under the seats, {you/he} find{s} a tarnished silver key. ";
            lairKey3.discover();
        }
    }
    dobjFor(LookUnder) remapTo(Search, self)
;

+lairKey3: Hidden, Key
    'tarnished silver key'
    'tarnished silver key'
    "It's a tarnished silver key. "
;

howeAtrium: DarkRoom
    'Howe Atrium'
    'Howe Atrium'
    "You are in Howe Atrium; you see tables and chairs, and no windows for some strange reason. The hallway is to the east. "
    east = boyerFirst
;

boyerSecond: DarkRoom
    'Second Floor Hallway'
    "You are in the second floor hallway of Boyer Hall. You see classrooms to the east and west, and stairs leading up and down. "
    down = boyerFirst
    east = boyerSecondRoomE
    west = boyerSecondRoomW
    up = boyerThird
;

boyerSecondRoomE: DarkRoom
    'Classroom'
    "You are in a classroom on the second floor of Boyer Hall. You see several rows of chairs, and a chalkboard in the front of the room. There is a door leading back to the hallway to the west. "
    west = boyerSecond
    out asExit(west)
;

+Decoration
    'black chalk board/blackboard/chalkboard'
    'chalkboard'
    "It's a big chalkboard on the wall of the room. "
;

boyerSecondRoomW: DarkRoom
    'Classroom'
    "You are in a classroom on the second floor of Boyer Hall. You see many chairs and desks, and a blackboard. There is a door leading back to the hallway to the east. "
    east = boyerSecond
    out asExit(east)
;

+Decoration
    'black chalk board/blackboard/chalkboard'
    'chalkboard'
    "It's a big chalkboard on the wall of the room. "
;

boyerThird: DarkRoom
    'Third Floor Hallway'
    "You are in the third floor hallway of Boyer Hall. You see stairs leading up and down, and a classroom to the west. "
    west = boyerThirdRoom
    down = boyerSecond
    up = boyerFourth
;

boyerThirdRoom: DarkRoom
    'Classroom'
    "You are in a classroom on the third floor of Boyer Hall. There are many tables, as well as chairs and a blackboard. There is a door leading back to the hallway to the east. "
    east = boyerThird
    out asExit(east)
;

+Decoration
    'black chalk board/blackboard/chalkboard'
    'chalkboard'
    "It's a big chalkboard on the wall of the room. "
;

boyerFourth: DarkRoom
    'Fourth Floor Hallway'
    "You are in the fourth floor hallway of Boyer Hall. You see the philosophy department to the southeast, and stairs leading down. "
    down = boyerThird
    southeast = philDept
;

philDept: DarkRoom
    'Philosophy Department'
    "You are standing between the offices of the four philosophy professors. The fourth floor hallway is to the northwest. "
    northwest = boyerFourth
;
