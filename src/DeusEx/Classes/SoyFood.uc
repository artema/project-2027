//=============================================================================
// ������ ���. �������� Ded'�� ��� ���� 2027
// Soy food. Copyright (C) 2003 Ded
//=============================================================================
class SoyFood extends DeusExPickup;

enum ESkin
{
	ES_SoyFood,
	ES_Chips
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
			player.HealPlayer(5, False);
		
                PlaySound(sound'GameMedia.Misc.FoodSound');
		UseOnce();
	}
Begin:
}

simulated function Tick(float deltaTime)
{
    Super.Tick(deltaTime);

    switch (SkinType)
	{
		case ES_SoyFood:
			break;
			
		case ES_Chips:
			break;
	}
}

defaultproperties
{
     M_Activated=""
     maxCopies=10
     bCanHaveMultipleCopies=True
     bActivatable=True
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.SoyFood'
     PickupViewMesh=LodMesh'DeusExItems.SoyFood'
     ThirdPersonMesh=LodMesh'DeusExItems.SoyFood'
     Icon=Texture'DeusExUI.Icons.BeltIconSoyFood'
     largeIcon=Texture'DeusExUI.Icons.LargeIconSoyFood'
     largeIconWidth=42
     largeIconHeight=46
     Mesh=LodMesh'DeusExItems.SoyFood'
     CollisionRadius=8.000000
     CollisionHeight=0.980000
     Mass=3.000000
     Buoyancy=4.000000
}
