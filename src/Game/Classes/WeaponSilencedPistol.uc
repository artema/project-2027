//=======================================================
// ������ - ��������� ��������. �������� Ded'�� ��� ���� 2027
// Weapon - Stealth Pistol. Copyright (C) 2003 Ded
// ����� ������/Model created by: Kelkos
// Deus Ex: 2027
//=======================================================
class WeaponSilencedPistol extends GameWeapon;

simulated function PlayFiringSound()
{
	PlaySimSound(FireSound, SLOT_None, TransientSoundVolume, 2048);
}

simulated function GlockDraw()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.Glock18SlideRack', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function GlockSpin()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.Glock18Spin', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function Glock18ClipOut()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.Glock18ClipOut', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function Glock18ClipIn()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.USPLamClipIn', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}


simulated function Glock18SlideRelease()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.Glock18SlideRelease', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

function rotator CalculateRecoil(float shotState)
{
	local rotator recoil;
	
	shotState = FMin(shotState * 1.2, 1.0);
	
	recoil.Yaw = Cos(PI * 0.5 * shotState) * (18000 - Rand(10000));
	recoil.Pitch = Cos(PI * 0.5 * shotState) * (8000 + Rand(3000));
	
	return recoil;
}

defaultproperties
{
     ShotDamage(0)=15
     ShotDamage(1)=21

     BaseAccuracy=0.5
     MinWeaponAcc=0.12

     ShotTime=0.25
     reloadTime=2.0
     bSemiAutomatic=True
     bAutomatic=False
     bOldStyle=True
     ShootAnimRate=1.5

     ShotUntargeting(0)=0.15
     ShotUntargeting(1)=0.25

     ShotRecoil(0)=0.3
     ShotRecoil(1)=0.4

     ShotShake(0)=200
     ShotShake(1)=300

     maxRange=2500
     AccurateRange=1500

     NoiseVolume(0)=0.3
     NoiseVolume(1)=0.7


     bCanHaveLaser=True
     bCanHaveModBaseAccuracy=True
     bCanHaveModReloadCount=True
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True
     bCanHaveModRecoilStrength=True
     bCanHaveSilencer=True

     AmmoName=Class'DeusEx.RAmmo10mm'
     AmmoNames(0)=Class'DeusEx.RAmmo10mm'
     AmmoNames(1)=Class'DeusEx.RAmmo10mmJHP'

     ReloadCount=10
     PickupAmmoCount=10
     LowAmmoWaterMark=10

     ShotSound(0)=Sound'GameMedia.Weapons.SilencedFire2'
     ShotSound(1)=Sound'GameMedia.Weapons.SilencedFire2'

     Misc1Sound=Sound'MP5S.Weapons.GenericDryfire'

     bCanHaveLaser=True
     bCanHaveModBaseAccuracy=True
     bCanHaveModReloadCount=True
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True

     bHasMuzzleflash=False

     Icon=Texture'Game.Icons.BeltIconSilencedPistol'
     largeIcon=Texture'Game.Icons.LargeIconSilencedPistol'
     largeIconWidth=49
     largeIconHeight=35
     InventoryGroup=130

     GoverningSkill=Class'DeusEx.SkillWeaponPistol'

     LODBias=10.0

     HIResPickupMesh=LodMesh'GameMedia.SilencedPistolPickup'
     LOResPickupMesh=LodMesh'GameMedia.SilencedPistolPickup'
     HIRes3rdMesh=LodMesh'GameMedia.SilencedPistol3rd'
     LORes3rdMesh=LodMesh'GameMedia.SilencedPistol3rd'
     PickupViewMesh=LodMesh'GameMedia.SilencedPistolPickup'
     ThirdPersonMesh=LodMesh'GameMedia.SilencedPistol3rd'
     Mesh=LodMesh'GameMedia.SilencedPistolPickup'

     FireOffset=(X=-16.00,Y=5.00,Z=11.50)
     PlayerViewOffset=(X=16.00,Y=-5.00,Z=-11.50)
     PlayerViewMesh=LodMesh'MP5S.glockwhite1st'

     Mass=5.000000
     CollisionRadius=7.000000
     CollisionHeight=0.800000
     RealMass=0.9
}