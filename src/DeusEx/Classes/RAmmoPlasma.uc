//=============================================================================
// ��������� - ������. �������� Ded'�� ��� ���� 2027
// Ammo - Plasma. Copyright (C) 2003 Ded
//=============================================================================
class RAmmoPlasma extends DeusExAmmo;

defaultproperties
{
	 bCannotBePickedUp=True
     bIsNonStandard=True
     bShowInfo=True
     AmmoAmount=12
     MaxAmmo=96
     PickupViewMesh=LodMesh'DeusExItems.AmmoPlasma'
     LandSound=Sound'DeusExSounds.Generic.PlasticHit2'
     Icon=Texture'DeusExUI.Icons.BeltIconAmmoPlasma'
     largeIconWidth=22
     largeIconHeight=46
     Mesh=LodMesh'DeusExItems.AmmoPlasma'
     CollisionRadius=4.300000
     CollisionHeight=8.440000
     bCollideActors=True
}
