//=============================================================================
// ShakeTrigger.
//=============================================================================
class NoiseTrigger extends Trigger;

var() float NoiseRadius;

function Trigger(Actor Other, Pawn Instigator)
{
	AISendEvent('LoudNoise', EAITYPE_Audio, 2.0, NoiseRadius);

	Super.Trigger(Other, Instigator);
}

defaultproperties
{
	NoiseRadius=128
	TriggerType=TT_AnyProximity
	bTriggerOnceOnly=False
	bCollideActors=False
}
