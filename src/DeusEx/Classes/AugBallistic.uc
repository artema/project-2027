//=============================================================================
// AugBallistic.
//=============================================================================
class AugBallistic extends Augmentation;

state Active
{
Begin:
}

function Deactivate()
{
	Super.Deactivate();
}

defaultproperties
{
     EnergyRate=200.000000
     Icon=Texture'DeusExUI.UserInterface.AugIconBallistic'
     smallIcon=Texture'DeusExUI.UserInterface.AugIconBallistic_Small'
     LevelValues(0)=0.650000
     LevelValues(1)=0.350000
     AugmentationLocation=LOC_Subdermal
     MaxLevel=1
}