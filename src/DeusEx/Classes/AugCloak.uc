//=============================================================================
// AugCloak.
//=============================================================================
class AugCloak extends Augmentation;

state Active
{
Begin:
	Player.ShowCloakOnEffect();
	//if ((Player.inHand != None) && (Player.inHand.IsA('DeusExWeapon')))
	//	Player.ServerConditionalNotifyMsg( Player.MPMSG_NoCloakWeapon );

	//Player.PlaySound(Sound'CloakUp', SLOT_None, 0.85, ,768,1.0);
}

function Deactivate()
{
	//Player.PlaySound(Sound'CloakDown', SLOT_None, 0.85, ,768,1.0);
	Super.Deactivate();
	Player.ShowCloakOffEffect();
}

/*simulated function float GetEnergyRate()
{
	return energyRate * LevelValues[CurrentLevel];
}*/

defaultproperties
{
	 ActivateSound=Sound'CloakUp'
	 DeactivateSound=Sound'CloakDown'
     EnergyRate=600.000000
     Icon=Texture'DeusExUI.UserInterface.AugIconCloak'
     smallIcon=Texture'DeusExUI.UserInterface.AugIconCloak_Small'
     LevelValues(0)=1.000000
     LevelValues(1)=1.000000
     MaxLevel=1
     AugmentationLocation=LOC_Subdermal
}