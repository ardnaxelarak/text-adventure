#include <adv3.h>
#include <en_us.h>

/* verb definitions */
DefineTAction(Ride);

VerbRule(Ride)
    'ride' singleDobj
    : RideAction
    verbPhrase = 'ride/riding (what)'
;

modify Thing
    dobjFor(Ride)
    {
        preCond = [sittingOnObj]
        verify()
        {
            illogical('{That dobj/he} is not something {you/he} can ride. ');
        }
    }
;

modify Room
    unknownDestinations = []
    actorKnowsDestination(actor, conn)
    {
        return unknownDestinations.indexOf(conn) ? inherited(actor, conn) : true;
    }
;

sittingOnObj: PreCondition
    checkPreCondition(obj, allowImplicit)
    {
        /* 
         *   if there's no object, or the actor is already sitting on
         *   the object, there's nothing to do
         */
        if (obj == nil || (gActor.location == obj && gActor.posture == sitting))
            return nil;

        /* 
         *   Try an implicit 'sit on x' on the object.
         */
        if (allowImplicit && tryImplicitAction(SitOn, obj))
        {
            /* make sure it worked */
            if (gActor.location == obj && gActor.posture == sitting)
                exit;
            
            /* tell the caller we tried an implied command */
            return true;
        }
            
        /* we can't sit on the object implicitly, so give up */
        reportFailure('{You/he} can\'t do that unless {you\'re/he\'s} sitting on {the obj/him}', obj);

        /* make it the pronoun */
        gActor.setPronounObj(obj);

        /* abort the command */
        exit;
    }

    /* lower the likelihood rating for something not being sat upon */
    verifyPreCondition(obj)
    {
        if (obj != nil && !(gActor.location == obj && gActor.posture == sitting))
            logicalRankOrd(80, 'implied sit', 150);
    }
;

/* code for digging */
modify defaultGround
    dobjFor(DigWith) remapTo(DigWith, gActor.location, IndirectObject)
;

modify defaultFloor
    dobjFor(DigWith) remapTo(DigWith, gActor.location, IndirectObject)
;

modify Room
    digMsg = "Using {your/his} <<gIobj.name>> {you/he} dig{s} a few small holes but find{s} nothing of interest. "
    dobjFor(DigWith)
    {
        preCond = [new ObjectPreCondition(roomFloor, objVisible), new ObjectPreCondition(roomFloor, touchObj)]
        action()
        {
            digMsg;
        }
    }
;

modify OutdoorRoom
    dobjFor(DigWith)
    {
        verify() {}
    }
;

/* bike racks */
class HasBikeRack: object;

MultiInstance
    initialLocationClass = HasBikeRack
    instanceObject: Fixture
    {
        '(bike) rack'
        'bike rack'
        "It's a rack for putting bicycles while students are in class. "
        initialLocationClass = HasBikeRack
        cannotTakeMsg = 'The bike rack is a little big to be carrying around. '
    }
;

class Imaginary: object;

class ImaginaryFood: Imaginary, Food
    dobjFor(Take)
    {
        action()
        {
            if (!self.moved)
                "{You/he} just picked up <<self.aName>>! ";
            inherited;
        }
    }
    dobjFor(Eat)
    {
        check()
        {
            failCheck('It isn\'t real... {You/he} can\'t eat it. ');
        }
    }
;

class OfficeKey: Key
    desc = "It is <<self.aName>> that looks similar to office keys {you/he} {has} seen before. "
;

class LairKey: Key
    desc = "It is <<self.aName>> that gives you a feeling of finality. "
;
