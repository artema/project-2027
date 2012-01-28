class SFXFireComet extends DeusExFragment;

auto simulated state Flying
{
	simulated function HitWall(vector HitNormal, actor Wall)
	{
		local SFXDecalBurnMark mark;

		mark = spawn(class'SFXDecalBurnMark',,, Location, Rotator(HitNormal));
		if (mark != None)
		{
			mark.DrawScale = 0.4*DrawScale;
			mark.ReattachDecal();
		}
		Destroy();
	}
	simulated function BeginState()
	{
		Velocity = VRand() * 300;
		Velocity.Z = FRand() * 200 + 200;
		DrawScale = 0.3 + FRand();
		SetRotation(Rotator(Velocity));
	}
}

simulated function Tick(float deltaTime)
{
	if (Velocity == vect(0,0,0))
	{
		spawn(class'SFXDecalBurnMark',,, Location, rot(16384,0,0));
		Destroy();
	}
	else
		SetRotation(Rotator(Velocity));

	if(Region.Zone.bWaterZone)
		Destroy();
}

defaultproperties
{
     DrawType=DT_Mesh
     Style=STY_Translucent
     Mesh=LodMesh'DeusExItems.FireComet'
     ScaleGlow=2.000000
     bUnlit=True
     CollisionRadius=0.000000
     CollisionHeight=0.000000
     bBounce=False
}