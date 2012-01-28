//=============================================================================
// ��������� - ������. �������� Ded'�� ��� ���� 2027
// Ammo - Rockets. Copyright (C) 2003 Ded
//=============================================================================
class RAmmoRocket extends DeusExAmmo;

defaultproperties
{
     bIsNonStandard=True
     bShowInfo=True
     AmmoAmount=4
     MaxAmmo=30
     PickupViewMesh=LodMesh'DeusExItems.GEPAmmo'
     LandSound=Sound'DeusExSounds.Generic.WoodHit2'
     Icon=Texture'DeusExUI.Icons.BeltIconAmmoRockets'
     largeIcon=Texture'DeusExUI.Icons.LargeIconAmmoRockets'
     largeIconWidth=46
     largeIconHeight=36
     Mesh=LodMesh'DeusExItems.GEPAmmo'
     CollisionRadius=18.000000
     CollisionHeight=7.800000
     bCollideActors=True
}
