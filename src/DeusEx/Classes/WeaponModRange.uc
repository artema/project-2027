//================================================================================
// WeaponModRange.
//================================================================================
class WeaponModRange extends WeaponMod;

function ApplyMod (DeusExWeapon Weapon)
{
	if ( Weapon != None )
	{
		Weapon.AccurateRange += Weapon.Default.AccurateRange * WeaponModifier;
		Weapon.ModAccurateRange += WeaponModifier;
	}
}

simulated function bool CanUpgradeWeapon (DeusExWeapon Weapon)
{
	if ( Weapon != None )
	{
		return Weapon.bCanHaveModAccurateRange &&  !Weapon.HasMaxRangeMod();
	}
	else
	{
		return False;
	}
}

defaultproperties
{
     WeaponModifier=0.25
     Icon=Texture'DeusExUI.Icons.BeltIconWeaponModRange'
     largeIcon=Texture'DeusExUI.Icons.LargeIconWeaponModRange'
     Skin=Texture'GameMedia.Skins.ModRangeTex0'
}