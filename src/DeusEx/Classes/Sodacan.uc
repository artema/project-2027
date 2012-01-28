//=============================================================================
// ���������. ������� Ded'�� ��� ���� 2027
// Soda can. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Sodacan extends DeusExPickup;

enum ESkin
{
	ES_Orange,
	ES_Blast,
	ES_Zap,
	ES_B
};

var() ESkin SkinType;

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
			player.HealPlayer(2, False);

		PlaySound(sound'MaleBurp');
		UseOnce();
	}
Begin:
}

simulated function Tick(float deltaTime)
{
    Super.Tick(deltaTime);

    switch (SkinType)
	{
		case ES_Orange:
			MultiSkins[2] = Texture'GameMedia.Skins.CanSodaTex1';
			break;
			
		case ES_Blast:
			MultiSkins[2] = Texture'GameMedia.Skins.CanSodaTex2';
			break;
		
		case ES_Zap:
			MultiSkins[2] = Texture'GameMedia.Skins.CanSodaTex3';
			break;	
			
		case ES_B:
			MultiSkins[2] = Texture'GameMedia.Skins.CanSodaTex4';
			break;
	}
}

defaultproperties
{
     MultiSkins(2)=Texture'GameMedia.Skins.CanSodaTex1'
     M_Activated=""
     maxCopies=10
     bCanHaveMultipleCopies=True
     bActivatable=True
     DrawScale=1.0
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'GameMedia.CanSoda'
     PickupViewMesh=LodMesh'GameMedia.CanSoda'
     ThirdPersonMesh=LodMesh'GameMedia.CanSoda'
     LandSound=Sound'DeusExSounds.Generic.MetalHit1'
     Icon=Texture'DeusExUI.Icons.BeltIconSodaCan'
     largeIcon=Texture'DeusExUI.Icons.LargeIconSodaCan'
     largeIconWidth=24
     largeIconHeight=45
     Mesh=LodMesh'GameMedia.CanSoda'
     CollisionRadius=3.000000
     CollisionHeight=4.500000
     Mass=5.000000
     Buoyancy=3.000000
}