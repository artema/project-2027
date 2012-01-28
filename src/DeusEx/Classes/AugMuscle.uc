//=============================================================================
// AugMuscle.
//=============================================================================
class AugMuscle extends Augmentation;

state Active
{
Begin:
}

function Deactivate()
{
	Super.Deactivate();

	// check to see if the player is carrying something too heavy for him
	if (Player.CarriedDecoration != None)
		if (!Player.CanBeLifted(Player.CarriedDecoration))
			Player.DropDecoration();
}

defaultproperties
{
     EnergyRate=150.000000
     Icon=Texture'DeusExUI.UserInterface.AugIconMuscle'
     smallIcon=Texture'DeusExUI.UserInterface.AugIconMuscle_Small'
     LevelValues(0)=1.250000
     LevelValues(1)=2.000000
     MaxLevel=1
     AugmentationLocation=LOC_Arm
}
