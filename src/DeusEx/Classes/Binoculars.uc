//=============================================================================
// Binoculars.
//=============================================================================
class Binoculars extends DeusExPickup
	abstract;

// ----------------------------------------------------------------------
// state Activated
// ----------------------------------------------------------------------

state Activated
{
	function Activate()
	{
		local DeusExPlayer player;

		Super.Activate();

		player = DeusExPlayer(Owner);
		if (player != None)
			player.DesiredFOV = player.Default.DesiredFOV;
	}

	function BeginState()
	{
		local DeusExPlayer player;
	
		Super.BeginState();

		player = DeusExPlayer(Owner);
		RefreshScopeDisplay(player, False);
	}
Begin:
}

// ----------------------------------------------------------------------
// state DeActivated
// ----------------------------------------------------------------------

state DeActivated
{
	function BeginState()
	{
		local DeusExPlayer player;
		
		Super.BeginState();

		player = DeusExPlayer(Owner);
		if (player != None)
		{
			// Hide the Scope View
			DeusExRootWindow(player.rootWindow).scopeView.DeactivateView();
		}
	}
}

// ----------------------------------------------------------------------
// RefreshScopeDisplay()
// ----------------------------------------------------------------------

function RefreshScopeDisplay(DeusExPlayer player, optional bool bInstant)
{
	if ((bActive) && (player != None))
	{
		// Show the Scope View
		DeusExRootWindow(player.rootWindow).scopeView.ActivateView(20, True, bInstant);
	}
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     bActivatable=True
     PlayerViewOffset=(X=18.000000,Z=-6.000000)
     PlayerViewMesh=LodMesh'DeusExItems.TestBox'
     PickupViewMesh=LodMesh'DeusExItems.TestBox'
     ThirdPersonMesh=LodMesh'DeusExItems.TestBox'
     LandSound=Sound'DeusExSounds.Generic.PaperHit2'
     Icon=Texture'DeusExUI.Icons.BeltIconBinoculars'
     largeIcon=Texture'DeusExUI.Icons.LargeIconBinoculars'
     largeIconWidth=49
     largeIconHeight=34
     Mesh=LodMesh'DeusExItems.TestBox'
     CollisionRadius=7.000000
     CollisionHeight=2.060000
     Mass=5.000000
     Buoyancy=6.000000
}
