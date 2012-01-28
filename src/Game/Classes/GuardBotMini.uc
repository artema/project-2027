//=============================================================================
// �������� ���. �������� Ded'�� ��� ���� 2027
// Security bot. Copyright (C) 2003 Ded
//=============================================================================
class GuardBotMini extends Robot;

enum ESkinColor
{
	SC_Default,
	SC_Chinese,
	SC_Russian,
	SC_Omar,
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
		case SC_Default:	Skin = Texture'SecurityBot3Tex1'; break;
		case SC_Chinese:	Skin = Texture'SecurityBot3Tex2'; break;
		case SC_Russian:	Skin = Texture'SecurityBot3Tex1';
				        SpeechAreaSecure=Sound'GameMedia.Robot.GuardBot2AreaSecure';
				        SpeechTargetAcquired=Sound'GameMedia.Robot.GuardBot2TargetAcquired';
				        SpeechTargetLost=Sound'GameMedia.Robot.GuardBot2TargetLost';
				        SpeechOutOfAmmo=Sound'GameMedia.Robot.GuardBot2OutOfAmmo';
				        SpeechCriticalDamage=Sound'GameMedia.Robot.GuardBot2CriticalDamage';
				        SpeechScanning=Sound'GameMedia.Robot.GuardBot2Scanning';
                                                                          break;
        case SC_Omar:	Skin = Texture'GameMedia.Characters.GuardBotMiniOmar';
				        SpeechAreaSecure=Sound'GameMedia.Robot.GuardBot2AreaSecure';
				        SpeechTargetAcquired=Sound'GameMedia.Robot.GuardBot2TargetAcquired';
				        SpeechTargetLost=Sound'GameMedia.Robot.GuardBot2TargetLost';
				        SpeechOutOfAmmo=Sound'GameMedia.Robot.GuardBot2OutOfAmmo';
				        SpeechCriticalDamage=Sound'GameMedia.Robot.GuardBot2CriticalDamage';
				        SpeechScanning=Sound'GameMedia.Robot.GuardBot2Scanning';
                                                                          break;
                                                                          
        case SC_MJ12:		Skin = Texture'GameMedia.Characters.GuardBotMiniMJ12'; break;
	}

    if (bCloackActive)
    {
          bHasCloak=True;
          CloakThreshold=500;
          KillShadow();
    }
}

function ShowCloakEffect()
{
	SetSkinStyle(STY_Translucent, Texture'WhiteStatic', 0.1);
	Spawn(class'SFXCamoOnLight',,, Location);
	Spawn(class'SFXCamoOnFlash',,, Location);
	PlaySound(Sound'CloakUp', SLOT_None, 0.85,, 768, 1.0);
}

function HideCloakEffect()
{
	ResetSkinStyle();
	Spawn(class'SFXCamoOnLight',,, Location);
	Spawn(class'SFXCamoOnFlash',,, Location);
	PlaySound(Sound'CloakDown', SLOT_None, 0.85,, 768, 1.0);
}

defaultproperties
{
     SpawnAmmo=Class'DeusEx.RAmmo556mm'
     SpawnAmmoCount=50
     SpawnAmmoMesh=LodMesh'GameMedia.556mmFMJCrate'
     SpawnAmmoRadius=2.6
     SpawnAmmoHeight=1.77
     CloakOnSound=Sound'DeusExSounds.Augmentation.CloakUp'
     CloakOffSound=Sound'DeusExSounds.Augmentation.CloakDown'
     SpeechAreaSecure=Sound'DeusExSounds.Robot.SecurityBot3AreaSecure'
     SpeechTargetAcquired=Sound'DeusExSounds.Robot.SecurityBot3TargetAcquired'
     SpeechTargetLost=Sound'DeusExSounds.Robot.SecurityBot3TargetLost'
     SpeechOutOfAmmo=Sound'DeusExSounds.Robot.SecurityBot3OutOfAmmo'
     SpeechCriticalDamage=Sound'DeusExSounds.Robot.SecurityBot3CriticalDamage'
     SpeechScanning=Sound'DeusExSounds.Robot.SecurityBot3Scanning'
     EMPHitPoints=40
     WalkingSpeed=1.000000
     bEmitDistress=True
     InitialInventory(0)=(Inventory=Class'Game.WeaponBotSubMachinegun')
     InitialInventory(1)=(Inventory=Class'DeusEx.RAmmo556mm',Count=12)
     WalkSound=Sound'DeusExSounds.Robot.SecurityBot2Walk'
     GroundSpeed=95.000000
     WaterSpeed=50.000000
     AirSpeed=144.000000
     AccelRate=500.000000
     Health=150
     UnderWaterTime=20.000000
     AttitudeToPlayer=ATTITUDE_Ignore
     DrawType=DT_Mesh
     Mesh=LodMesh'DeusExCharacters.SecurityBot3'
     SoundRadius=16
     SoundVolume=128
     AmbientSound=Sound'DeusExSounds.Robot.SecurityBot3Move'
     CollisionRadius=25.350000
     CollisionHeight=28.500000
     Mass=800.000000
     Buoyancy=100.000000
     BindName="GuardBotMini"
}
