//=============================================================================
// Spark.
//=============================================================================
class SparkFlying expands DeusExFragment;

auto simulated state Flying
{
	simulated function HitWall(vector HitNormal, actor Wall)
	{
		local BurnMark mark;

		mark = spawn(class'BurnMark',,, Location, Rotator(HitNormal));
		if (mark != None)
		{
			mark.DrawScale = 0.4*DrawScale;
			mark.ReattachDecal();
		}
		Destroy();
	}
	simulated function BeginState()
	{
		Velocity = VRand() * 200;
		Velocity.Z = FRand() * 200 + 100;
		DrawScale = Default.DrawScale + Default.DrawScale*FRand();
		SetRotation(Rotator(Velocity));
	}
}

simulated function Tick(float deltaTime)
{
	if (Velocity == vect(0,0,0))
	{
		spawn(class'BurnMark',,, Location, rot(16384,0,0));
		Destroy();
	}
	else
		SetRotation(Rotator(Velocity));

	if(Region.Zone.bWaterZone)
		Destroy();
}

defaultproperties
{
     DrawType=DT_Sprite
     Style=STY_Translucent
     Texture=Texture'GameMedia.Effects.ef_HitMuzzle001'
     ScaleGlow=2.000000
     DrawScale=0.075
     bUnlit=True
     CollisionRadius=0.000000
     CollisionHeight=0.000000
     bBounce=False
}