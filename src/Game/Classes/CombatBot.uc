//=============================================================================
// ������ �����. �������� Ded'�� ��� ���� 2027
// Cobmat bot. Copyright (C) 2003 Ded
//=============================================================================
class CombatBot extends Robot;

enum ESkinColor
{
	SC_Default,
	SC_Chinese,
	SC_Russian,
	SC_MJ12
};

var(Sounds) sound CloakOnSound;
var(Sounds) sound CloakOffSound;
var(Robot) bool bCloackActive;
var() ESkinColor SkinColor;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinColor)
	{
		case SC_Default:	Skin = Texture'MilitaryBotTex1'; break;
		case SC_Chinese:	Skin = Texture'MilitaryBotTex2'; break;
		case SC_Russian:	Skin = Texture'GameMedia.Characters.MilitaryBotTex3';
				SpeechAreaSecure=Sound'GameMedia.Robot.CombatBotAreaSecure';
				SearchingSound=Sound'DeusExSounds.Robot.MilitaryBotSearching';
				SpeechTargetAcquired=Sound'GameMedia.Robot.CombatBotTargetAcquired';
				SpeechTargetLost=Sound'GameMedia.Robot.CombatBotTargetLost';
				SpeechOutOfAmmo=Sound'GameMedia.Robot.CombatBotOutOfAmmo';
				SpeechCriticalDamage=Sound'GameMedia.Robot.CombatBotCriticalDamage';
				SpeechScanning=Sound'GameMedia.Robot.CombatBotScanning'; break;
		case SC_MJ12:		Skin = Texture'GameMedia.Characters.MilitaryBotTex4'; break;
	}

        if (bCloackActive)
        {
              bHasCloak=True;
              CloakThreshold=1000;
              KillShadow();
        }
}

// ----------------------------------------------------------------------
// EnableCloak()
// ----------------------------------------------------------------------
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

function PlayDisabled()
{
	local int rnd;

	rnd = Rand(3);
	if (rnd == 0)
		TweenAnimPivot('Disabled1', 0.2);
	else if (rnd == 1)
		TweenAnimPivot('Disabled2', 0.2);
	else
		TweenAnimPivot('Still', 0.2);
}

defaultproperties
{
	 VisibilityThreshold=0.001
	 bRunToAttackingEnemy=False
	 CloseCombatMult=0.0
     SpawnAmmo=Class'DeusEx.RAmmoRocket'
     CloakOnSound=Sound'DeusExSounds.Augmentation.CloakUp'
     CloakOffSound=Sound'DeusExSounds.Augmentation.CloakDown'
     SpeechAreaSecure=Sound'DeusExSounds.Robot.MilitaryBotAreaSecure'
     SearchingSound=Sound'DeusExSounds.Robot.MilitaryBotSearching'
     SpeechTargetAcquired=Sound'DeusExSounds.Robot.MilitaryBotTargetAcquired'
     SpeechTargetLost=Sound'DeusExSounds.Robot.MilitaryBotTargetLost'
     SpeechOutOfAmmo=Sound'DeusExSounds.Robot.MilitaryBotOutOfAmmo'
     SpeechCriticalDamage=Sound'DeusExSounds.Robot.MilitaryBotCriticalDamage'
     SpeechScanning=Sound'DeusExSounds.Robot.MilitaryBotScanning'
     EMPHitPoints=200
     explosionSound=Sound'DeusExSounds.Robot.MilitaryBotExplode'
     WalkingSpeed=1.000000
     bEmitDistress=True
     //InitialInventory(0)=(Inventory=Class'Game.WeaponBotSuperMachinegun')
     //InitialInventory(1)=(Inventory=Class'DeusEx.RAmmo10mm',Count=50)
     InitialInventory(0)=(Inventory=Class'Game.WeaponBotSuperRocket')
     InitialInventory(1)=(Inventory=Class'DeusEx.RAmmoRocketRobot',Count=60)
     InitialInventory(2)=(Inventory=Class'Game.WeaponBotDualFire')
     InitialInventory(3)=(Inventory=Class'DeusEx.RAmmoGas',Count=200)
     WalkSound=Sound'GameMedia.Misc.BigRobotWalk'
     GroundSpeed=44.000000
     WaterSpeed=50.000000
     AirSpeed=144.000000
     AccelRate=500.000000
     Health=600
     UnderWaterTime=20.000000
     MaxStepHeight=30.000000
     AttitudeToPlayer=ATTITUDE_Ignore
     DrawType=DT_Mesh
     Mesh=LodMesh'DeusExCharacters.MilitaryBot'
     CollisionRadius=80.000000
     CollisionHeight=79.000000
     Mass=2500.000000
     Buoyancy=100.000000
     RotationRate=(Yaw=10000)
     BindName="MilitaryBot"
}
