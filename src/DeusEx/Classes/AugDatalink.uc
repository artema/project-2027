//=============================================================================
// AugDatalink.
//=============================================================================
class AugDatalink extends Augmentation;

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------
state Active
{
Begin:
}

// ----------------------------------------------------------------------
// Deactivate()
// ----------------------------------------------------------------------

function Deactivate()
{
	Super.Deactivate();
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     EnergyRate=0.000000
     MaxLevel=0
     Icon=Texture'DeusExUI.UserInterface.AugIconDatalink'
     smallIcon=Texture'DeusExUI.UserInterface.AugIconDatalink_Small'
     bAlwaysActive=True
     LevelValues(0)=1.000000
     MaxLevel=0
     AugmentationLocation=LOC_Default
}
