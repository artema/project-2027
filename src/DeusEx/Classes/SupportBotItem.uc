//=============================================================================
// ���������� ��� (���������). �������� Ded'�� ��� ���� 2027
// Support bot (Container). Copyright (C) 2002 Hejhujka (Modified by Ded (C) 2005)
//=============================================================================
class SupportBotItem extends DeusExPickup
     abstract;

var() travel int BotHealth;
var() travel int BotEMPHealth;
var() travel float BotWorkTime;
var() travel float BotLastRecharge;
var() travel int SpawnGrenadeClass;

var() class<Projectile> GrenadeClasses[5];

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
	bActivatable=True
    SpawnGrenadeClass=88
    BotHealth=100
    BotEMPHealth=25
}