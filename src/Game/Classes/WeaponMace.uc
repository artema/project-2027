//=======================================================
// ������ - ������� ������. �������� Ded'�� ��� ���� 2027
// Weapon - Mace. Copyright (C) 2003 Ded
//=======================================================
class WeaponMace extends GameWeapon;

simulated function PlaySelectiveFiring()
{
	LoopAnim('Shoot', ShootAnimRate, 0.10);
}

defaultproperties
{
	 bNewSkin=True
     PlayerViewSkins(0)=Texture'GameMedia.Skins.WeaponNewHands'
     PlayerViewSkins(4)=Texture'GameMedia.Skins.WeaponNewHands'
     
     HitDamage=0

     BaseAccuracy=1.0
     MinWeaponAcc=1.0

     ShotTime=0.08
     reloadTime=4.0

     shakemag=0.000000

     maxRange=100
     AccurateRange=100

     NoiseLevel=0.200000

     AmmoName=Class'DeusEx.RAmmoPepper'

     ProjectileClass=Class'Game.P_TearGas'

     ReloadCount=100
     PickupAmmoCount=100
     LowAmmoWaterMark=50

	 bUseWhileCrouched=False
     bInstantHit=False
     bAutomatic=True
     bOldStyle=True

     FireSound=Sound'DeusExSounds.Weapons.PepperGunFire'

     AltFireSound=Sound'DeusExSounds.Weapons.PepperGunReloadEnd'
     CockingSound=Sound'DeusExSounds.Weapons.PepperGunReload'
     SelectSound=Sound'DeusExSounds.Weapons.PepperGunSelect'

     Icon=Texture'DeusExUI.Icons.BeltIconPepperSpray'
     largeIcon=Texture'DeusExUI.Icons.LargeIconPepperSpray'
     largeIconWidth=46
     largeIconHeight=40
     InventoryGroup=115

     bPenetrating=False
     StunDuration=15.000000
     bHasMuzzleFlash=False

     GoverningSkill=Class'DeusEx.SkillMedicine'

     FireOffset=(X=8.000000,Y=4.000000,Z=14.000000)
     PlayerViewOffset=(X=16.000000,Y=-10.000000,Z=-16.000000)
     PlayerViewMesh=LodMesh'DeusExItems.PepperGun'
     PickupViewMesh=LodMesh'DeusExItems.PepperGunPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.PepperGun3rd'
     Mesh=LodMesh'DeusExItems.PepperGunPickup'
     CollisionRadius=7.000000
     CollisionHeight=1.500000
     Mass=7.000000
     Buoyancy=2.000000
     RealMass=0.3
     
     bHideInfo=True
}