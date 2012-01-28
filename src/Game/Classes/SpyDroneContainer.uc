//=============================================================================
// ���������� ��� (���������). �������� Ded'�� ��� ���� 2027
// Support bot (Container). Copyright (C) 2002 Hejhujka (Modified by Ded (C) 2005)
//=============================================================================
class SpyDroneContainer extends SpyDroneContainerImpl;

defaultproperties
{
	BotHealth=10
	BotEMPHealth=60
	normalrate=50
	spawnClass=class'Game.SpyDroneFlying'
	itemNeeded=class'Game.SupportBotControl'
	Icon=Texture'GameMedia.Icons.BeltIconDrone'
    largeIcon=Texture'GameMedia.Icons.LargeIconDrone'
    largeIconWidth=35
    largeIconHeight=52
    GrenadeClasses(0)=Class'Game.P_LAM'
    GrenadeClasses(1)=Class'Game.P_NapalmGrenade'
    GrenadeClasses(2)=Class'Game.P_EMP'
    GrenadeClasses(3)=Class'Game.P_RadioGrenade'
    GrenadeClasses(4)=Class'Game.P_RiotGrenade'
}