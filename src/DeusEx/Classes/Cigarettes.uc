//=============================================================================
// ��������. �������� Ded'�� ��� ���� 2027
// Cigarettes. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Cigarettes extends DeusExPickup;

enum ECigSkin
{
	ES_M_Yellow,
	ES_M_Blue,
	ES_M_Red,
	ES_M_Green,
	ES_Camel,
    ES_M_Random
};

var() ECigSkin SkinType;
var bool bRandomSkin;
var bool bCamelSkin;

function BeginPlay()
{
	Super.BeginPlay();

	if(bCamelSkin)
	{
		MultiSkins[1] = Texture'GameMedia.Skins.CigarettesTex4';
		PlayerViewMesh=LodMesh'GameMedia.CigarettesOld';
     	PickupViewMesh=LodMesh'GameMedia.CigarettesOld';
     	ThirdPersonMesh=LodMesh'GameMedia.CigarettesOld';
     	Mesh=LodMesh'GameMedia.CigarettesOld';
	}
}

simulated function Tick(float deltaTime)
{    
	Super.Tick(deltaTime);
	
	if(bCamelSkin)
	{		
     	MultiSkins[1] = Texture'GameMedia.Skins.CigarettesTex4';
     	PlayerViewMesh=LodMesh'GameMedia.CigarettesOld';
     	PickupViewMesh=LodMesh'GameMedia.CigarettesOld';
     	ThirdPersonMesh=LodMesh'GameMedia.CigarettesOld';
     	Mesh=LodMesh'GameMedia.CigarettesOld';
	}
	else
	{
		MultiSkins[1] = None;
		PlayerViewMesh=LodMesh'GameMedia.CigarettesNew';
	    PickupViewMesh=LodMesh'GameMedia.CigarettesNew';
	    ThirdPersonMesh=LodMesh'GameMedia.CigarettesNew';
	    Mesh=LodMesh'GameMedia.CigarettesNew';
	}
}

state Activated
{
	function Activate()
	{
	}

	function BeginState()
	{
		local Pawn P;
		local vector loc;
		local rotator rot;
		local SmokeTrail puff;
		
		Super.BeginState();

		P = Pawn(Owner);
		if (P != None)
		{
			P.TakeDamage(1, P, P.Location, vect(0,0,0), 'PoisonGas');
			loc = Owner.Location;
			rot = Owner.Rotation;
			loc += 2.0 * Owner.CollisionRadius * vector(P.ViewRotation);
			loc.Z += Owner.CollisionHeight * 0.9;
			puff = Spawn(class'SmokeTrail', Owner,, loc, rot);
			if (puff != None)
			{
				puff.DrawScale = 1.0;
				puff.origScale = puff.DrawScale;
			}
			PlaySound(sound'MaleCough');
		}

		UseOnce();
	}
Begin:
}

defaultproperties
{
     M_Activated=""
     maxCopies=20
     bCanHaveMultipleCopies=True
     bActivatable=True
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'GameMedia.CigarettesNew'
     PickupViewMesh=LodMesh'GameMedia.CigarettesNew'
     ThirdPersonMesh=LodMesh'GameMedia.CigarettesNew'
     Icon=Texture'DeusExUI.Icons.BeltIconCigarettes'
     largeIcon=Texture'DeusExUI.Icons.LargeIconCigarettes'
     largeIconWidth=29
     largeIconHeight=43
     Mesh=LodMesh'GameMedia.CigarettesNew'
     CollisionRadius=4.000000
     CollisionHeight=0.650000
     Mass=2.000000
     Buoyancy=3.000000
}
