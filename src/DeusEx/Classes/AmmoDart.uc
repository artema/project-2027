//=============================================================================
// AmmoDart.
//=============================================================================
class AmmoDart extends DeusExAmmo;

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
     MaxAmmo=60
     ItemName="Darts"
     ItemArticle=""
     PickupViewMesh=LodMesh'DeusExItems.TestBox'
     LandSound=Sound'DeusExSounds.Generic.PaperHit2'
     Icon=Texture'DeusExUI.Icons.BeltIconAmmoDartsNormal'
     largeIcon=Texture'DeusExUI.Icons.LargeIconAmmoDartsNormal'
     largeIconWidth=20
     largeIconHeight=47
     Description="The mini-crossbow dart is a favored weapon for many 'wet' operations; however, silent kills require a high degree of skill."
     beltDescription="DART"
     Mesh=LodMesh'DeusExItems.TestBox'
     CollisionRadius=8.500000
     CollisionHeight=2.000000
     bCollideActors=True
}
