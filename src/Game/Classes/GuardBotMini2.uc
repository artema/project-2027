//=============================================================================
// �������� ���. �������� Ded'�� ��� ���� 2027
// Security bot. Copyright (C) 2004 Ded
//=============================================================================
class GuardBotMini2 extends Robot;


enum EVoiceType
{
	VT_Default,
	VT_Russian
};

var(Sounds) sound CloakOnSound;
var(Sounds) sound CloakOffSound;
var(Robot) bool bCloackActive;
var() EVoiceType VoiceType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (VoiceType)
	{
		case VT_Default:	break;
		case VT_Russian:	
				        SpeechAreaSecure=Sound'GameMedia.Robot.GuardBot2AreaSecure';
				        SpeechTargetAcquired=Sound'GameMedia.Robot.GuardBot2TargetAcquired';
				        SpeechTargetLost=Sound'GameMedia.Robot.GuardBot2TargetLost';
				        SpeechOutOfAmmo=Sound'GameMedia.Robot.GuardBot2OutOfAmmo';
				        SpeechCriticalDamage=Sound'GameMedia.Robot.GuardBot2CriticalDamage';
				        SpeechScanning=Sound'GameMedia.Robot.GuardBot2Scanning';
                                        break;
	}

        if (bCloackActive)
        {
              bHasCloak=True;
              CloakThreshold=500;
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


defaultproperties
{
     SpawnAmmo=Class'DeusEx.RAmmoGas'
     SpawnAmmoCount=100
     SpawnAmmoMesh=LodMesh'DeusExItems.AmmoNapalm'
     SpawnAmmoRadius=3.13
     SpawnAmmoHeight=11.48
     SpeechTargetAcquired=Sound'DeusExSounds.Robot.SecurityBot3TargetAcquired'
     SpeechTargetLost=Sound'DeusExSounds.Robot.SecurityBot3TargetLost'
     SpeechOutOfAmmo=Sound'DeusExSounds.Robot.SecurityBot3OutOfAmmo'
     SpeechCriticalDamage=Sound'DeusExSounds.Robot.SecurityBot3CriticalDamage'
     SpeechScanning=Sound'DeusExSounds.Robot.SecurityBot3Scanning'
     WalkingSpeed=1.000000
     bEmitDistress=True
     InitialInventory(0)=(Inventory=Class'Game.WeaponBotFire')
     InitialInventory(1)=(Inventory=Class'DeusEx.RAmmoGas',Count=50)
     GroundSpeed=95.000000
     WaterSpeed=50.000000
     AirSpeed=144.000000
     AccelRate=500.000000
     Health=150
     UnderWaterTime=20.000000
     AttitudeToPlayer=ATTITUDE_Ignore
     DrawType=DT_Mesh
     Mesh=LodMesh'DeusExCharacters.SecurityBot4'
     SoundRadius=16
     SoundVolume=128
     AmbientSound=Sound'DeusExSounds.Robot.SecurityBot4Move'
     CollisionRadius=27.500000
     CollisionHeight=28.500000
     Mass=800.000000
     Buoyancy=100.000000
     BindName="GuardBotMini2"
}
