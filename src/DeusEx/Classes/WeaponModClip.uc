//================================================================================
// WeaponModClip.
//================================================================================
class WeaponModClip extends WeaponMod;

function ApplyMod (DeusExWeapon Weapon)
{
	local int diff;

	if ( Weapon != None )
	{
		diff=Weapon.Default.ReloadCount * WeaponModifier;
		if ( diff < 1 )
		{
			diff=1;
		}
		Weapon.ReloadCount += diff;
		Weapon.ModReloadCount += WeaponModifier;
	}
}

simulated function bool CanUpgradeWeapon (DeusExWeapon Weapon)
{
	if ( Weapon != None )
	{
		return Weapon.bCanHaveModReloadCount &&  !Weapon.HasMaxClipMod();
	}
	else
	{
		return False;
	}
}

defaultproperties
{
     WeaponModifier=0.25
     Icon=Texture'DeusExUI.Icons.BeltIconWeaponModClip'
     largeIcon=Texture'DeusExUI.Icons.LargeIconWeaponModClip'
     Skin=Texture'GameMedia.Skins.ModClipTex0'
}