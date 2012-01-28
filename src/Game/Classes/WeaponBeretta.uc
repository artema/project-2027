//=======================================================
// ������ - ����� 2011. �������� Ded'�� ��� ���� 2027
// Weapon - Colt 2011. Copyright (C) 2003 Ded
// ����� ������/Model created by: Kelkos
// Deus Ex: 2027
//=======================================================
class WeaponBeretta extends GameWeapon;

simulated function FiveSevenSelectSound()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.FiveSevenSelect', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function FiveSevenClipOut()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.FiveSevenReloadBegin', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function FiveSevenClipIn()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.FiveSevenReloadEnd', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function FiveSevenRelease()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.FiveSevenRelease', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

function rotator CalculateRecoil(float shotState)
{
	local rotator recoil;
	
	shotState = FMin(shotState * 1.2, 1.0);
	
	recoil.Yaw = Sin(PI * 0.5 * shotState) * (18000 - Rand(10000));
	recoil.Pitch = Cos(PI * 0.5 * shotState) * (13000 + Rand(3000));
	
	return recoil;
}

defaultproperties
{
     ShotDamage(0)=16
     ShotDamage(1)=22

     BaseAccuracy=0.5
     MinWeaponAcc=0.2

     ShotTime=0.2
     reloadTime=2.0
     bSemiAutomatic=True
     bAutomatic=False
     bOldStyle=True
     ShootAnimRate=2.0

     ShotUntargeting(0)=0.15
     ShotUntargeting(1)=0.25

     ShotRecoil(0)=0.3
     ShotRecoil(1)=0.4

     ShotShake(0)=250
     ShotShake(1)=350

     maxRange=3000
     AccurateRange=1200

     NoiseVolume(0)=1.5
     NoiseVolume(1)=2.2

     bCanHaveLaser=True
     bCanHaveModBaseAccuracy=True
     bCanHaveModReloadCount=True
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True
     bCanHaveModRecoilStrength=True

     AmmoName=Class'DeusEx.RAmmo10mm'
     AmmoNames(0)=Class'DeusEx.RAmmo10mm'
     AmmoNames(1)=Class'DeusEx.RAmmo10mmJHP'

     ReloadCount=10
     PickupAmmoCount=10
     LowAmmoWaterMark=10

     ShotSound(0)=Sound'MP5S.Weapons.FiveSevenFire'
     ShotSound(1)=Sound'MP5S.Weapons.FiveSevenFire'

     Misc1Sound=Sound'MP5S.Weapons.GenericDryfire'

     Icon=Texture'Game.Icons.BeltIconBeretta'
     largeIcon=Texture'Game.Icons.LargeIconBeretta'
     largeIconWidth=52
     largeIconHeight=37
     InventoryGroup=104

     GoverningSkill=Class'DeusEx.SkillWeaponPistol'

     HIResPickupMesh=LodMesh'GameMedia.FiveSevenPickup'
     LOResPickupMesh=LodMesh'GameMedia.FiveSevenPickup'
     HIRes3rdMesh=LodMesh'GameMedia.FiveSeven3rd'
     LORes3rdMesh=LodMesh'GameMedia.FiveSeven3rd'
     PickupViewMesh=LodMesh'GameMedia.FiveSevenPickup'
     ThirdPersonMesh=LodMesh'GameMedia.FiveSeven3rd'
     Mesh=LodMesh'GameMedia.FiveSevenPickup'

     FireOffset=(X=-16.00,Y=5.00,Z=11.50)
     PlayerViewOffset=(X=16.00,Y=-5.00,Z=-11.50)
     PlayerViewMesh=LodMesh'MP5S.fiveseven1st'     

	 LODBias=5.0

     Mass=10.000000
     CollisionRadius=7.000000
     CollisionHeight=0.800000
     RealMass=1.1
}