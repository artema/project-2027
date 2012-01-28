//=============================================================================
// Молния. Сделанно Ded'ом для мода 2027
// Lightning. Copyright (C) 2003 Ded
//=============================================================================
class LightningEffect expands Effects;

var() float IntervalFactor;
var() sound EffectSound[4];
var() bool bPlayPost;

simulated function BeginPlay()
{
	SetTimer(IntervalFactor+FRand()*IntervalFactor,False);
	LightType = LT_None;
	Texture = None;
}

simulated function Timer()
{
	local DeusExPlayer Player;
	local bool bNotActive;
	
	Player = DeusExPlayer(GetPlayerPawn());
	
	bNotActive = !Player.bWeatherEnabled;
	
	if(!bNotActive)
	{
		if(LightType == LT_Flicker)
		{
			if (bPlayPost)
			{
				if(FRand() >= 0 && FRand() < 0.25)
					PlaySound(EffectSound[0],,180+75*FRand(),True,1000000,);
				else if(FRand() >= 0.25 && FRand() < 0.5)
					PlaySound(EffectSound[1],,180+75*FRand(),True,1000000,);
				else if(FRand() >= 0.5 && FRand() < 0.75)
					PlaySound(EffectSound[2],,180+75*FRand(),True,1000000,);
				else
					PlaySound(EffectSound[3],,180+75*FRand(),True,1000000,);
			}

			LightType = LT_None;
			SetTimer(IntervalFactor+FRand()*IntervalFactor,False);
		}
		else 
		{
			if(!bPlayPost)
			{
				if(FRand() >= 0 && FRand() < 0.25)
					PlaySound(EffectSound[0],,180+75*FRand(),True,1000000,);
				else if(FRand() >= 0.25 && FRand() < 0.5)
					PlaySound(EffectSound[1],,180+75*FRand(),True,1000000,);
				else if(FRand() >= 0.5 && FRand() < 0.75)
					PlaySound(EffectSound[2],,180+75*FRand(),True,1000000,);
				else
					PlaySound(EffectSound[3],,180+75*FRand(),True,1000000,);
			}

			LightType = LT_Flicker;
			SetTimer(0.8+FRand()*0.5,False);
		}
	}

	if((LightType == LT_Flicker) && bNotActive)
	{
		LightType = LT_None;
		SetTimer(IntervalFactor+FRand()*IntervalFactor,False);
	}

	if((LightType == LT_None) && bNotActive)
		SetTimer(IntervalFactor+FRand()*IntervalFactor,False);
}

defaultproperties
{
     bPlayPost=True
     EffectSound(0)=Sound'GameMedia.Misc.Thunder'
     EffectSound(1)=Sound'GameMedia.Misc.Thunder1'
     EffectSound(2)=Sound'GameMedia.Misc.Thunder2'
     EffectSound(3)=Sound'GameMedia.Misc.Thunder3'
     IntervalFactor=30.0
     bNoDelete=True
     bAlwaysRelevant=True
     DrawType=DT_Sprite
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
}
