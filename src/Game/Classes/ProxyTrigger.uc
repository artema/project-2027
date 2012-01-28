//=============================================================================
// LogicTrigger
//=============================================================================
class ProxyTrigger expands Trigger;

function Trigger(Actor Other, Pawn Instigator)
{
	local Actor A;

	if(Event != '')
		foreach AllActors(class 'Actor', A, Event)
			A.Trigger(Self, Instigator);

	Super.Trigger(Other, Instigator);
}

defaultproperties
{
     CollisionRadius=0.000000
     bCollideActors=False
}