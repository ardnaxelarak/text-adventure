#include <adv3.h>
#include <en_us.h>

gameMain: GameMainDef
    initialPlayerChar = me
    showIntro()
    {
        "<.p>Welcome to <q><<versionInfo.name>></q>. You suddenly find yourself in Dr.\ Rohrbaugh's office, but Dr.\ Rohrbaugh is nowhere to be seen. What could have happened to him? You have no recollection of events that just happened. You are carrying a shovel with a slight reddish hue. You think it might be rust...<.p>The goal of this game is to figure out what happened to Dr.\ Rohrbaugh, and to resolve the situation if possible. <.p>";
    }
;

versionInfo: GameID
    name = 'Dr.\ Rohrbaugh and Mr.\ Tigerram'
    byline = 'by Nathan Chaney, Kara Felix, and Rebekah Smith'
    desc = 'Newly being ported to TADS 3'
    version = '1'
    IFID = 'F9B64C6C-B7B9-4887-8772-58A5F2479D78'
;

me: Actor
    location = rohrbaughOffice
;

+torch: Flashlight
    'small blue (flash) torch/flashlight/light'
    'small blue flashlight'
    "It's just a small blue flashlight. "
;
