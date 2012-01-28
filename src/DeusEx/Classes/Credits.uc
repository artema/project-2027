//=============================================================================
// Credits.
//=============================================================================
class Credits extends DeusExPickup;

var() int numCredits;
var localized String msgCreditsAdded;

// ----------------------------------------------------------------------
// Frob()
//
// Add these credits to the player's credits count
// ----------------------------------------------------------------------
auto state Pickup
{
	function Frob(Actor Frobber, Inventory frobWith)
	{
		local DeusExPlayer player;

		Super.Frob(Frobber, frobWith);

		player = DeusExPlayer(Frobber);

		if (player != None)
		{
			player.Credits += numCredits;
			player.ClientMessage(Sprintf(msgCreditsAdded, numCredits));
			player.FrobTarget = None;
			Destroy();
		}
	}
}

defaultproperties
{
     MultiSkins(0)=Texture'GameMedia.Skins.CreditsSheetTex0'
     numCredits=100
     msgCreditsAdded="На ваш счет зачисленно %d кредитов"
     ItemName="Кредитная расписка"
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Credits'
     PickupViewMesh=LodMesh'DeusExItems.Credits'
     ThirdPersonMesh=LodMesh'DeusExItems.Credits'
     LandSound=Sound'DeusExSounds.Generic.PlasticHit1'
     Icon=Texture'DeusExUI.Icons.BeltIconCredits'
     beltDescription="Кредиты"
     Mesh=LodMesh'DeusExItems.Credits'
     CollisionRadius=6.000000
     CollisionHeight=0.550000
     Mass=2.000000
     Buoyancy=3.000000
}
