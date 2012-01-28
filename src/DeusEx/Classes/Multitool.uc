//=============================================================================
// Multitool.
//=============================================================================
class Multitool extends SkilledTool;

// ----------------------------------------------------------------------
// TestMPBeltSpot()
// Returns true if the suggested belt location is ok for the object in mp.
// ----------------------------------------------------------------------

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return (BeltSpot == 8);
}


simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	// If this is a netgame, then override defaults
	if ( Level.NetMode != NM_StandAlone )
		MaxCopies = 5;
   
}

defaultproperties
{
	 bNewSkin=True     
     PlayerViewSkins(1)=Texture'GameMedia.Skins.WeaponNewHands'
     PlayerViewSkins(5)=Texture'GameMedia.Skins.WeaponNewHands'
     UseSound=Sound'DeusExSounds.Generic.MultitoolUse'
     maxCopies=12
     bCanHaveMultipleCopies=True
     PlayerViewOffset=(X=20.000000,Y=10.000000,Z=-16.000000)
     PlayerViewMesh=LodMesh'DeusExItems.MultitoolPOV'
     PickupViewMesh=LodMesh'DeusExItems.Multitool'
     ThirdPersonMesh=LodMesh'DeusExItems.Multitool3rd'
     LandSound=Sound'DeusExSounds.Generic.PlasticHit2'
     Icon=Texture'DeusExUI.Icons.BeltIconMultitool'
     largeIcon=Texture'DeusExUI.Icons.LargeIconMultitool'
     largeIconWidth=28
     largeIconHeight=46
     Mesh=LodMesh'DeusExItems.Multitool'
     CollisionRadius=4.800000
     CollisionHeight=0.860000
     Mass=4.000000
     Buoyancy=10.000000
}
