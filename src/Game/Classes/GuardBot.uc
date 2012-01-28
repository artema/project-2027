//=============================================================================
// Security bot. Copyright (C) 2003 Ded
//=============================================================================
class GuardBot extends Robot;

enum ESkinColor
{
	SC_UNATCO,
	SC_Chinese,
	SC_Russian,
	SC_MJ12
};

var(Sounds) sound CloakOnSound;
var(Sounds) sound CloakOffSound;
var(Robot) bool bCloackActive;
var() ESkinColor SkinColor;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	UpdateBotSkin();

    if (bCloackActive)
    {
          bHasCloak=True;
          EnableCloak(True);
          //CloakThreshold=9000;
         // KillShadow();
    }
}

function UpdateBotSkin()
{
	switch (SkinColor)
	{
		case SC_UNATCO:		MultiSkins[1] = Texture'SecurityBot2Tex1'; break;
		case SC_Chinese:	MultiSkins[1] = Texture'SecurityBot2Tex2'; break;
		case SC_Russian:	MultiSkins[1] = Texture'GameMedia.Characters.GuardBotTex1';
			SpeechAreaSecure=Sound'GameMedia.Robot.GuardBotAreaSecure';
			SearchingSound=Sound'DeusExSounds.Robot.SecurityBot2Searching';
			SpeechTargetAcquired=Sound'GameMedia.Robot.GuardBotTargetAcquired';
			SpeechTargetLost=Sound'GameMedia.Robot.GuardBotTargetLost';
			SpeechOutOfAmmo=Sound'GameMedia.Robot.GuardBotOutOfAmmo';
			SpeechCriticalDamage=Sound'GameMedia.Robot.GuardBotCriticalDamage';
			SpeechScanning=Sound'GameMedia.Robot.GuardBotScanning';
            break;
		case SC_MJ12:		MultiSkins[1] = Texture'GameMedia.Characters.GuardBotTex2'; break;
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
	UpdateBotSkin();
	Spawn(class'SFXCamoOnLight',,, Location);
	Spawn(class'SFXCamoOnFlash',,, Location);
	PlaySound(Sound'CloakDown', SLOT_None, 0.85,, 768, 1.0);
}

defaultproperties
{
     VisibilityThreshold=0.003
     SpawnAmmo=Class'DeusEx.RAmmo556mm'
     SpawnAmmoCount=50
     SpawnAmmoMesh=LodMesh'GameMedia.556mmFMJCrateBig'
     SpawnAmmoRadius=5.0
     SpawnAmmoHeight=1.77
     CloakOnSound=Sound'DeusExSounds.Augmentation.CloakUp'
     CloakOffSound=Sound'DeusExSounds.Augmentation.CloakDown'
     SpeechAreaSecure=Sound'DeusExSounds.Robot.SecurityBot2AreaSecure'
     SearchingSound=Sound'DeusExSounds.Robot.SecurityBot2Searching'
     SpeechTargetAcquired=Sound'DeusExSounds.Robot.SecurityBot2TargetAcquired'
     SpeechTargetLost=Sound'DeusExSounds.Robot.SecurityBot2TargetLost'
     SpeechOutOfAmmo=Sound'DeusExSounds.Robot.SecurityBot2OutOfAmmo'
     SpeechCriticalDamage=Sound'DeusExSounds.Robot.SecurityBot2CriticalDamage'
     SpeechScanning=Sound'DeusExSounds.Robot.SecurityBot2Scanning'
     EMPHitPoints=100
     explosionSound=Sound'DeusExSounds.Robot.SecurityBot2Explode'
     WalkingSpeed=1.000000
     bEmitDistress=True
     InitialInventory(0)=(Inventory=Class'Game.WeaponBotMachinegun')
     InitialInventory(1)=(Inventory=Class'DeusEx.RAmmo10mm',Count=40)
     WalkSound=Sound'DeusExSounds.Robot.SecurityBot2Walk'
     GroundSpeed=95.000000
     WaterSpeed=50.000000
     AirSpeed=144.000000
     AccelRate=500.000000
     Health=250
     UnderWaterTime=20.000000
     MaxStepHeight=30.000000
     AttitudeToPlayer=ATTITUDE_Ignore
     DrawType=DT_Mesh
     Mesh=LodMesh'DeusExCharacters.SecurityBot2'
     CollisionRadius=62.000000
     CollisionHeight=58.279999
     Mass=1300.000000
     Buoyancy=100.000000
     BindName="GuardBot"
}
