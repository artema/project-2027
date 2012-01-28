//=============================================================================
// AugmentationUpgradeCannister.
//
// Allows the player to upgrade any augmentation
//=============================================================================
class AugmentationUpgradeCannister extends DeusExPickup;

var localized string MustBeUsedOn;

// ----------------------------------------------------------------------
// UpdateInfo()
// ----------------------------------------------------------------------

simulated function bool UpdateInfo(Object winObject)
{
	local PersonaInfoWindow winInfo;

	winInfo = PersonaInfoWindow(winObject);
	if (winInfo == None)
		return False;

	winInfo.Clear();
	winInfo.SetTitle(itemName);
	winInfo.SetText(Description $ winInfo.CR() $ winInfo.CR() $ MustBeUsedOn);

	return True;
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.AugmentationUpgradeCannister'
     PickupViewMesh=LodMesh'DeusExItems.AugmentationUpgradeCannister'
     ThirdPersonMesh=LodMesh'DeusExItems.AugmentationUpgradeCannister'
     LandSound=Sound'DeusExSounds.Generic.PlasticHit1'
     Icon=Texture'DeusExUI.Icons.BeltIconAugmentationUpgrade'
     largeIcon=Texture'DeusExUI.Icons.LargeIconAugmentationUpgrade'
     largeIconWidth=24
     largeIconHeight=41
     Mesh=LodMesh'DeusExItems.AugmentationUpgradeCannister'
     CollisionRadius=3.200000
     CollisionHeight=5.180000
     Mass=10.000000
     Buoyancy=12.000000
}
