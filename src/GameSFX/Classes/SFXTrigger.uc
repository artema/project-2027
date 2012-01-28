class SFXTrigger extends Trigger;

var() class<actor> EffectClass;

singular function Trigger(Actor Other, Pawn Instigator)
{
	Spawn(EffectClass, None);
}

defaultproperties
{
     bTriggerOnceOnly=False
}