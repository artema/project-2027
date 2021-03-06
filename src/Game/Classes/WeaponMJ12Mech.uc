//=============================================================================
// WeaponMJ12Commando.
//=============================================================================
class WeaponMJ12Mech extends WeaponNPCRange;

function Fire(float Value)
{
	PlayerViewOffset.Y = -PlayerViewOffset.Y;
	Super.Fire(Value);
}

defaultproperties
{
     ShotTime=0.200000
     reloadTime=1.000000
     HitDamage=15
     BaseAccuracy=0.400000
     bHasMuzzleFlash=True
     AmmoName=Class'DeusEx.RAmmo556mm'
     PickupAmmoCount=50
     bInstantHit=True
     FireSound=Sound'DeusExSounds.Robot.RobotFireGun'
     CockingSound=Sound'DeusExSounds.Weapons.AssaultGunReload'
     SelectSound=Sound'DeusExSounds.Weapons.AssaultGunSelect'
     PlayerViewOffset=(Y=-24.000000,Z=-12.000000)
}
