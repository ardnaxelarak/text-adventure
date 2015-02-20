#include <adv3.h>
#include <en_us.h>

gameMain: GameMainDef
    initialPlayerChar = me
;

versionInfo: GameID
    name = 'Dr. Rohrbaugh and Mr. Tigerram'
    byline = 'by Nathan Chaney, Kara Felix, and Rebekah Smith'
    desc = 'Newly being ported to TADS 3'
    version = '1'
    IFID = 'F9B64C6C-B7B9-4887-8772-58A5F2479D78'
;

me: Actor
    location = boyer
;

+torch: Flashlight
    'small blue (flash) torch/flashlight/light'
    'small blue flashlight'
    "It's just a small blue flashlight. "
;
