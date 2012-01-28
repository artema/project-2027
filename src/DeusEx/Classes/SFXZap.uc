class SFXZap extends Effects;

auto simulated state Flying
{
	simulated function HitWall(vector HitNormal, actor Wall)
	{
		Destroy();
	}
	simulated function BeginState()
	{
		Velocity = VRand() * 150;
		Velocity.Z = FRand() * 100 + 200;
	}
}

simulated function Tick(float deltaTime)
{
	if (Velocity == vect(0,0,0))
	{
		Destroy();
	}

	if(Region.Zone.bWaterZone)
		Destroy();
}

defaultproperties
{
     ScaleGlow=2.000000
     bUnlit=True
	 RemoteRole=ROLE_None
     DrawType=DT_Sprite
     Style=STY_Translucent
     Texture=Texture'GameMedia.Effects.ef_HitMuzzle001';
     DrawScale=0.04
     bCollideWorld=True
     Physics=PHYS_Falling
}