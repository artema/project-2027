//=============================================================================
// AmmoLAM.
//=============================================================================
class AmmoLAM extends DeusExAmmo;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	log("***2027 - Fuck! Another bug found!***");
	Destroy();
}

defaultproperties
{
     AmmoAmount=1
     MaxAmmo=10
     PickupViewMesh=LodMesh'DeusExItems.TestBox'
     Mesh=LodMesh'DeusExItems.TestBox'
     Icon=Texture'DeusExUI.Icons.BeltIconLAM'
     beltDescription="LAM"     
     CollisionRadius=22.500000
     CollisionHeight=16.000000
     bCollideActors=True
}
