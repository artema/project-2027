//=============================================================================
// ���������� ���. �������� Ded'�� ��� ���� 2027
// Support bot. Copyright (C) 2002 Hejhujka (Modified by Ded (C) 2005)
//=============================================================================
class SupportBotMJ12 extends SupportBot;

var(Sounds) sound CloakOnSound;
var(Sounds) sound CloakOffSound;

function EnableCloak(bool bEnable)
{
	if (!bHasCloak || (CloakEMPTimer > 0) || (Health <= 0) || bOnFire)
		bEnable = false;

	if (bEnable && !bCloakOn)
	{
		SetSkinStyle(STY_Translucent, Texture'WhiteStatic', 0.05);
		KillShadow();
		bCloakOn = bEnable;
	    PlaySound(CloakOnSound, SLOT_None,,, 2048);
	}
	else if (!bEnable && bCloakOn)
	{
		ResetSkinStyle();
		CreateShadow();
		bCloakOn = bEnable;
	    PlaySound(CloakOffSound, SLOT_None,,, 2048);
	}
}

function FuncOn()
{
	EnableCloak(True);
	CloakThreshold=SpawnClass.Default.BotHealth;
	WalkSound=Sound'DeusExSounds.Animal.GreaselFootstep';
	bEmitDistress=False;
}

function FuncOff()
{
	EnableCloak(False);
	CloakThreshold=0;
	WalkSound=Default.WalkSound;
	bEmitDistress=True;
}

function PostBeginPlay()
{
	Super.PostBeginPlay();

	CloakThreshold=0;
	bCloakOn=False;
	Skin=Texture'GameMedia.Characters.SpiderBotTex2';
}

function Tick(float deltaTime)
{
	Super.Tick(deltaTime);

	Skin=Texture'GameMedia.Characters.SpiderBotTex2';
}

defaultproperties
{
    BindName="SupportBotMJ12"
    SpawnClass=Class'Game.SupportBotContainerMJ12'
    
    CloseCombatMult=0.900000
    
    CloakThreshold=0
    bHasCloak=True
    CloakOnSound=Sound'DeusExSounds.Augmentation.CloakUp'
    CloakOffSound=Sound'DeusExSounds.Augmentation.CloakDown'
    
    InitialInventory(0)=(Inventory=Class'WeaponMinibotGas')
    InitialInventory(1)=(Inventory=Class'RAmmoRiotGrenade',Count=900)
    InitialInventory(2)=(Inventory=Class'WeaponMinibotCrossbow')
    InitialInventory(3)=(Inventory=Class'RAmmoDart',Count=100)

    Skin=Texture'GameMedia.Characters.SpiderBotTex2'
}