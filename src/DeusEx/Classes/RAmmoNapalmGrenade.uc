//=============================================================================
// ��������� - ����������� �������. �������� Ded'�� ��� ���� 2027
// Ammo - Napalm Grenade. Copyright (C) 2003 Ded
//=============================================================================
class RAmmoNapalmGrenade extends DeusExAmmo;

defaultproperties
{
	 bCannotBePickedUp=True
     AmmoAmount=1
     MaxAmmo=10
     PickupViewMesh=LodMesh'DeusExItems.TestBox'
     Icon=Texture'Game.Icons.BeltIconNapalmGrenade'
     Mesh=LodMesh'DeusExItems.TestBox'
     CollisionRadius=22.500000
     CollisionHeight=16.000000
     bCollideActors=True
}
