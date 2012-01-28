//=============================================================================
// Молния. Сделанно Ded'ом для мода 2027
// Lightning. Copyright (C) 2003 Ded
//=============================================================================
class LightningEffectTriggered expands Trigger;

var() float TimeFactor;
var() sound ThunderSound;
var() bool bPlayPost;

function Trigger(Actor Other, Pawn Instigator)
{
	local DeusExPlayer player;

	Super.Trigger(Other, Instigator);

	player = DeusExPlayer(Instigator);

        Timer();

	if(bTriggerOnceOnly)
		Tag='LightningEffectTriggered';
}

simulated function Timer()
{
	if (LightType == LT_Flicker)
	{
	    if ((ThunderSound != None) && bPlayPost)
		PlaySound(ThunderSound,,255,True,1000000,);

		LightType = LT_None;
	}
	else 
	{
		LightType = LT_Flicker;

	    if ((ThunderSound != None) && !bPlayPost)
		PlaySound(ThunderSound,,255,True,1000000,);

		SetTimer(TimeFactor+FRand()*0.5,False);
	}
}

simulated function BeginPlay()
{
	LightType = LT_None;
	Texture = None;
}

defaultproperties
{
     bPlayPost=False
     ThunderSound=Sound'GameMedia.Misc.Thunder'
     TimeFactor=0.8
     bNoDelete=True
     bAlwaysRelevant=True
     Texture=Texture'Engine.S_Light'
     bMovable=False
     CollisionRadius=24.000000
     CollisionHeight=24.000000
     LightType=LT_Flicker
     LightBrightness=255
     LightSaturation=255
     LightRadius=255
     LightPeriod=32
     LightCone=128
     VolumeBrightness=64
     bTriggerOnceOnly=False
}
