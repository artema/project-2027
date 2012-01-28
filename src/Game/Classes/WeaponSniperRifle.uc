//=======================================================
// ������ - ����������� ��������. �������� Ded'�� ��� ���� 2027
// Weapon - Sniper Rifle. Copyright (C) 2003 Ded
//=======================================================
class WeaponSniperRifle extends ZoomWeapon;

simulated function AWPClipOut()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.AWPClipOut', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function AWPClipIn()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.AWPClipIn', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function AWPBoltPull()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.AWPBoltPull', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function AWPBoltDown()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.AWPBoltDown', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function AWPBoltUp()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.AWPBoltUp', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

function rotator CalculateRecoil(float shotState)
{
	local rotator recoil;
	
	shotState = FMin(shotState * 1.5, 1.0);
	
	recoil.Yaw = Cos(PI * 0.5 * shotState) * (10000 - Rand(5000));
	recoil.Pitch = Cos(PI * 0.5 * shotState) * (17000 + Rand(4000));
	
	return recoil;
}

defaultproperties
{
     ShotDamage(0)=50
     ShotDamage(1)=65

     BaseAccuracy=0.5

     ShotTime=1.5
     reloadTime=2.0

     ShotUntargeting(0)=0.5
     ShotUntargeting(1)=0.7

     ShotRecoil(0)=0.4
     ShotRecoil(1)=0.5

     ShotShake(0)=300
     ShotShake(1)=400

     maxRange=48000
     AccurateRange=28800

     NoiseVolume(0)=4.0
     NoiseVolume(1)=5.0
     NoiseVolumeSilenced(0)=0.7
     NoiseVolumeSilenced(1)=1.0

     bCanHaveLaser=True
     bCanHaveModBaseAccuracy=True
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True
     bCanHaveModRecoilStrength=True
     bCanHaveSilencer=True
     bCanHaveScope=True
     bHasScope=True

     AmmoName=Class'DeusEx.RAmmo3006'
     AmmoNames(0)=Class'DeusEx.RAmmo3006'
     AmmoNames(1)=Class'DeusEx.RAmmo3006Ultra'

     ReloadCount=4
     PickupAmmoCount=4
     LowAmmoWaterMark=2

     ScopeMin=25
     bHasMuzzleFlash=False
     bUseWhileCrouched=False

     ShotSound(0)=Sound'GameMedia.Weapons.SniperFire'
     ShotSound(1)=Sound'MP5S.Weapons.AWPFire'
     ShotSoundSilenced(0)=Sound'Game.Weapons.SniperFire2'
     ShotSoundSilenced(1)=Sound'Game.Weapons.SniperFire2'

     LandSound=Sound'DeusExSounds.Generic.DropMediumWeapon'
     Misc1Sound=Sound'MP5S.Weapons.GenericDryfire'

     Icon=Texture'Game.Icons.BeltIconSniper'
     largeIcon=Texture'Game.Icons.LargeIconSniper'
     largeIconWidth=210
     largeIconHeight=50
     invSlotsX=4
     InventoryGroup=137

     GoverningSkill=Class'DeusEx.SkillWeaponRifle'

     HIResPickupMesh=LodMesh'GameMedia.AWPPickup'
     LOResPickupMesh=LodMesh'GameMedia.AWPPickup'
     HIRes3rdMesh=LodMesh'GameMedia.AWP3rd'
     LORes3rdMesh=LodMesh'GameMedia.AWP3rd'
     Mesh=LodMesh'GameMedia.AWPPickup'
     PickupViewMesh=LodMesh'GameMedia.AWPPickup'
     ThirdPersonMesh=LodMesh'GameMedia.AWP3rd'

     FireOffset=(X=-16.00,Y=5.00,Z=11.50)
     PlayerViewOffset=(X=16.00,Y=-5.00,Z=-11.50)
     PlayerViewMesh=LodMesh'MP5S.awp1st'
     Texture=Texture'DeusExItems.Skins.ReflectionMapTex1'

     CollisionRadius=18.000000
     CollisionHeight=1.30
     Mass=30.000000
     RealMass=4.5
}