//=============================================================================
// AugHeartLung.
//=============================================================================
class AugHeartLung extends Augmentation;

state Active
{
Begin:
	// make sure if the player turns on any other augs while
	// this one is on, it gets affected also.
Loop:
	Player.AugmentationSystem.BoostAugs(True, Self);
	Sleep(1.0);
	Goto('Loop');
}

function Deactivate()
{
	Super.Deactivate();

	Player.AugmentationSystem.BoostAugs(False, Self);
	Player.AugmentationSystem.DeactivateAll();
}

defaultproperties
{
     EnergyRate=100.000000
     MaxLevel=0
     Icon=Texture'DeusExUI.UserInterface.AugIconHeartLung'
     smallIcon=Texture'DeusExUI.UserInterface.AugIconHeartLung_Small'
     LevelValues(0)=1.000000
     AugmentationLocation=LOC_Torso
}