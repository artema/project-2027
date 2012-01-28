//=======================================================
// ������ - AK-47. �������� Ded'�� ��� ���� 2027
// Weapon - AK-47. Copyright (C) 2003 Ded 
// ����� ������/Model created by: Kelkos
// Deus Ex: 2027
//=======================================================
class WeaponSpecialAK47 expands WeaponAK74;

defaultproperties
{
	 bHasMuzzleFlash=False
	 
	 NoiseVolume(0)=0.4
     NoiseVolume(1)=1.0
     
     ShotUntargeting(0)=0.25
     ShotUntargeting(1)=0.35
     
     ShotRecoil(0)=0.8
     ShotRecoil(1)=0.9
     
     ShotShake(0)=300
     ShotShake(1)=400
     
     MinWeaponAcc=0.05
     
     ShotSound(0)=Sound'GameMedia.Weapons.SilencedFire'
     ShotSound(1)=Sound'GameMedia.Weapons.SilencedFire'
	 
	 AIMinRange=500.0

	 bUseWhileCrouched=False	 
	 bIsUniqueWeapon=True
	 bCannotBePickedUp=False
	 
	 bCanHaveScope=True
	 bHasScope=True
	 
	 ScopeMin=30
	 ScopeMax=5
	 
	 InventoryGroup=10088
	 
	 ScopeFOV=30
	 
     ShotDamage(0)=23
     ShotDamage(1)=30

     BaseAccuracy=0.4
     MinWeaponAcc=0.05

     PlusPickupMesh=LodMesh'GameMedia.AK74PickupPlus'
     Plus3rdMesh=LodMesh'GameMedia.AK47Special3rd'
     HIRes3rdMesh=LodMesh'GameMedia.AK47Special3rd'
     LOResPickupMesh=LodMesh'GameMedia.AK74PickupL'
     LORes3rdMesh=LodMesh'GameMedia.AK47Special3rdL'
	 ThirdPersonMesh=LodMesh'GameMedia.AK47Special3rd'
     Mesh=LodMesh'GameMedia.AK74PickupPlus'
     PickupViewMesh=LodMesh'GameMedia.AK74PickupPlus'

	 Icon=Texture'Game.Icons.BeltIconAK'
     largeIcon=Texture'Game.Icons.LargeIconAK47'
     largeIconWidth=159
     largeIconHeight=53

     bNewSkin=True
     PickupViewSkins(1)=Texture'GameMedia.Skins.AK47Tex0'
     PickupViewSkins(3)=Texture'GameMedia.Skins.WeaponMods'
     PlayerViewSkins(3)=Texture'GameMedia.Skins.AK47Grip'
     PlayerViewSkins(4)=Texture'GameMedia.Skins.AK47Wood'
}