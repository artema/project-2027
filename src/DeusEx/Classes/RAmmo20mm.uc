//=============================================================================
// ��������� - 20�� �������. �������� Ded'�� ��� ���� 2027
// Ammo - 20mm grenades. Copyright (C) 2003 Ded 
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class RAmmo20mm extends DeusExAmmo;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	log("***2027 - Fuck! Another bug found!***");
	Destroy();
}

defaultproperties
{
     bIsNonStandard=True
     bShowInfo=True
     AmmoAmount=1
     MaxAmmo=12
     PickupViewMesh=LodMesh'DeusExItems.TestBox'
     LandSound=Sound'DeusExSounds.Generic.MetalHit1'
     Icon=Texture'DeusExUI.Icons.BeltIconAmmo20mm'
     largeIcon=Texture'DeusExUI.Icons.LargeIconAmmo20mm'
     largeIconWidth=47
     largeIconHeight=37
     Mesh=LodMesh'DeusExItems.TestBox'
     CollisionRadius=1.300000
     CollisionHeight=2.900000
     bCollideActors=True     
}
