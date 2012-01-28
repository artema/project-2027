//=============================================================================
// ��������� - ������� �������. �������� Ded'�� ��� ���� 2027
// Ammo - Gas grenade. Copyright (C) 2003 Ded
//=============================================================================
class RAmmoRiotGrenade extends DeusExAmmo;

defaultproperties
{
	 bCannotBePickedUp=True
     AmmoAmount=1
     MaxAmmo=10
     PickupViewMesh=LodMesh'DeusExItems.TestBox'
     Icon=Texture'DeusExUI.Icons.BeltIconGasGrenade'
     Mesh=LodMesh'DeusExItems.TestBox'
     CollisionRadius=22.500000
     CollisionHeight=16.000000
     bCollideActors=True
}
