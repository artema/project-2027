//=============================================================================
// AugEnviro.
//=============================================================================
class AugEnviro extends Augmentation;

var() float SwimLevelValues[4];
var float mult, pct;

state Active
{
Begin:

	mult = Player.SkillSystem.GetSkillLevelValue(class'SkillPower');
	pct = Player.swimTimer / Player.swimDuration;
	Player.UnderWaterTime = 240;
	Player.swimDuration = Player.UnderWaterTime * mult;
	Player.swimTimer = Player.swimDuration * pct;
}

function Deactivate()
{
	Super.Deactivate();

	mult = Player.SkillSystem.GetSkillLevelValue(class'SkillPower');
	pct = Player.swimTimer / Player.swimDuration;
	Player.UnderWaterTime = Player.Default.UnderWaterTime;
	Player.swimDuration = Player.UnderWaterTime * mult;
	Player.swimTimer = Player.swimDuration * pct;
}

defaultproperties
{
     EnergyRate=60.000000
     MaxLevel=0
     Icon=Texture'DeusExUI.UserInterface.AugIconAquaLung'
     smallIcon=Texture'DeusExUI.UserInterface.AugIconAquaLung_Small'
     LevelValues(0)=0.1
     AugmentationLocation=LOC_Torso
}