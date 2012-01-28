//=============================================================================
// AmmoDartFlare.
//=============================================================================
class AmmoDartFlare extends AmmoDart;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	log("***2027 - Fuck! Another bug found!***");
	Destroy();
}

defaultproperties
{
     ItemName="Flare Darts"
     Icon=Texture'DeusExUI.Icons.BeltIconAmmoDartsFlare'
     largeIcon=Texture'DeusExUI.Icons.LargeIconAmmoDartsFlare'
     Description="Mini-crossbow flare darts use a slow-burning incendiary device, ignited on impact, to provide illumination of a targeted area."
     beltDescription="FLR DART"
     Skin=Texture'DeusExItems.Skins.AmmoDartTex2'
}
