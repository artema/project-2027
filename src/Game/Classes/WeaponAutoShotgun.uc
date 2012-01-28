//=======================================================
// ������ - Jackhammer. �������� Ded'�� ��� ���� 2027
// Weapon - Jackhammer. Copyright (C) 2003 Ded 
// ����� ������/Model created by: dieworld
// Deus Ex: 2027
//=======================================================
class WeaponAutoShotgun extends GameWeapon;

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
	
	recoil.Yaw = Cos(PI * 0.5 * shotState) * (15000 - Rand(5000));
	recoil.Pitch = Cos(PI * 0.5 * shotState) * (17000 + Rand(5000));
	
	return recoil;
}

defaultproperties
{
     ShotDamage(0)=5
     ShotDamage(1)=40

     BaseAccuracy=0.75
     MinWeaponAcc=0.3

     ShotTime=0.3
     reloadTime=2.5

     ShotUntargeting(0)=0.15
     ShotUntargeting(1)=0.15

     ShotRecoil(0)=0.6
     ShotRecoil(1)=0.7

     ShotShake(0)=350
     ShotShake(1)=400

     maxRange=2400
     AccurateRange=1200

     NoiseVolume(0)=2.4
     NoiseVolume(1)=2.4

	 bUseWhileCrouched=False
     bCanHaveModReloadCount=True
     bCanHaveModReloadTime=True
     bCanHaveModRecoilStrength=True

     AmmoName=Class'DeusEx.RAmmoShell'
     AmmoNames(0)=Class'DeusEx.RAmmoShell'
     AmmoNames(1)=Class'DeusEx.RAmmoSabot'

     ReloadCount=10
     PickupAmmoCount=5
     LowAmmoWaterMark=10

     AreaOfEffect=AOE_Cone


     ShotSound(0)=Sound'MP5S.Weapons.SaigaFire'
     ShotSound(1)=Sound'MP5S.Weapons.SaigaFire'

     LandSound=Sound'DeusExSounds.Generic.DropMediumWeapon'

     Icon=Texture'Game.Icons.BeltIconAutoShotgun'
     largeIcon=Texture'Game.Icons.LargeIconAutoShotgun'
     largeIconWidth=158
     largeIconHeight=48
     invSlotsX=4
     InventoryGroup=103

     GoverningSkill=Class'DeusEx.SkillWeaponRifle'

     HIResPickupMesh=LodMesh'GameMedia.SaigaPickup'
     LOResPickupMesh=LodMesh'GameMedia.SaigaPickup'
     HIRes3rdMesh=LodMesh'GameMedia.Saiga3rd'
     LORes3rdMesh=LodMesh'GameMedia.Saiga3rd'
     Mesh=LodMesh'GameMedia.SaigaPickup'
     PickupViewMesh=LodMesh'GameMedia.SaigaPickup'
     ThirdPersonMesh=LodMesh'GameMedia.Saiga3rd'

     FireOffset=(X=-16.000000,Y=5.000000,Z=11.500000)
     PlayerViewOffset=(Y=-10.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'MP5S.saiga1st'

	 LODBias=5.0

     CollisionRadius=15.000000
     CollisionHeight=2.000000
     Mass=30.000000
     RealMass=4.6
}