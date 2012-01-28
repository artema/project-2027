//=============================================================================
// ����. ������� Ded'�� ��� ���� 2027
// Omar. Copyright (C) 2007 Ded
//=============================================================================
class Omar extends HumanThug
	abstract;

#exec obj load file="..\2027\Textures\GameEffects.utx" package=GameEffects

function GotoDisabledState(name damageType, EHitLocation hitPos)
{
	if (!bCollideActors && !bBlockActors && !bBlockPlayers)
		return;
	else if ((damageType == 'TearGas') || (damageType == 'HalonGas'))
		GotoNextState();
	else if (damageType == 'Stunned')
		GotoState('Stunned');
	else if (CanShowPain())
		TakeHit(hitPos);
	else
		GotoNextState();
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
//Sound'GameMedia.Misc.MechWalk'
defaultproperties
{
	 GroundSpeed=230.000000
	 bHasCloak=True
	 CloakThreshold=50
	 MinHealth=0
     bCanSit=False
     bHasTorsoDefence=True
     bHasLegDefence=True
     bHasMask=True
     BaseAccuracy=0.100000
     SoundRadius=8
     SoundVolume=32
     Health=120
     HealthTorso=120
     HealthHead=140
     AmbientSound=Sound'DeusExSounds.Robot.MedicalBotMove'
     CarcassType=Class'Game.Omar2Carcass'
     WalkingSpeed=0.296000
     walkAnimMult=0.780000
     GroundSpeed=200.000000
     UnderWaterTime=-1.000000
     Texture=Texture'GameMedia.Characters.OmarTex1'
     Mesh=LodMesh'DeusExCharacters.GM_Scubasuit'
     MultiSkins(0)=Texture'GameMedia.Characters.OmarTex0a'
     MultiSkins(1)=Texture'GameMedia.Characters.OmarTex0a'
     MultiSkins(2)=Texture'GameMedia.Characters.OmarTex1'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     WalkSound=Sound'GameMedia.Misc.RobotLegs5'
     Mass=120.000000
     BindName="Omar"
     BarkBindName="Omar"
}