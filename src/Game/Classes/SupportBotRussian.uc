//=============================================================================
// ���������� ���. �������� Ded'�� ��� ���� 2027
// Support bot. Copyright (C) 2002 Hejhujka (Modified by Ded (C) 2005)
//=============================================================================
class SupportBotRussian extends SupportBot;

function FuncOn()
{
}

function FuncOff()
{
}

defaultproperties
{
    BindName="SupportBotMJ12"
    SpawnClass=Class'SupportBotContainerRussian'
    
    CloseCombatMult=0.900000
    
    InitialInventory(0)=(Inventory=Class'WeaponMinibotIcarus')
    InitialInventory(1)=(Inventory=Class'RAmmoLamGrenade',Count=200)
    InitialInventory(2)=(Inventory=Class'WeaponMinibotCrossbowStunning')
    InitialInventory(3)=(Inventory=Class'RAmmoDart',Count=100)
    
    Skin=Texture'GameMedia.Characters.SpiderBotTexRussian'
    
    SpeechAreaSecure=Sound'GameMedia.Robot.RessieAreaSecure';
    SpeechTargetAcquired=Sound'GameMedia.Robot.RessieTargetAcquired';
    SpeechTargetLost=Sound'GameMedia.Robot.RessieTargetLost';
    SpeechOutOfAmmo=Sound'GameMedia.Robot.RessieOutOfAmmo';
    SpeechCriticalDamage=Sound'GameMedia.Robot.RessieCriticalDamage';
    SpeechScanning=Sound'GameMedia.Robot.RessieScanning';
}