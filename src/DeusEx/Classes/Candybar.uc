//=============================================================================
// �������. �������� Ded'�� ��� ���� 2027
// Chocolate. Copyright (C) 2003 Ded
//=============================================================================
class Candybar extends DeusExPickup;

enum ESkin
{
	ES_Regular,
	ES_Dark
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
		case ES_Regular:
			MultiSkins[0] = Texture'GameMedia.Skins.ChocolateTex0';
			break;
			
		case ES_Dark:
			MultiSkins[0] = Texture'GameMedia.Skins.CandybarAlenka';
			break;
	}
}

defaultproperties
{
     M_Activated=""
     MultiSkins(0)=Texture'GameMedia.Skins.ChocolateTex0'
     maxCopies=10
     bCanHaveMultipleCopies=True
     bActivatable=True
     ItemName="Candybar"
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Candybar'
     PickupViewMesh=LodMesh'DeusExItems.Candybar'
     ThirdPersonMesh=LodMesh'DeusExItems.Candybar'
     Icon=Texture'DeusExUI.Icons.BeltIconCandyBar'
     largeIcon=Texture'DeusExUI.Icons.LargeIconCandyBar'
     largeIconWidth=46
     largeIconHeight=36
     Description="Candybar"
     beltDescription="Candybar"
     Mesh=LodMesh'DeusExItems.Candybar'
     CollisionRadius=6.250000
     CollisionHeight=0.670000
     Mass=3.000000
     Buoyancy=4.000000
}
