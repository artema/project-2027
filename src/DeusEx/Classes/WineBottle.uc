//=============================================================================
// ����. �������� Ded'�� ��� ���� 2027
// Wine. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class WineBottle extends DeusExPickup;

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
			player.drugEffectTimer += 7.0;
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
     PlayerViewMesh=LodMesh'DeusExItems.WineBottle'
     PickupViewMesh=LodMesh'DeusExItems.WineBottle'
     ThirdPersonMesh=LodMesh'DeusExItems.WineBottle'
     LandSound=Sound'DeusExSounds.Generic.GlassHit1'
     Icon=Texture'DeusExUI.Icons.BeltIconWineBottle'
     largeIcon=Texture'DeusExUI.Icons.LargeIconWineBottle'
     largeIconWidth=36
     largeIconHeight=48
     Mesh=LodMesh'DeusExItems.WineBottle'
     CollisionRadius=4.060000
     CollisionHeight=16.180000
     Mass=10.000000
     Buoyancy=8.000000
}
