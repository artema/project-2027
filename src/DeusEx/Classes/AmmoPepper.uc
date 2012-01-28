//=============================================================================
// AmmoPepper.
//=============================================================================
class AmmoPepper extends DeusExAmmo;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	log("***2027 - Fuck! Another bug found!***");
	Destroy();
}

defaultproperties
{
     bShowInfo=True
     AmmoAmount=100
     MaxAmmo=400
     ItemName="Pepper Cartridge"
     ItemArticle="a"
     PickupViewMesh=LodMesh'DeusExItems.TestBox'
     LandSound=Sound'DeusExSounds.Generic.GlassHit1'
     Icon=Texture'DeusExUI.Icons.BeltIconAmmoPepper'
     largeIconWidth=19
     largeIconHeight=45
     Description="'ANTIGONE pepper spray will incapacitate your attacker in UNDER TWO SECONDS. ANTIGONE -- better BLIND than DEAD. NOTE: Keep away from children under the age of five. Contents under pressure.'"
     beltDescription="PPR CART"
     Mesh=LodMesh'DeusExItems.TestBox'
     CollisionRadius=1.440000
     CollisionHeight=3.260000
     bCollideActors=True
}
