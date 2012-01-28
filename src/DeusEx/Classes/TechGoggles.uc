//=============================================================================
// TechGoggles.
//=============================================================================
class TechGoggles extends ChargedPickup
     abstract;

// ----------------------------------------------------------------------
// ChargedPickupBegin()
// ----------------------------------------------------------------------

function ChargedPickupBegin(DeusExPlayer Player)
{
	Super.ChargedPickupBegin(Player);

	UpdateHUDDisplay(Player);
}

// ----------------------------------------------------------------------
// UpdateHUDDisplay()
// ----------------------------------------------------------------------

function UpdateHUDDisplay(DeusExPlayer Player)
{
	DeusExRootWindow(Player.rootWindow).hud.augDisplay.bGogglesActive = IsActive();
}

// ----------------------------------------------------------------------
// ChargedPickupEnd()
// ----------------------------------------------------------------------

function ChargedPickupEnd(DeusExPlayer Player)
{
	Super.ChargedPickupEnd(Player);

	DeusExRootWindow(Player.rootWindow).hud.augDisplay.bGogglesActive = False;
}


defaultproperties
{
     LoopSound=Sound'DeusExSounds.Pickup.TechGogglesLoop'
     ChargedIcon=Texture'DeusExUI.Icons.ChargedIconGoggles'
     PlayerViewOffset=(X=20.000000,Z=-6.000000)
     PlayerViewMesh=LodMesh'DeusExItems.TestBox'
     PickupViewMesh=LodMesh'DeusExItems.TestBox'
     ThirdPersonMesh=LodMesh'DeusExItems.TestBox'
     Charge=500
     LandSound=Sound'DeusExSounds.Generic.PaperHit2'
     Icon=Texture'DeusExUI.Icons.BeltIconTechGoggles'
     largeIcon=Texture'DeusExUI.Icons.LargeIconTechGoggles'
     largeIconWidth=49
     largeIconHeight=36
     Mesh=LodMesh'DeusExItems.TestBox'
     CollisionRadius=8.000000
     CollisionHeight=2.800000
     Mass=10.000000
     Buoyancy=5.000000
}