//=======================================================
// ������ - Colt Commando. �������� Ded'�� ��� ���� 2027
// Weapon - Colt Commando. Copyright (C) 2003 Ded 
// ����� ������/Model created by: dieworld
// Deus Ex: 2027
//=======================================================
class WeaponSpecialColtCommando expands WeaponColtCommando;

//Sound'MP5S.Weapons.M4A1SilencedFire'
defaultproperties
{
	 bIsUniqueWeapon=True
	  
	 bHasMuzzleFlash=False
	 
	 ShotSound(0)=Sound'GameMedia.Weapons.SniperFire2'
     ShotSound(1)=Sound'GameMedia.Weapons.SniperFire2'
	 
	 FireSound=Sound'GameMedia.Weapons.SniperFire2'
	 
	 BaseAccuracy=0.6
	 
	 maxRange=2900
     AccurateRange=1100

     NoiseVolume(0)=0.4
     NoiseVolume(1)=1.0
	 
	 InventoryGroup=12488
	 
	 largeIcon=Texture'Game.Icons.LargeIconColtS'
     largeIconWidth=187
     largeIconHeight=53
	 
	 HIResPickupMesh=LodMesh'GameMedia.ColtCommandoSPickup'
     LOResPickupMesh=LodMesh'GameMedia.ColtCommandoSPickup'
     HIRes3rdMesh=LodMesh'GameMedia.ColtCommandoS3rd'
     LORes3rdMesh=LodMesh'GameMedia.ColtCommandoS3rd'
     Mesh=LodMesh'GameMedia.ColtCommandoSPickup'
     PickupViewMesh=LodMesh'GameMedia.ColtCommandoSPickup'
     ThirdPersonMesh=LodMesh'GameMedia.ColtCommandoS3rd'
	 
     PlayerViewMesh=LodMesh'MP5S.m4a11st'
}