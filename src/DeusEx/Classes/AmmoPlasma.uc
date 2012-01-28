//=============================================================================
// AmmoPlasma.
//=============================================================================
class AmmoPlasma extends DeusExAmmo;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	log("***2027 - Fuck! Another bug found!***");
	Destroy();
}

defaultproperties
{
     bShowInfo=True
     AmmoAmount=12
     MaxAmmo=84
     ItemName="Plasma Clip"
     ItemArticle=""
     PickupViewMesh=LodMesh'DeusExItems.TestBox'
     LandSound=Sound'DeusExSounds.Generic.PlasticHit2'
     Icon=Texture'DeusExUI.Icons.BeltIconAmmoPlasma'
     largeIconWidth=22
     largeIconHeight=46
     Description="A clip of extruded, magnetically-doped plastic slugs that can be heated and delivered with devastating effect using the plasma gun."
     beltDescription="PMA CLIP"
     Mesh=LodMesh'DeusExItems.TestBox'
     CollisionRadius=4.300000
     CollisionHeight=8.440000
     bCollideActors=True
}
