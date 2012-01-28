//=======================================================
// ������ - ���� �������. �������� Ded'�� ��� ���� 2027
// Weapon - Mini crossbow. Copyright (C) 2003 Ded
//=======================================================
class WeaponMinibotCrossbowStunning extends WeaponMinibotCrossbow;

function name WeaponDamageType()
{
	return 'Poison';
}

defaultproperties
{
	 HitDamage=15

     ProjectileClass=Class'P_BotDartStunning'
}