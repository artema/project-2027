//=============================================================================
// LaserProxy.
//=============================================================================
class TeslaProxy extends Effects;

state Interpolating
{
	event InterpolateEnd(Actor Other)
	{
		Super.InterpolateEnd(Other);

		if (InterpolationPoint(Other).bEndOfPath)
			Destroy();
	}
}

function PostBeginPlay()
{
	Super.PostBeginPlay();

	if(FRand() < 0.3)
		Multiskins[1] = Texture'GameMedia.Effects.Effect_Lightning1';
	else if(FRand() >= 0.3 && FRand() < 0.6)
		Multiskins[1] = Texture'GameMedia.Effects.Effect_Lightning2';
	else
		Multiskins[1] = Texture'GameMedia.Effects.Effect_Lightning3';
}


function bool SendActorOnPath(name ThisPath)
{
	local InterpolationPoint I;
	//local Actor A;
	local DeusExPlayer Player;
	local Headphones A;
	Player = DeusExPlayer(GetPlayerPawn());

			foreach AllActors (class'InterpolationPoint', I, 'pathbla2')
			{
				if (I.Position == 1)		// start at 1 instead of 0 - put 0 at the object's initial position
				{
					SetCollision(False, False, False);
					bCollideWorld = False;
					Target = I;
					SetPhysics(PHYS_Interpolating);
					PhysRate = 1.0;
					PhysAlpha = 0.0;
					bInterpolating = True;
					bStasis = False;
					GotoState('Interpolating');
					//break;
				}


if (I.Position == 1){
Spawn(class'ExplosionSmall', None, 'jopa', I.Location);
}

if (I.Position == 4){
Spawn(class'ExplosionBig', None, 'jopa', I.Location);
	//pl = DeusExPlayer(GetPlayerPawn());
	//pl.ClientMessage(String(I.Tag));
}
			}



	return True;
}

defaultproperties
{
     DrawType=DT_Mesh
     Style=STY_Translucent
     bUnlit=True
     ScaleGlow=2.0
     Mesh=LodMesh'GameMedia.Lightning'
     Physics=PHYS_Interpolating
}
