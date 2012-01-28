//=============================================================================
// AmmoRocketMini.
//=============================================================================
class AmmoRocketMini extends DeusExAmmo;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	log("***2027 - Fuck! Another bug found!***");
	Destroy();
}

defaultproperties
{
     AmmoAmount=20
     MaxAmmo=60
     PickupViewMesh=LodMesh'DeusExItems.TestBox'
     Mesh=LodMesh'DeusExItems.TestBox'
     CollisionRadius=22.500000
     CollisionHeight=16.000000
     bCollideActors=True
}
