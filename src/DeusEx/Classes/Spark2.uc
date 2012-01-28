//=============================================================================
// Spark.
//=============================================================================
class Spark2 expands Effects;

var Rotator rot;

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
		Velocity = vect(0,0,0);
		rot = Rotation;
		rot.Roll += FRand() * 65535;
		SetRotation(rot);
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
     bNetOptional=True
     LifeSpan=0.250000
     DrawType=DT_Mesh
     Style=STY_Translucent
     Skin=Texture'GameMedia.Effects.ef_HitMuzzle001'
     Mesh=LodMesh'DeusExItems.FlatFX'
     DrawScale=0.0400000
     bUnlit=True
     bCollideWorld=True
     bBounce=True
     bFixedRotationDir=True
}
