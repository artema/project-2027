//================================================================================
// WeaponMod.
//================================================================================
class WeaponMod extends DeusExPickup
	abstract;

var() float WeaponModifier;
var localized string DragToUpgrade;

replication
{
	reliable if ( Role < 4 )
		DestroyMod,ApplyMod;
}

function PostBeginPlay ()
{
	Super.PostBeginPlay();
	LoopAnim('Cycle');
}

function ApplyMod (DeusExWeapon Weapon)
{
}

function bool CanUpgradeWeapon (DeusExWeapon Weapon)
{
}

function DestroyMod ()
{
	NumCopies--;

	if(NumCopies<=0)
		Destroy();
}

simulated function bool UpdateInfo (Object winObject)
{
	local PersonaInfoWindow winInfo;

	winInfo=PersonaInfoWindow(winObject);
	if ( winInfo == None )
	{
		return False;
	}
	winInfo.Clear();
	winInfo.SetTitle(ItemName);
	winInfo.SetText(Description $ winInfo.CR() $ winInfo.CR());
	winInfo.AppendText(DragToUpgrade);
	return True;
}

defaultproperties
{
    bCanHaveMultipleCopies=True
    PlayerViewOffset=(X=30.00, Y=0.00, Z=-12.00)
    PlayerViewMesh=LodMesh'DeusExItems.WeaponMod'
    PickupViewMesh=LodMesh'DeusExItems.WeaponMod'
    ThirdPersonMesh=LodMesh'DeusExItems.WeaponMod'
    LandSound=Sound'DeusExSounds.Generic.PlasticHit1'
    largeIconWidth=34
    largeIconHeight=49
    Mesh=LodMesh'DeusExItems.WeaponMod'
    CollisionRadius=3.50
    CollisionHeight=4.42
    Mass=1.00
}