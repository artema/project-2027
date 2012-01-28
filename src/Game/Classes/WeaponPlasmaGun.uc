//=============================================================================
// ������ - ���������� �����. �������� Ded'�� ��� ���� 2027
// Weapon - Plasma rifle. Copyright (C) 2003 Ded
//=============================================================================
class WeaponPlasmaGun extends GameWeapon;

defaultproperties
{
	 bIsUniqueWeapon=True
	 bCannotBePickedUp=True
	 
     HitDamage=35

     BaseAccuracy=0.6
     MinWeaponAcc=0.2

     ShotTime=0.7
     reloadTime=3.0

     ShotDeaccuracy=0.35

     recoilStrength=0.3

     shakemag=400

     maxRange=24000
     AccurateRange=14400

     NoiseLevel=2.0

     bCanHaveModBaseAccuracy=True
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True
     bCanHaveModRecoilStrength=True

     AmmoName=Class'DeusEx.RAmmoPlasma'

     ProjectileClass=Class'Game.P_PlasmaBolt'

     ReloadCount=12
     PickupAmmoCount=12
     LowAmmoWaterMark=12

     FireSound=Sound'DeusExSounds.Weapons.PlasmaRifleFire'
     AltFireSound=Sound'DeusExSounds.Weapons.PlasmaRifleReloadEnd'
     CockingSound=Sound'DeusExSounds.Weapons.PlasmaRifleReload'
     SelectSound=Sound'DeusExSounds.Weapons.PlasmaRifleSelect'
     LandSound=Sound'DeusExSounds.Generic.DropLargeWeapon'

     Icon=Texture'DeusExUI.Icons.BeltIconPlasmaRifle'
     largeIcon=Texture'DeusExUI.Icons.LargeIconPlasmaRifle'
     largeIconWidth=203
     largeIconHeight=66
     invSlotsX=4
     invSlotsY=2
     InventoryGroup=119

	 bUseWhileCrouched=False
     bInstantHit=False
     bAutomatic=True
     bOldStyle=True

     GoverningSkill=Class'DeusEx.SkillWeaponHeavy'
     EnviroEffective=ENVEFF_AirVacuum
     AreaOfEffect=AOE_Cone
     bPenetrating=False

     FireOffset=(X=-16.000000,Y=5.000000,Z=11.500000)
     PlayerViewOffset=(X=18.000000,Z=-7.000000)
     PlayerViewMesh=LodMesh'DeusExItems.PlasmaRifle'
     PickupViewMesh=LodMesh'DeusExItems.PlasmaRiflePickup'
     ThirdPersonMesh=LodMesh'DeusExItems.PlasmaRifle3rd'
     Mesh=LodMesh'DeusExItems.PlasmaRiflePickup'
     CollisionRadius=15.600000
     CollisionHeight=5.200000
     Mass=50.000000
}