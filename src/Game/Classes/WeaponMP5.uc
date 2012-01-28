//=======================================================
// ������ - MP5-SD. �������� Ded'�� ��� ���� 2027
// Weapon - MP5-SD. Copyright (C) 2003 Ded 
// ����� ������/Model created by: Kelkos
// Deus Ex: 2027
//=======================================================
class WeaponMP5 expands GameWeapon;

simulated function MP5StockPull()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.MP5A1Draw', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function MP5BoltPull()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.MP5A1BoltPull', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function MP5BoltSlap()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.MP5A1BoltSlap', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function MP5ClipOut()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.MP5A1ClipOut', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function MP5ClipIn()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.MP5A1ClipIn', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

function rotator CalculateRecoil(float shotState)
{
	local rotator recoil;
	
	recoil.Yaw = Cos(PI * 0.5 * shotState) * (Rand(30000) - 15000);
	recoil.Pitch = Cos(PI * 0.5 * shotState) * (15000 + Rand(9000));
	
	return recoil;
}

defaultproperties
{
     ShotDamage(0)=13
     ShotDamage(1)=18

     BaseAccuracy=0.6
     MinWeaponAcc=0.15

     ShotTime=0.08
     reloadTime=1.75

     ShotUntargeting(0)=0.125
     ShotUntargeting(1)=0.175

     ShotRecoil(0)=0.45
     ShotRecoil(1)=0.55

     ShotShake(0)=200
     ShotShake(1)=500

     maxRange=3700
     AccurateRange=2000

     NoiseVolume(0)=1.5
     NoiseVolume(1)=2.0
     NoiseVolumeSilenced(0)=0.7
     NoiseVolumeSilenced(1)=1.0

	 bUseWhileCrouched=False
     bCanHaveLaser=True
     bCanHaveModBaseAccuracy=True
     bCanHaveModReloadCount=True
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True
     bCanHaveModRecoilStrength=True
     bCanHaveSilencer=True

     AmmoName=Class'DeusEx.RAmmo556mm'
     AmmoNames(0)=Class'DeusEx.RAmmo556mm'
     AmmoNames(1)=Class'DeusEx.RAmmo556mmJHP'

     ReloadCount=30
     PickupAmmoCount=0
     LowAmmoWaterMark=30

     ShotSound(0)=Sound'MP5S.Weapons.MP5A1Fire'
     ShotSound(1)=Sound'MP5S.Weapons.MP5A1Fire'
     ShotSoundSilenced(0)=Sound'GameMedia.Weapons.MP5FireSil'
     ShotSoundSilenced(1)=Sound'GameMedia.Weapons.MP5FireSil'

     Icon=Texture'Game.Icons.BeltIconMP5'
     largeIcon=Texture'Game.Icons.LargeIconMP5'
     largeIconWidth=97
     largeIconHeight=52
     invSlotsX=2
     invSlotsY=2
     InventoryGroup=116

     GoverningSkill=Class'DeusEx.SkillWeaponPistol'

     HIResPickupMesh=LodMesh'GameMedia.MP5Pickup'
     LOResPickupMesh=LodMesh'GameMedia.MP5PickupL'
     HIRes3rdMesh=LodMesh'GameMedia.MP53rd'
     LORes3rdMesh=LodMesh'GameMedia.MP53rdL'

     PlayerViewOffset=(X=16.00,Y=-5.00,Z=-11.50)
     FireOffset=(X=-16.00,Y=5.00,Z=11.50)
     PlayerViewMesh=LodMesh'MP5S.mp51st'
     PickupViewMesh=LodMesh'GameMedia.MP5Pickup'
     ThirdPersonMesh=LodMesh'GameMedia.MP53rd'
     Mesh=LodMesh'GameMedia.MP5Pickup'

     CollisionRadius=15.000000
     CollisionHeight=1.10
     Mass=30.000000
     RealMass=2.0
}