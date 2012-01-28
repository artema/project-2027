//=======================================================
// ������ - ���� �������. �������� Ded'�� ��� ���� 2027
// Weapon - Mini crossbow. Copyright (C) 2003 Ded
//=======================================================
class WeaponMinibotCrossbow extends WeaponNPCRange;

function name WeaponDamageType()
{
	return 'Poison';
}

function Fire(float Value)
{
	PlayerViewOffset.Y = -PlayerViewOffset.Y;
	Super.Fire(Value);
}

defaultproperties
{
	 HitDamage=8
	
     BaseAccuracy=0.75
     
     ShotTime=1.8
     reloadTime=2.0
     
     AIMinRange=180
     AITimeLimit=10.0

     maxRange=1500
     AccurateRange=800

     AmmoName=Class'RAmmoDart'

     ProjectileClass=Class'P_BotDart'

     StunDuration=10.000000
     bHasMuzzleFlash=False
     bInstantHit=False
     bAutomatic=False
     bOldStyle=True

     ReloadCount=2
     PickupAmmoCount=4
     LowAmmoWaterMark=4

     FireSound=Sound'DeusExSounds.Weapons.MiniCrossbowFire'
     AltFireSound=Sound'DeusExSounds.Weapons.MiniCrossbowReloadEnd'
     CockingSound=Sound'DeusExSounds.Weapons.MiniCrossbowReload'

     FireOffset=(X=-25.000000,Y=8.000000,Z=14.000000)
}