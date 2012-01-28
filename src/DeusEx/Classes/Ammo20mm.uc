//=============================================================================
// Ammo20mm.
//=============================================================================
class Ammo20mm extends DeusExAmmo;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	log("***2027 - Fuck! Another bug found!***");
	Destroy();
}

defaultproperties
{
     bShowInfo=True
     AmmoAmount=4
     MaxAmmo=32
     ItemName="20mm HE Ammo"
     ItemArticle="some"     
     LandSound=Sound'DeusExSounds.Generic.MetalHit1'
     Icon=Texture'DeusExUI.Icons.BeltIconAmmo20mm'
     largeIcon=Texture'DeusExUI.Icons.LargeIconAmmo20mm'
     largeIconWidth=47
     largeIconHeight=37
     Description="The 20mm high-explosive round complements the standard 7.62x51mm assault rifle by adding the capability to clear small rooms, foxholes, and blind corners using an underhand launcher."
     beltDescription="20MM AMMO"
     Mesh=LodMesh'DeusExItems.TestBox'
     PickupViewMesh=LodMesh'DeusExItems.TestBox'
     CollisionRadius=9.500000
     CollisionHeight=4.750000
     bCollideActors=True
}
