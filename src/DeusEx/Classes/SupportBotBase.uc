//=============================================================================
// ���������� ���. �������� Ded'�� ��� ���� 2027
// Support bot. Copyright (C) 2002 Hejhujka (Modified by Ded (C) 2005)
//=============================================================================
class SupportBotBase extends SpiderBot2
     abstract;

var() class<SupportBotItem> SpawnClass;
var() travel class<Projectile> GrenadeClass;
var() travel int SpawnGrenadeClass;

simulated function bool HasSpawnGrenade()
{
	if(SpawnGrenadeClass == 88)
		return false;
	else
		return true;
}

simulated function SetSpawnGrenade(int cl)
{
	SpawnGrenadeClass = cl;
}

defaultproperties
{
	SpawnGrenadeClass=88
}