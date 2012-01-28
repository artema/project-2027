//=============================================================================
// ����. ������� Ded'�� ��� ���� 2027
// Beer. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Beer extends DeusExPickup;

enum ESkinColor
{
	SC_Super45,
	SC_Bottle2,
	SC_Bottle3,
	SC_Bottle4
};

var() ESkinColor SkinColor;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinColor)
	{
		case SC_Super45:		Skin = Texture'Liquor40ozTex1'; break;
		case SC_Bottle2:		Skin = Texture'Liquor40ozTex2'; break;
		case SC_Bottle3:		Skin = Texture'Liquor40ozTex3'; break;
		case SC_Bottle4:		Skin = Texture'Liquor40ozTex4'; break;
	}
}

state Activated
{
	function Activate()
	{
	}

	function BeginState()
	{
		local DeusExPlayer player;
		
		Super.BeginState();

		player = DeusExPlayer(Owner);
		if (player != None)
		{
			player.HealPlayer(2, False);
			player.drugEffectTimer += 4.0;
		}

		UseOnce();
	}
Begin:
}

defaultproperties
{
     M_Activated=""
     bBreakable=True
     maxCopies=10
     bCanHaveMultipleCopies=True
     bActivatable=True
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Liquor40oz'
     PickupViewMesh=LodMesh'DeusExItems.Liquor40oz'
     ThirdPersonMesh=LodMesh'DeusExItems.Liquor40oz'
     LandSound=Sound'DeusExSounds.Generic.GlassHit1'
     Icon=Texture'DeusExUI.Icons.BeltIconBeerBottle'
     largeIcon=Texture'DeusExUI.Icons.LargeIconBeerBottle'
     largeIconWidth=14
     largeIconHeight=47
     Mesh=LodMesh'DeusExItems.Liquor40oz'
     CollisionRadius=3.000000
     CollisionHeight=9.140000
     Mass=10.000000
     Buoyancy=8.000000
}
