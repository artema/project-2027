//=======================================================
// ������ - M-23. �������� Ded'�� ��� ���� 2027
// Weapon - M-23. Copyright (C) 2003 Ded
//=======================================================
class WeaponSpecialM23 extends WeaponM23;

simulated function MAC10BoltPull()
{
      Owner.PlaySound(Sound'MP5S.MAC10Bolt', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function MAC10ClipOut()
{
      Owner.PlaySound(Sound'MP5S.MAC10MagOut', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function MAC10ClipIn()
{
      Owner.PlaySound(Sound'MP5S.MAC10MagIn', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

function rotator CalculateRecoil(float shotState)
{
	local rotator recoil;
	
	recoil.Yaw = Cos(PI * 0.5 * shotState) * (Rand(40000) - 10000);
	recoil.Pitch = Cos(PI * 0.5 * shotState) * (14000 + Rand(9000));
	
	return recoil;
}

defaultproperties
{
	 bIsUniqueWeapon=True
	  
	 bHasMuzzleFlash=False
	 
	 ShotSound(0)=Sound'MP5S.Weapons.MAC10Fire'
     ShotSound(1)=Sound'MP5S.Weapons.MAC10Fire'
	 
	 PlayerViewOffset=(X=16.00,Y=-5.00,Z=-11.50),
     PlayerViewMesh=LodMesh'MP5S.mac101st'
	 
	 HIResPickupMesh=LodMesh'GameMedia.UziPickup'
     LOResPickupMesh=LodMesh'GameMedia.UziPickup'
     HIRes3rdMesh=LodMesh'GameMedia.Uzi3rd'
     LORes3rdMesh=LodMesh'GameMedia.Uzi3rd'
     
     PickupViewMesh=LodMesh'GameMedia.UziPickup'
     ThirdPersonMesh=LodMesh'GameMedia.Uzi3rd'
     Mesh=LodMesh'GameMedia.UziPickup'
     
     LODBias=5.0
	 
	 BaseAccuracy=0.8
     MinWeaponAcc=0.3
     
     ReloadCount=32
     PickupAmmoCount=32
     LowAmmoWaterMark=32
     
     Icon=Texture'Game.Icons.BeltIconM23S'
     largeIcon=Texture'Game.Icons.LargeIconM23S'
     largeIconWidth=89
     largeIconHeight=59
	 
	 AccurateRange=1000
	 
	 InventoryGroup=11488

     NoiseVolume(0)=0.4
     NoiseVolume(1)=0.8
}