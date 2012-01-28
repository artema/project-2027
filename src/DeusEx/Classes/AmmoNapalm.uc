//=============================================================================
// AmmoNapalm.
//=============================================================================
class AmmoNapalm extends DeusExAmmo;

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
     ItemName="Napalm Canister"
     ItemArticle="a"
     PickupViewMesh=LodMesh'DeusExItems.TestBox'
     LandSound=Sound'DeusExSounds.Generic.GlassDrop'
     Icon=Texture'DeusExUI.Icons.BeltIconAmmoNapalm'
     largeIcon=Texture'DeusExUI.Icons.LargeIconAmmoNapalm'
     largeIconWidth=46
     largeIconHeight=42
     Description="A pressurized canister of jellied gasoline for use with flamethrowers.|n|n<UNATCO OPS FILE NOTE SC080-BLUE> The canister is double-walled to minimize accidental detonation caused by stray bullets during a firefight. -- Sam Carter <END NOTE>"
     beltDescription="NAPALM"
     Mesh=LodMesh'DeusExItems.TestBox'
     CollisionRadius=3.130000
     CollisionHeight=11.480000
     bCollideActors=True
}
