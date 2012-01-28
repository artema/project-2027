//=======================================================
// ������ - MP5-SD. �������� Ded'�� ��� ���� 2027
// Weapon - MP5-SD. Copyright (C) 2005 Ded 
// ����� ������/Model created by: Kelkos
// Deus Ex: 2027
//=======================================================
class WeaponMP40 expands GameWeapon;

defaultproperties
{
	 bIsUniqueWeapon=True
	 bCannotBePickedUp=True
	 
     HitDamage=16

     BaseAccuracy=0.60
     MinWeaponAcc=0.25

     ShotTime=0.10
     reloadTime=2.0

     ShotDeaccuracy=0.2

     recoilStrength=0.400000

     shakemag=380

     maxRange=3200
     AccurateRange=1200

     NoiseLevel=1.900000

     AmmoName=Class'DeusEx.RAmmo556mm'

     ReloadCount=32
     PickupAmmoCount=32
     LowAmmoWaterMark=32

     FireSound=Sound'GameMedia.Weapons.MP40Fire'

     AltFireSound=Sound'GameMedia.Weapons.MP40ReloadEnd'
     CockingSound=Sound'GameMedia.Weapons.MP40Reload'
     SelectSound=Sound'GameMedia.Weapons.MP40Select'

	 bUseWhileCrouched=False
     bCanHaveModBaseAccuracy=True
     bCanHaveModReloadCount=True
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True
     bCanHaveModRecoilStrength=True

     Icon=Texture'Game.Icons.BeltIconMP40'
     largeIcon=Texture'Game.Icons.LargeIconMP40'
     largeIconWidth=97
     largeIconHeight=52
     invSlotsX=2
     invSlotsY=2
     InventoryGroup=117

     GoverningSkill=Class'DeusEx.SkillWeaponPistol'

     HIResPickupMesh=LodMesh'GameMedia.MP40Pickup'
     LOResPickupMesh=LodMesh'GameMedia.MP40PickupL'
     HIRes3rdMesh=LodMesh'GameMedia.MP403rd'
     LORes3rdMesh=LodMesh'GameMedia.MP403rdL'

     FireOffset=(X=-16.000000,Y=5.000000,Z=11.500000)
     PlayerViewOffset=(X=26.000000,Y=-10.000000,Z=-15.000000)
     PlayerViewMesh=LodMesh'DeusExItems.AssaultGun'
     PickupViewMesh=LodMesh'GameMedia.MP40Pickup'
     ThirdPersonMesh=LodMesh'GameMedia.MP403rdL'
     Mesh=LodMesh'GameMedia.MP40Pickup'
     CollisionRadius=15.000000
     CollisionHeight=0.800000
     Mass=30.000000
     RealMass=2.4
}