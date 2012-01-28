//=======================================================
// ������ - Guid Gun. �������� Ded'�� ��� ���� 2027
// Weapon - Guid Gun. Copyright (C) 2003 Ded
//=======================================================
class WeaponSpecialGuidGun extends WeaponGuidGun;

defaultproperties
{
	 bCannotBePickedUp=True
	 
     ShotDamage(0)=400
     ShotDamage(1)=400

     BaseAccuracy=0.25
     MinWeaponAcc=0.0

     ShotTime=2.0
     reloadTime=1.5

     NoiseVolume(0)=3.0
     NoiseVolume(1)=3.0

     ProjectileClass=Class'Game.P_GEPRocketSuper'
     ProjectileNames(0)=Class'Game.P_GEPRocketSuper'
}