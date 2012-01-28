//=======================================================
// ������ - Steryl Aug. �������� Ded'�� ��� ���� 2027
// Weapon - Steryl Aug. Copyright (C) 2003 Ded 
// ����� ������/Model created by: dieworld
// Deus Ex: 2027
//=======================================================
class WeaponAug expands GameWeapon;

simulated function M16ClipOut()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.ClipOutM16', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function M16ClipIn()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.ClipInM16', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}


simulated function M16BoltCatch()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.BoltCatchM16', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

function rotator CalculateRecoil(float shotState)
{
	local rotator recoil;
	
	recoil.Yaw = Cos(PI * 0.5 * shotState) * (Rand(20000) - 5000);
	recoil.Pitch = Cos(PI * 0.5 * shotState) * (15000 + Rand(5000));
	
	return recoil;
}

defaultproperties
{
     ShotDamage(0)=29
     ShotDamage(1)=35

     BaseAccuracy=0.55
     MinWeaponAcc=0.1

     ShotTime=0.2
     reloadTime=2.5

     ShotUntargeting(0)=0.35
     ShotUntargeting(1)=0.45
     ShotUntargeting(2)=0.50

     ShotRecoil(0)=0.8
     ShotRecoil(1)=0.9
     ShotRecoil(2)=0.6

     ShotShake(0)=400
     ShotShake(1)=500
     ShotShake(2)=500

     maxRange=9400
     AccurateRange=8500

     NoiseVolume(0)=2.7
     NoiseVolume(1)=3.4
	 NoiseVolume(2)=1.2

	 bUseWhileCrouched=False
     bCanHaveLaser=True
     bCanHaveModBaseAccuracy=True
     bCanHaveModReloadCount=True
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True
     bCanHaveModRecoilStrength=True

     AmmoName=Class'DeusEx.RAmmo762mm'
     AmmoNames(0)=Class'DeusEx.RAmmo762mm'
     AmmoNames(1)=Class'DeusEx.RAmmo762mmB'

     ReloadCount=30
     PickupAmmoCount=30
     LowAmmoWaterMark=30

     ShotSound(0)=Sound'GameMedia.Weapons.AugFire'
     ShotSound(1)=Sound'GameMedia.Weapons.AugFire'

     SelectSound=Sound'MP5S.Weapons.DeployM16'

     LandSound=Sound'DeusExSounds.Generic.DropMediumWeapon'
     Icon=Texture'Game.Icons.BeltIconAug'
     largeIcon=Texture'Game.Icons.LargeIconAug'
     largeIconWidth=151
     largeIconHeight=55
     invSlotsX=4
     InventoryGroup=102

     GoverningSkill=Class'DeusEx.SkillWeaponRifle'

     Mesh=LodMesh'MP5S.m16pickup'
     PickupViewMesh=LodMesh'MP5S.m16pickup'
     ThirdPersonMesh=LodMesh'MP5S.m163rd'

     FireOffset=(X=-16.00,Y=5.00,Z=11.50)
     PlayerViewOffset=(X=16.00,Y=-5.00,Z=-11.50)
     PlayerViewMesh=LodMesh'MP5S.m161st'

     CollisionRadius=19.000000
     CollisionHeight=1.10
     Mass=30.000000
     RealMass=3.6
}