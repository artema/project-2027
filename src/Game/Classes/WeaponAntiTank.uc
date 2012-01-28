//=======================================================
// ������ - LAW. �������� Ded'�� ��� ���� 2027
// Weapon - LAW. Copyright (C) 2003 Ded
//=======================================================
class WeaponAntiTank extends GameWeapon;

defaultproperties
{
	 bNewSkin=True
     PlayerViewSkins(0)=Texture'GameMedia.Skins.WeaponNewHands'
     
     HitDamage=500

     BaseAccuracy=0.6
     MinWeaponAcc=0.2

     ShotTime=0.3
     reloadTime=0.0

     ShotDeaccuracy=0.5

     recoilStrength=1.0

     shakemag=600

     maxRange=24000
     AccurateRange=14400
     AIMinRange=1400

     NoiseLevel=5.0

     ScopeFOV=15
     bCanTrack=True
     LockTime=3.000000
     LockedSound=Sound'GameMedia.Weapons.GEPLock'
     TrackingSound=Sound'GameMedia.Weapons.GEPTrack'

     bCanHaveScope=True
     bHasScope=True

     AmmoName=Class'DeusEx.AmmoNone'

     ProjectileClass=Class'Game.P_RocketLAW'

     ReloadCount=0
     PickupAmmoCount=1
     LowAmmoWaterMark=0

	 bUseWhileCrouched=False
     bHasMuzzleFlash=False
     bUseWhileCrouched=False
     bInstantHit=False
     bAutomatic=False
     bOldStyle=True

     FireSound=Sound'DeusExSounds.Weapons.LAWFire'

     SelectSound=Sound'DeusExSounds.Weapons.LAWSelect'
     LandSound=Sound'DeusExSounds.Generic.DropLargeWeapon'

     Icon=Texture'DeusExUI.Icons.BeltIconLAW'
     largeIcon=Texture'DeusExUI.Icons.LargeIconLAW'
     largeIconWidth=166
     largeIconHeight=47
     invSlotsX=4
     InventoryGroup=101

     GoverningSkill=Class'DeusEx.SkillWeaponHeavy'

     FireOffset=(X=28.000000,Y=12.000000,Z=4.000000)
     PlayerViewOffset=(X=8.000000,Y=-18.000000,Z=-7.000000)
     PlayerViewMesh=LodMesh'DeusExItems.LAW'
     PickupViewMesh=LodMesh'DeusExItems.LAWPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.LAW3rd'
     Mesh=LodMesh'DeusExItems.LAWPickup'
     CollisionRadius=25.000000
     CollisionHeight=6.800000
     Mass=50.000000
     RealMass=15.0
     
     bHideInfo=True
}