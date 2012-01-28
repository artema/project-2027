//=======================================================
// ������ - 10��. �������� Ded'�� ��� ���� 2027
// Weapon - 10mm. Copyright (C) 2003 Ded
//=======================================================
class WeaponGlock extends GameWeapon;

simulated function EagleRack()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.DesertEagleRack', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function EagleClipOut()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.DesertEagleClipOut', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function EagleClipIn()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.DesertEagleClipIn', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function EagleUnlock()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.DesertEagleUnlock', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

function rotator CalculateRecoil(float shotState)
{
	local rotator recoil;
	
	shotState = FMin(shotState * 1.5, 1.0);
	
	recoil.Yaw = Cos(PI * 0.5 * shotState) * (15000 - Rand(2000));
	recoil.Pitch = Cos(PI * 0.5 * shotState) * (20000 + Rand(5000));
	
	return recoil;
}

defaultproperties
{
     ShotDamage(0)=23
     ShotDamage(1)=29

     BaseAccuracy=0.5
     MinWeaponAcc=0.25

     ShotTime=0.35
     reloadTime=2.0
     bSemiAutomatic=True
     bAutomatic=False
     bOldStyle=True
     ShootAnimRate=2.5

     ShotUntargeting(0)=0.2
     ShotUntargeting(1)=0.3

     ShotRecoil(0)=0.35
     ShotRecoil(1)=0.45

     ShotShake(0)=300
     ShotShake(1)=350

     maxRange=3200
     AccurateRange=1700

     NoiseVolume(0)=1.8
     NoiseVolume(1)=2.5


     bCanHaveModBaseAccuracy=True
     bCanHaveModReloadCount=True
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True
     bCanHaveModRecoilStrength=True

     AmmoName=Class'DeusEx.RAmmo10mm'
     AmmoNames(0)=Class'DeusEx.RAmmo10mm'
     AmmoNames(1)=Class'DeusEx.RAmmo10mmJHP'

     ReloadCount=7
     PickupAmmoCount=7
     LowAmmoWaterMark=7

     ShotSound(0)=Sound'MP5S.Weapons.DesertEagleFire'
     ShotSound(1)=Sound'MP5S.Weapons.DesertEagleFire'

     Misc1Sound=Sound'MP5S.Weapons.GenericDryfire'

     Icon=Texture'Game.Icons.BeltIconGlock'
     largeIcon=Texture'Game.Icons.LargeIconGlock'
     largeIconWidth=51
     largeIconHeight=32
     InventoryGroup=109

     GoverningSkill=Class'DeusEx.SkillWeaponPistol'

	 LODBias=10.0

     HIResPickupMesh=LodMesh'GameMedia.DesertEaglePickup'
     LOResPickupMesh=LodMesh'GameMedia.DesertEaglePickup'
     HIRes3rdMesh=LodMesh'GameMedia.DesertEagle3rd'
     LORes3rdMesh=LodMesh'GameMedia.DesertEagle3rd'
     PickupViewMesh=LodMesh'GameMedia.DesertEaglePickup'
     ThirdPersonMesh=LodMesh'GameMedia.DesertEagle3rd'
     Mesh=LodMesh'GameMedia.DesertEaglePickup'

     FireOffset=(X=-16.00,Y=5.00,Z=11.50)
     PlayerViewOffset=(X=16.00,Y=-5.00,Z=-11.50)
     PlayerViewMesh=LodMesh'MP5S.eagle1st'

     CollisionRadius=7.000000
     CollisionHeight=1.000000
     Mass=10.000000
     RealMass=1.3
}