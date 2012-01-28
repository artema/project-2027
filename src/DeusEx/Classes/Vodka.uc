//=============================================================================
// �����. ������� Ded'�� ��� ���� 2027
// Vodka. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Vodka extends DeusExPickup;

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
			player.HealPlayer(3, False);
			player.drugEffectTimer += 15.0;
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
     PlayerViewMesh=LodMesh'DeusExItems.LiquorBottle'
     PickupViewMesh=LodMesh'DeusExItems.LiquorBottle'
     ThirdPersonMesh=LodMesh'DeusExItems.LiquorBottle'
     LandSound=Sound'DeusExSounds.Generic.GlassHit1'
     Icon=Texture'DeusExUI.Icons.BeltIconLiquorBottle'
     largeIcon=Texture'DeusExUI.Icons.LargeIconLiquorBottle'
     largeIconWidth=20
     largeIconHeight=48
     Mesh=LodMesh'DeusExItems.LiquorBottle'
     CollisionRadius=4.620000
     CollisionHeight=12.500000
     Mass=10.000000
     Buoyancy=8.000000
}
