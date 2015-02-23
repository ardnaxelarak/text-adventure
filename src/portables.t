#include <adv3.h>
#include <en_us.h>

shovel: Thing
    'reddish rusty shovel'
    'shovel'
    @me
    "It is a shovel with a vague reddish hue that {you/he} hope{s} is rust. "
    dobjFor(Drop)
    {
        action()
        {
            inherited;
            "{You/he} gently lay{s} the shovel on <<location.roomFloor.theName>>. ";
        }
    }
    iobjFor(DigWith)
    {
        verify() {}
        check() {}
    }
;

basketball: Thing
    '(basket) ball/basketball'
    'basketball'
    @boyer
;

lantern: Hidden, Flashlight
    'lantern/light'
    'lantern'
    @backEntrance
    "It is a lantern. It gives off light. "
;

flashlight: Flashlight
    '(flash) light/flashlight'
    'flashlight'
    @felix
    "It is a flashlight. "
;

sword: Thing
    'imaginary sword'
    'imaginary sword'
    @chapel
    "It is a sword that does not actually exist. "
    initSpecialDesc = "You see an imaginary sword in one of the bushes. "
    okayTakeMsg = '{You/he} lift{s} the sword as though it were nothing. '
;

apple: ImaginaryFood
    'imaginary apple/fruit*fruits'
    'imaginary apple'
    @uStore
    "It is an apple that does not actually exist. "
;

kiwi: ImaginaryFood
    'imaginary kiwi fruit/kiwifruit*fruits'
    'imaginary kiwifruit'
    @ssStore
    "It is a kiwifruit that does not actually exist. "
;

knife: Thing
    'beautiful pocket knife'
    'knife'
    @smith
    "It is a beautiful pocket knife. "
;

rohrbaughOfficeKey: Hidden, OfficeKey
    'blue office key*keys'
    'blue key'
    @boyer
;

owenOfficeKey: Hidden, OfficeKey
    'red office key*keys'
    'red key'
    @naugle
;

weaverOfficeKey: Hidden, OfficeKey
    'yellow office key*keys'
    'yellow key'
    @mellinger
;

hareOfficeKey: Hidden, OfficeKey
    'green office key*keys'
    'green key'
    @mainEntrance
;

fishOfficeKey: Hidden, OfficeKey
    'orange office key*keys'
    'orange key'
    @engle
;

idCard: Thing
    '(student) id card'
    'ID card'
    @witmer
    "It is a student ID card. {You/he} cannot make out the name. "
    initSpecialDesc = "You see an ID card laying on the ground. "
    initDesc = "It is a student ID card. Whoever left it behind seems unlikely to find it all the way out here... "
    dobjFor(Take)
    {
        action()
        {
            if (!self.moved)
                "{You/he} pick{s} up the ID card, hoping its owner will not return for it. ";
            inherited;
        }
    }
;

tumbleweed: Thing
    '(tumble) weed/tumbleweed'
    'tumbleweed'
    @dLot
    "It is a tumbleweed. "
    specialDesc = "You see a tumbleweed tumble past. "
    initDesc = "It is a tumbleweed. {You/he} {do}n't know how it got here... "
    okayDropMsg = '{You/he} drop{s} the tumbleweed. It starts to tumble around. {You/he} watch{es} it for a moment, entranced. '
    tries = 0
    dobjFor(Take)
    {
        check()
        {
            if (rand(3) == 1)
            {
                "{You/he} <<tries > 0 ? 'finally ' : '' >> grab{s} the tumbleweed. It's so exciting! What will {you/he} do with it? ";
                tries = 0;
            }
            else
            {
                tries++;
                failCheck('{You/he} tr{ies} to grab the tumbleweed, but it tumbles past {your/his} hands. ');
            }
        }
    }
;

bike: BasicChair
    'bike/bicycle'
    'bike'
    @boyer
    "It's a bike. You can use it to go places you have visited. "
    specialDesc = "You see a bike <<location.ofKind(HasBikeRack) ? 'sitting in the bike rack' : 'lying on the ground'>>. It doesn't seem to belong to anyone nearby. "
    dobjFor(Take)
    {
        action()
        {
            if (!self.moved)
                "{You/he} take{s} the bike and put{s} it in {your/his} apparently bottomless pockets. {You/he} can now use it to revisit some places {you/he} {has} already been. Hopefully its owner won't return looking for it in the near future. ";
            inherited;
        }
    }
    dobjFor(Drop)
    {
        action()
        {
            inherited;
            if (location.ofKind(HasBikeRack))
                "{You/he} place{s} the bike in the bike rack, ready for the next passerby to st-- er, borrow. ";
            else
                "{You/he} leave{s} the bike lying on <<location.roomFloor.theName>>, ready for the next passerby to st-- er, borrow. ";
        }
    }
    dobjFor(Ride)
    {
        verify() {}
        action()
        {
            "You ride the bike for a little bit, and then dismount. ";
            bikeMenu.display();
        }
    }
;

bikeMenu: MenuItem 'Where do you want to bike?';
+MenuItem 'here';
+MenuItem 'there';
