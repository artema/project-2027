//================================================================================
// WeaponModAccuracy.
//================================================================================
class WeaponModAccuracy extends WeaponMod;

function ApplyMod (DeusExWeapon Weapon)
{
	if ( Weapon != None )
	{
		if ( Weapon.BaseAccuracy == 0.00 )
		{
			Weapon.BaseAccuracy -= WeaponModifier;
		}
		else
		{
			Weapon.BaseAccuracy -= Weapon.Default.BaseAccuracy * WeaponModifier;
		}
		Weapon.ModBaseAccuracy += WeaponModifier;
	}
}

simulated function bool CanUpgradeWeapon (DeusExWeapon Weapon)
{
	if ( Weapon != None )
	{
		return Weapon.bCanHaveModBaseAccuracy &&  !Weapon.HasMaxAccuracyMod();
	}
	else
	{
		return False;
	}
}

defaultproperties
{
     Skin=Texture'GameMedia.Skins.ModAccuracyTex0'
     WeaponModifier=0.25
     Icon=Texture'DeusExUI.Icons.BeltIconWeaponModAccuracy'
     largeIcon=Texture'DeusExUI.Icons.LargeIconWeaponModAccuracy'
}