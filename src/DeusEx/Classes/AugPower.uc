//=============================================================================
// AugPower.
//=============================================================================
class AugPower extends Augmentation;

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
     EnergyRate=5.000000
     Icon=Texture'DeusExUI.UserInterface.AugIconPowerRecirc'
     smallIcon=Texture'DeusExUI.UserInterface.AugIconPowerRecirc_Small'
     LevelValues(0)=0.500000
     MaxLevel=0
     AugmentationLocation=LOC_Torso
}