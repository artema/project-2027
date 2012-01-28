class SFXSmokeGrenade expands Effects;

var() float RiseRate;
var() bool bGravity;
var float OrigLifeSpan;
var float OrigScale;
var vector OrigVel;
var bool bScale;
var bool bFade;
var bool bFrozen;

function PostBeginPlay()
{
	RiseRate = FRand()* 0.05;
	OrigScale = DrawScale;
	DrawScale = FRand() + 2;	
	OrigLifeSpan = LifeSpan;
	LifeSpan = FRand() * 5 + 35;	
}

auto simulated state Flying
{
	simulated function Tick(float deltaTime)
	{
		// if we are frozen, don't update
		if (bFrozen && (Owner != None))
		{
			LifeSpan += deltaTime;
			return;
		}

		Velocity.X = OrigVel.X + 2 - FRand() * 5;
		Velocity.Y = OrigVel.Y + 2 - FRand() * 5;

		if (bGravity)
			Velocity.Z += Region.Zone.ZoneGravity.Z * deltaTime * 0.2;
		else
			Velocity.Z = OrigVel.Z + (RiseRate * (OrigLifeSpan - LifeSpan)) * (FRand() * 0.2 + 0.9);

		if (bScale)
		{
			if ( Level.NetMode != NM_Standalone )
				DrawScale = FClamp(OrigScale * (1.0 + (OrigLifeSpan - LifeSpan)), 0.4, 4.0);
			else
				DrawScale = FClamp(OrigScale * (1.0 + (OrigLifeSpan - LifeSpan)), 0.01, 4.0);
		}
		if (bFade)
			ScaleGlow = LifeSpan / OrigLifeSpan;	// this actually sets the alpha from 1.0 to 0.0
	}
	simulated function BeginState()
	{
		Super.BeginState();

		OrigScale = DrawScale;
		OrigVel = Velocity;
		OrigLifeSpan = LifeSpan;
	}
}

defaultproperties
{
     riseRate=0.025
     bScale=True
     bFade=True
     Physics=PHYS_Projectile
     LifeSpan=30.000000
     DrawType=DT_Sprite
     Style=STY_Translucent
     Texture=Texture'GameMedia.Effects.ef_ExpSmoke009'
     DrawScale=0.040000
}
