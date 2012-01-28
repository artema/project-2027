//=============================================================================
// Lockpick.
//=============================================================================
class Lockpick expands SkilledTool;


simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	// If this is a netgame, then override defaults
	if ( Level.NetMode != NM_StandAlone )
		MaxCopies = 5;
}

// ----------------------------------------------------------------------
// TestMPBeltSpot()
// Returns true if the suggested belt location is ok for the object in mp.
// ----------------------------------------------------------------------

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return (BeltSpot == 7);
}

function BecomePickup()
{
	Super.BecomePickup();

	DrawScale=0.6;	
}

defaultproperties
{
	 bNewSkin=True     
     PlayerViewSkins(0)=Texture'GameMedia.Skins.WeaponNewHands'
	 ThirdPersonScale=0.60
	 DrawScale=0.6
     UseSound=Sound'DeusExSounds.Generic.LockpickRattling'
     maxCopies=12
     bCanHaveMultipleCopies=True
     PlayerViewOffset=(X=16.000000,Y=8.000000,Z=-16.000000)
     PlayerViewMesh=LodMesh'DeusExItems.LockpickPOV'
     PickupViewMesh=LodMesh'DeusExItems.Lockpick'
     ThirdPersonMesh=LodMesh'DeusExItems.Lockpick3rd'
     LandSound=Sound'DeusExSounds.Generic.PlasticHit2'
     Icon=Texture'DeusExUI.Icons.BeltIconLockPick'
     largeIcon=Texture'DeusExUI.Icons.LargeIconLockPick'
     largeIconWidth=45
     largeIconHeight=44
     Mesh=LodMesh'DeusExItems.Lockpick'
     CollisionRadius=7.05
     CollisionHeight=1.14
     Mass=2.000000
     Buoyancy=10.000000
}
