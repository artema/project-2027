//=============================================================================
// AmmoBattery.
//=============================================================================
class AmmoBattery extends DeusExAmmo;

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
     MaxAmmo=40
     ItemName="Prod Charger"
     ItemArticle="a"
     PickupViewMesh=LodMesh'DeusExItems.TestBox'
     LandSound=Sound'DeusExSounds.Generic.PlasticHit2'
     Icon=Texture'DeusExUI.Icons.BeltIconAmmoProd'
     largeIcon=Texture'DeusExUI.Icons.LargeIconAmmoProd'
     largeIconWidth=17
     largeIconHeight=46
     Description="A portable charging unit for the riot prod."
     beltDescription="CHARGER"
     Mesh=LodMesh'DeusExItems.TestBox'
     CollisionRadius=2.100000
     CollisionHeight=5.600000
     bCollideActors=True
}
