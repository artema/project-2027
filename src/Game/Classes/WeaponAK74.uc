//=======================================================
// ������ - AK-74. �������� Ded'�� ��� ���� 2027
// Weapon - AK-74. Copyright (C) 2003 Ded 
// ����� ������/Model created by: Kelkos
// Deus Ex: 2027
//=======================================================
class WeaponAK74 expands ZoomWeapon;

simulated function AK74MagOut()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.AK47MagOut', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function AK74MagIn()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.AK47MagIn', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function AK74MagTap()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.AK47MagTap', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function AK74BoltPull()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.AK47BoltPull', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function AK74BoltBack()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.DesertEagleUnlock', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

function rotator CalculateRecoil(float shotState)
{
	local rotator recoil;
	
	recoil.Yaw = Sin(PI * 0.5 * shotState) * (Rand(20000));
	recoil.Pitch = Cos(PI * 0.5 * shotState) * (17000 + Rand(9000));
	
	return recoil;
}

defaultproperties
{
     ShotDamage(0)=22
     ShotDamage(1)=27

     BaseAccuracy=0.65
     MinWeaponAcc=0.15

     ShotTime=0.125
     reloadTime=2.5

     ShotUntargeting(0)=0.2
     ShotUntargeting(1)=0.3

     ShotRecoil(0)=0.7
     ShotRecoil(1)=0.8

     ShotShake(0)=400
     ShotShake(1)=500

     maxRange=6500
     AccurateRange=2000

     NoiseVolume(0)=3.0
     NoiseVolume(1)=3.7

	 bUseWhileCrouched=False
     bCanHaveLaser=True
     bCanHaveModBaseAccuracy=True
     bCanHaveModReloadCount=True
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True
     bCanHaveModRecoilStrength=True
     
     bCanHaveScope=False
	 bHasScope=False

     AmmoName=Class'DeusEx.RAmmo762mm'
     AmmoNames(0)=Class'DeusEx.RAmmo762mm'
     AmmoNames(1)=Class'DeusEx.RAmmo762mmB'

     ReloadCount=30
     PickupAmmoCount=0
     LowAmmoWaterMark=30

     ShotSound(0)=Sound'MP5S.Weapons.AK47Fire'
     ShotSound(1)=Sound'MP5S.Weapons.AK47Fire'

     SelectSound=Sound'MP5S.Weapons.SafetyOff'

     Icon=Texture'Game.Icons.BeltIconAK'
     largeIcon=Texture'Game.Icons.LargeIconAK'
     largeIconWidth=159
     largeIconHeight=51
     invSlotsX=4
     InventoryGroup=100

     GoverningSkill=Class'DeusEx.SkillWeaponRifle'

     PlusPickupMesh=LodMesh'GameMedia.AK74Pickup'
     Plus3rdMesh=LodMesh'GameMedia.AK743rd'
     HIResPickupMesh=LodMesh'GameMedia.AK74Pickup'
     LOResPickupMesh=LodMesh'GameMedia.AK74PickupL'
     HIRes3rdMesh=LodMesh'GameMedia.AK743rd'
     LORes3rdMesh=LodMesh'GameMedia.AK743rdL'
     Mesh=LodMesh'GameMedia.AK74Pickup'
     PickupViewMesh=LodMesh'GameMedia.AK74Pickup'
     ThirdPersonMesh=LodMesh'GameMedia.AK743rd'

     FireOffset=(X=-16.00,Y=5.00,Z=11.50)
     PlayerViewOffset=(X=16.00,Y=-5.00,Z=-11.50)
     PlayerViewMesh=LodMesh'MP5S.avtomat1st'
     Texture=Texture'MP5S.ShininessTex2'
     MuzzleMaterial=2

     CollisionRadius=15.000000
     CollisionHeight=1.10
     Mass=30.000000
     RealMass=3.5
     LandSound=Sound'DeusExSounds.Generic.DropMediumWeapon'
}