//=============================================================================
// Rebreather.
//=============================================================================
class Rebreather extends ChargedPickup;

function ChargedPickupUpdate(DeusExPlayer Player)
{
	Super.ChargedPickupUpdate(Player);

	Player.swimTimer = Player.swimDuration;
}

defaultproperties
{
	 Charge=3000
     LoopSound=Sound'DeusExSounds.Pickup.RebreatherLoop'
     ChargedIcon=Texture'DeusExUI.Icons.ChargedIconRebreather'
     PlayerViewOffset=(X=30.000000,Z=-6.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Rebreather'
     PickupViewMesh=LodMesh'DeusExItems.Rebreather'
     ThirdPersonMesh=LodMesh'DeusExItems.Rebreather'
     LandSound=Sound'DeusExSounds.Generic.PaperHit2'
     Icon=Texture'DeusExUI.Icons.BeltIconRebreather'
     largeIcon=Texture'DeusExUI.Icons.LargeIconRebreather'
     largeIconWidth=44
     largeIconHeight=34
     Mesh=LodMesh'DeusExItems.Rebreather'
     CollisionRadius=6.900000
     CollisionHeight=3.610000
     Mass=10.000000
     Buoyancy=8.000000
}
