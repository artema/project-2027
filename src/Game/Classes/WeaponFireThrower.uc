//=======================================================
// ������ - �������. �������� Ded'�� ��� ���� 2027
// Weapon - FlameThrower. Copyright (C) 2003 Ded
//=======================================================
class WeaponFireThrower extends GameWeapon;

defaultproperties
{
	 bNewSkin=True
     PlayerViewSkins(0)=Texture'GameMedia.Skins.WeaponNewHands'
     PlayerViewSkins(1)=Texture'GameEffects.Fire.noz000'
     
     HitDamage=2

     BaseAccuracy=0.9
     MinWeaponAcc=0.9

     ShotTime=0.05
     reloadTime=5.5

     ShotDeaccuracy=0.2

     recoilStrength=0.35

     shakemag=100

     maxRange=550
     AccurateRange=550

     NoiseLevel=0.6

	 bUseWhileCrouched=False
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True

     AmmoName=Class'DeusEx.RAmmoGas'

     ReloadCount=100
     PickupAmmoCount=60
     LowAmmoWaterMark=50

     bInstantHit=False
     bAutomatic=True
     bOldStyle=True

     FireSound=Sound'DeusExSounds.Weapons.FlamethrowerFire'

     AltFireSound=Sound'DeusExSounds.Weapons.FlamethrowerReloadEnd'
     CockingSound=Sound'DeusExSounds.Weapons.FlamethrowerReload'
     SelectSound=Sound'DeusExSounds.Weapons.FlamethrowerSelect'
     LandSound=Sound'DeusExSounds.Generic.DropLargeWeapon'

     Icon=Texture'DeusExUI.Icons.BeltIconFlamethrower'
     largeIcon=Texture'DeusExUI.Icons.LargeIconFlamethrower'
     largeIconWidth=203
     largeIconHeight=69
     invSlotsX=4
     invSlotsY=2
     InventoryGroup=108

     bHasMuzzleFlash=False
     ProjectileClass=Class'Game.P_Fireball'

     GoverningSkill=Class'DeusEx.SkillWeaponHeavy'

     FireOffset=(Y=0.000000,Z=0.000000) //y=10 z=10
     PlayerViewOffset=(X=20.000000,Y=-14.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Flamethrower'
     PickupViewMesh=LodMesh'DeusExItems.FlamethrowerPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.Flamethrower3rd'
     Mesh=LodMesh'DeusExItems.FlamethrowerPickup'
     CollisionRadius=20.500000
     CollisionHeight=4.400000
     Mass=40.000000
     RealMass=12.0
     
     bHideInfo=True
}