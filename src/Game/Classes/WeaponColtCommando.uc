//=======================================================
// ������ - Colt Commando. �������� Ded'�� ��� ���� 2027
// Weapon - Colt Commando. Copyright (C) 2003 Ded 
// ����� ������/Model created by: dieworld
// Deus Ex: 2027
//=======================================================
class WeaponColtCommando expands GameWeapon;

simulated function M4A1SilencerOn()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.M4A1SilencerOnSound', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function M4A1ClipOut()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.M4A1ClipOutSound', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function M4A1ClipIn()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.M4A1ClipInSound', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier() * GetReloadingAnimRate()); 
}

function rotator CalculateRecoil(float shotState)
{
	local rotator recoil;
	
	recoil.Yaw = Cos(PI * 0.5 * shotState) * (Rand(20000) - 10000);
	recoil.Pitch = Cos(PI * 0.5 * shotState) * (23000 + Rand(4000));
	
	return recoil;
}

defaultproperties
{
     ShotDamage(0)=20
     ShotDamage(1)=25

     BaseAccuracy=0.55
     MinWeaponAcc=0.1

     ShotTime=0.11
     reloadTime=2.5

     ShotUntargeting(0)=0.15
     ShotUntargeting(1)=0.25

     ShotRecoil(0)=0.6
     ShotRecoil(1)=0.7

     ShotShake(0)=350
     ShotShake(1)=450

     maxRange=6400
     AccurateRange=3200

     NoiseVolume(0)=3.0
     NoiseVolume(1)=3.7

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
     PickupAmmoCount=0
     LowAmmoWaterMark=30

     ShotSound(0)=Sound'GameMedia.Weapons.ColtFire'
     ShotSound(1)=Sound'GameMedia.Weapons.ColtFire'

     SelectSound=Sound'MP5S.Weapons.SafetyOff'
     LandSound=Sound'DeusExSounds.Generic.DropMediumWeapon'

     Icon=Texture'Game.Icons.BeltIconColt'
     largeIcon=Texture'Game.Icons.LargeIconColt'
     largeIconWidth=172
     largeIconHeight=53
     invSlotsX=4
     InventoryGroup=106

     GoverningSkill=Class'DeusEx.SkillWeaponRifle'

	 HIResPickupMesh=LodMesh'GameMedia.ColtCommandoPickup'
     LOResPickupMesh=LodMesh'GameMedia.ColtCommandoPickup'
     HIRes3rdMesh=LodMesh'GameMedia.ColtCommando3rd'
     LORes3rdMesh=LodMesh'GameMedia.ColtCommando3rd'
     Mesh=LodMesh'GameMedia.ColtCommandoPickup'
     PickupViewMesh=LodMesh'GameMedia.ColtCommandoPickup'
     ThirdPersonMesh=LodMesh'GameMedia.ColtCommando3rd'

     FireOffset=(X=-16.00,Y=5.00,Z=11.50)
     PlayerViewOffset=(X=16.00,Y=-5.00,Z=-11.50)
     PlayerViewMesh=LodMesh'MP5S.m4a1u1st'

	 LODBias=5.0

     CollisionRadius=15.000000
     CollisionHeight=1.10
     Mass=30.000000
     RealMass=3.5
}