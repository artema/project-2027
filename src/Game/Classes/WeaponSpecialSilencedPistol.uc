//=======================================================
// ������ - ��������� ��������. �������� Ded'�� ��� ���� 2027
// Weapon - Stealth Pistol. Copyright (C) 2003 Ded
// ������ ��� ������ - ������ ��� NPC!
// ����� ������/Model created by: Kelkos
// Deus Ex: 2027
//=======================================================
class WeaponSpecialSilencedPistol extends WeaponSilencedPistol;

defaultproperties
{
     AIMaxRange=500.0
     
     bIsUniqueWeapon=True
	 bCannotBePickedUp=True
	 
     ShotDamage(0)=40
     ShotDamage(1)=50

     HIRes3rdMesh=LodMesh'GameMedia.1911ColtVladimir3rd'
     LORes3rdMesh=LodMesh'GameMedia.1911ColtVladimir3rd'
     
     NoiseLevel=0.300000
     ShotTime=0.25
     reloadTime=0.50000
     HitDamage=40
     
     maxRange=3000
     AccurateRange=3000
     BaseAccuracy=0.000000

     bHasMuzzleFlash=False
     recoilStrength=0.100000

     ReloadCount=12
     PickupAmmoCount=12
     
     FireSound=Sound'GameMedia.Weapons.SilencedFire2'
     AltFireSound=Sound'DeusExSounds.Weapons.StealthPistolReloadEnd'
     CockingSound=Sound'DeusExSounds.Weapons.StealthPistolReload'
     SelectSound=Sound'DeusExSounds.Weapons.StealthPistolSelect'
     
     ShotSound(0)=Sound'GameMedia.Weapons.SilencedFire2'
     ShotSound(1)=Sound'GameMedia.Weapons.SilencedFire2'
     
     InventoryGroup=130
     
     HIResPickupMesh=LodMesh'GameMedia.1911ColtPickup'
     LOResPickupMesh=LodMesh'GameMedia.1911ColtPickup'
     HIRes3rdMesh=LodMesh'GameMedia.1911ColtVladimir3rd'
     LORes3rdMesh=LodMesh'GameMedia.1911ColtVladimir3rd'
     PickupViewMesh=LodMesh'GameMedia.1911ColtPickup'
     Mesh=LodMesh'GameMedia.1911ColtPickup'
     
     ThirdPersonMesh=LodMesh'GameMedia.1911ColtVladimir3rd'
     
     Mesh=LodMesh'GameMedia.Col1911Pickup
     CollisionRadius=8.000000
     CollisionHeight=0.800000
}