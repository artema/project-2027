//=============================================================================
// ���������� ��� (���������). �������� Ded'�� ��� ���� 2027
// Support bot (Container). Copyright (C) 2002 Hejhujka (Modified by Ded (C) 2005)
//=============================================================================
class SupportBotContainer extends SupportBotContainerImpl
     abstract;

defaultproperties
{
	itemNeeded=class'Game.SupportBotControl'
	GrenadeClasses(0)=Class'Game.P_LAM'
    GrenadeClasses(1)=Class'Game.P_NapalmGrenade'
    GrenadeClasses(2)=Class'Game.P_EMP'
    GrenadeClasses(3)=Class'Game.P_RadioGrenade'
    GrenadeClasses(4)=Class'Game.P_RiotGrenade'
}