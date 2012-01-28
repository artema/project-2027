//=======================================================
// ������ - �������. �������� Ded'�� ��� ���� 2027
// Weapon - FlameThrower. Copyright (C) 2003 Ded
//=======================================================
class WeaponBotFire extends WeaponNPC;

simulated function Vector ComputeProjectileStart(Vector X, Vector Y, Vector Z)
{
	PlayerViewOffset.Y = -PlayerViewOffset.Y;
	return Super.ComputeProjectileStart(x, Y, Z);
}

defaultproperties
{
     LowAmmoWaterMark=50
     GoverningSkill=Class'DeusEx.SkillWeaponHeavy'
     EnviroEffective=ENVEFF_Air
     NoiseLevel=0.600000
     bInstantHit=False
     bAutomatic=True
     bOldStyle=True
     ShotTime=0.05
     reloadTime=2.0
     HitDamage=2
     maxRange=550
     AccurateRange=450
     BaseAccuracy=0.900000
     bHasMuzzleFlash=False
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True
     AmmoName=Class'DeusEx.RAmmoGas'
     ReloadCount=100
     PickupAmmoCount=100
     ProjectileClass=Class'Game.P_Fireball'
     FireOffset=(Y=0.000000,Z=0.000000)
     shakemag=10.000000
     FireSound=Sound'DeusExSounds.Weapons.FlamethrowerFire'
     AltFireSound=Sound'DeusExSounds.Weapons.AssaultGunReloadEnd'
     CockingSound=Sound'DeusExSounds.Weapons.AssaultGunReload'
     SelectSound=Sound'DeusExSounds.Weapons.AssaultGunSelect'
     InventoryGroup=105
     PlayerViewOffset=(X=20.000000,Y=-14.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Flamethrower'
     PickupViewMesh=LodMesh'DeusExItems.FlamethrowerPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.Flamethrower3rd'
     LandSound=Sound'DeusExSounds.Generic.DropLargeWeapon'
     Icon=Texture'DeusExUI.Icons.BeltIconFlamethrower'
     largeIcon=Texture'DeusExUI.Icons.LargeIconFlamethrower'
     largeIconWidth=203
     largeIconHeight=69
     invSlotsX=4
     invSlotsY=2
     Mesh=LodMesh'DeusExItems.FlamethrowerPickup'
     CollisionRadius=20.500000
     CollisionHeight=4.400000
     Mass=40.000000
}
