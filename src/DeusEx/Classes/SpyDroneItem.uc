//=============================================================================
// ���������� ��� (���������). �������� Ded'�� ��� ���� 2027
// Support bot (Container). Copyright (C) 2002 Hejhujka (Modified by Ded (C) 2005)
//=============================================================================
class SpyDroneItem extends DeusExPickup
     abstract;
     
var class<SpyDrone> spawnClass;

var() travel int BotHealth;
var() travel int BotEMPHealth;

var() travel int SpawnGrenadeClass;

var() class<GrenadeProjectile> GrenadeClasses[5];

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
	bCanHaveMultipleCopies=True
	bActivatable=True
	SpawnGrenadeClass=88
    BotHealth=10
    BotEMPHealth=10
}