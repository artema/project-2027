//=============================================================================
// ���������� ������ (��������). �������� Ded'�� ��� ���� 2027
// MiniCrossbow Dart (Light). Copyright (C) 2003 Ded
//=============================================================================
class P_DartFlare extends P_Dart;

function PlayRicochet(vector HitNormal)
{
	Super.PlayRicochet(HitNormal);
	Destroy();
}

defaultproperties
{
     DamageType=Burned
     spawnAmmoClass=Class'DeusEx.RAmmoDartFlare'
     Damage=20
     LifeSpan=60.0
     bUnlit=True
     LightType=LT_Steady
     LightEffect=LE_NonIncidence
     LightBrightness=255
     LightHue=16
     LightSaturation=192
     LightRadius=5
}