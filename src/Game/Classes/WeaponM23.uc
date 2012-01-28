//=======================================================
// ������ - M-23. �������� Ded'�� ��� ���� 2027
// Weapon - M-23. Copyright (C) 2003 Ded
//=======================================================
class WeaponM23 extends GameWeapon;

simulated function MP5KSafety()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.MP5KDraw', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function MP5KBoltPull()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.MP5KBoltPull', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function MP5KBoltSlap()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.MP5KBoltSlap', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function MP5KClipOut()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.MP5KClipOut', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function MP5KClipIn()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.MP5KClipIn', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

function rotator CalculateRecoil(float shotState)
{
	local rotator recoil;
	
	recoil.Yaw = Cos(PI * 0.5 * shotState) * (Rand(40000) - 20000);
	recoil.Pitch = Cos(PI * 0.5 * shotState) * (11000 + Rand(9000));
	
	return recoil;
}

defaultproperties
{
     ShotDamage(0)=12
     ShotDamage(1)=17

     BaseAccuracy=0.65
     MinWeaponAcc=0.2

     ShotTime=0.07
     reloadTime=1.2

     ShotUntargeting(0)=0.15
     ShotUntargeting(1)=0.20

     ShotRecoil(0)=0.5
     ShotRecoil(1)=0.6

     ShotShake(0)=300
     ShotShake(1)=500

     maxRange=3500
     AccurateRange=1500

     NoiseVolume(0)=1.7
     NoiseVolume(1)=2.4
     NoiseVolumeSilenced(0)=0.6
     NoiseVolumeSilenced(1)=1.1

     bCanHaveLaser=True
     bCanHaveModBaseAccuracy=True
     bCanHaveModReloadCount=True
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True
     bCanHaveModRecoilStrength=True

     AmmoName=Class'DeusEx.RAmmo556mm'
     AmmoNames(0)=Class'DeusEx.RAmmo556mm'
     AmmoNames(1)=Class'DeusEx.RAmmo556mmJHP'

     ReloadCount=30
     PickupAmmoCount=0
     LowAmmoWaterMark=30

     ShotSound(0)=Sound'MP5S.Weapons.MP5KFire'
     ShotSound(1)=Sound'MP5S.Weapons.MP5KFire'
     ShotSoundSilenced(0)=Sound'GameMedia.Weapons.M23FireSil'
     ShotSoundSilenced(1)=Sound'GameMedia.Weapons.M23FireSil'

     LandSound=Sound'DeusExSounds.Generic.DropMediumWeapon'

     Icon=Texture'Game.Icons.BeltIconM23'
     largeIcon=Texture'Game.Icons.LargeIconM23'
     largeIconWidth=69
     largeIconHeight=55
     invSlotsX=2
     invSlotsY=2
     InventoryGroup=114

     GoverningSkill=Class'DeusEx.SkillWeaponPistol'

     HIResPickupMesh=LodMesh'GameMedia.MP5KPickup'
     LOResPickupMesh=LodMesh'GameMedia.MP5KPickup'
     HIRes3rdMesh=LodMesh'GameMedia.MP5K3rd'
     LORes3rdMesh=LodMesh'GameMedia.MP5K3rd'

     FireOffset=(X=-16.00,Y=5.00,Z=11.50)
     PlayerViewOffset=(X=16.00,Y=-5.00,Z=-11.50)
     PlayerViewMesh=LodMesh'MP5S.mp5k1st'
     PickupViewMesh=LodMesh'GameMedia.MP5KPickup'
     ThirdPersonMesh=LodMesh'GameMedia.MP5K3rd'
     Mesh=LodMesh'GameMedia.MP5KPickup'

	 LODBias=5.0

     CollisionRadius=15.000000
     CollisionHeight=1.100000
     Mass=12.000000
     RealMass=2.8
}