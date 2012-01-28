//================================================================================
// WeaponModReload.
//================================================================================
class WeaponModReload extends WeaponMod;

function ApplyMod (DeusExWeapon Weapon)
{
	if ( Weapon != None )
	{
		Weapon.reloadTime += Weapon.Default.reloadTime * WeaponModifier;
		if ( Weapon.reloadTime < 0.00 )
		{
			Weapon.reloadTime=0.00;
		}
		Weapon.ModReloadTime += WeaponModifier;
	}
}

simulated function bool CanUpgradeWeapon (DeusExWeapon Weapon)
{
	if ( Weapon != None )
	{
		return Weapon.bCanHaveModReloadTime &&  !Weapon.HasMaxReloadMod();
	}
	else
	{
		return False;
	}
}

defaultproperties
{
     WeaponModifier=-0.25
     Icon=Texture'DeusExUI.Icons.BeltIconWeaponModReload'
     largeIcon=Texture'DeusExUI.Icons.LargeIconWeaponModReload'
     Skin=Texture'GameMedia.Skins.ModReloadTex0'
}