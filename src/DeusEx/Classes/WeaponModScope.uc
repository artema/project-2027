//================================================================================
// WeaponModScope.
//================================================================================
class WeaponModScope extends WeaponMod;

function ApplyMod (DeusExWeapon Weapon)
{
	if ( Weapon != None )
	{
		Weapon.bHasScope=True;
	}
}

simulated function bool CanUpgradeWeapon (DeusExWeapon Weapon)
{
	if ( Weapon != None )
	{
		return Weapon.bCanHaveScope &&  !Weapon.bHasScope;
	}
	else
	{
		return False;
	}
}

defaultproperties
{
	Mesh=LodMesh'DeusExItems.TestBox'
    Icon=Texture'DeusExUI.Icons.BeltIconWeaponModScope'
    largeIcon=Texture'DeusExUI.Icons.LargeIconWeaponModScope'
    Skin=Texture'GameMedia.Skins.ModScopeTex0'
}