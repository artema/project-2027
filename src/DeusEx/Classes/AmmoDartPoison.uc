//=============================================================================
// AmmoDartPoison.
//=============================================================================
class AmmoDartPoison extends AmmoDart;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	log("***2027 - Fuck! Another bug found!***");
	Destroy();
}

defaultproperties
{
     ItemName="Tranquilizer Darts"
     Icon=Texture'DeusExUI.Icons.BeltIconAmmoDartsPoison'
     largeIcon=Texture'DeusExUI.Icons.LargeIconAmmoDartsPoison'
     Description="A mini-crossbow dart tipped with a succinylcholine-variant that causes complete skeletal muscle relaxation, effectively incapacitating a target in a non-lethal manner."
     beltDescription="TRQ DART"
     Skin=Texture'DeusExItems.Skins.AmmoDartTex3'
}
