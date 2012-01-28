//================================================================================
// WeaponModSilencer.
//================================================================================
class WeaponModSilencer extends WeaponMod;

function ApplyMod (DeusExWeapon Weapon)
{
	if ( Weapon != None )
	{
		Weapon.bHasSilencer=True;
		Weapon.bHasMuzzleFlash=False;
	}
}

simulated function bool CanUpgradeWeapon (DeusExWeapon Weapon)
{
	if ( Weapon != None )
	{
		return Weapon.bCanHaveSilencer &&  !Weapon.bHasSilencer;
	}
	else
	{
		return False;
	}
}

defaultproperties
{
	 Mesh=LodMesh'DeusExItems.TestBox'
     Icon=Texture'DeusExUI.Icons.BeltIconWeaponModSilencer'
     largeIcon=Texture'DeusExUI.Icons.LargeIconWeaponModSilencer'
     Skin=Texture'GameMedia.Skins.ModSilencerTex0'
}