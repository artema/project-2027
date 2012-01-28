class SFXMinigunMuzzle extends Effects;

var() float Frequency;

var ParticleGenerator smokeGen;

function PostBeginPlay()
{
	local rotator rot;
	
	Super.PostBeginPlay();

	smokeGen = Spawn(class'ParticleGenerator', Self);

	if (smokeGen != None)
	{
		smokeGen.particleTexture = Texture'GameMedia.Effects.ef_ExpSmoke011';
		smokeGen.particleDrawScale = 0.18 * DrawScale;
		smokeGen.bRandomEject = True;
		smokeGen.ejectSpeed = 100.0;
		smokeGen.particleLifeSpan = 0.25;
		smokeGen.bGravity = False;
		smokeGen.bScale = True;
		smokeGen.bParticlesUnlit = False;
		smokeGen.frequency = 0.85;
		smokeGen.checkTime = Frequency * 0.55;
		smokeGen.riseRate = 260.0;
		smokeGen.SetOwner(Self);
		smokeGen.SetBase(Self);
		smokeGen.SetRotation(Rotation);
	}

	SetTimer(Frequency, True);
}

function Timer()
{
	local rotator rot;
	
	if(!bHidden)
	{
		ScaleGlow = FRand() + FRand();
		
		rot = Rotation;
		rot.Roll = 65536 * FRand();
		SetRotation(rot);
	}
	
	if(smokeGen != None)
	{
		rot = Rotation;
		rot.Roll = 0;
		smokeGen.SetRotation(rot);
		smokeGen.SetLocation(Location);
		smokeGen.bSpewing = !bHidden;
	}
}

simulated function Destroyed()
{
	if (smokeGen != None)
		smokeGen.DelayedDestroy();

	Super.Destroyed();
}

defaultproperties
{
	 Frequency=0.05
     DrawType=DT_Mesh
     Style=STY_Translucent
     Mesh=LodMesh'GameMedia.MinigunMuzzle'
     bUnlit=True
}