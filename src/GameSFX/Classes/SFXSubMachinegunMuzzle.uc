class SFXSubMachinegunMuzzle extends Effects;

var() float Frequency;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	SetTimer(Frequency, True);
}

function Timer()
{
	local rotator rot;
	
	if(!bHidden)
	{
		ScaleGlow = FRand() + FRand();
		SetRotation(Rotation);
	}
}

defaultproperties
{
	 Frequency=0.05
     DrawType=DT_Mesh
     Mesh=LodMesh'GameMedia.SubMachinegunMuzzle'
     bUnlit=True
}