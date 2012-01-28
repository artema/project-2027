//================================================================================
// WeaponModRecoil.
//================================================================================
class WeaponModRecoil extends WeaponMod;

function ApplyMod (DeusExWeapon Weapon)
{
	if ( Weapon != None )
	{
		//Weapon.recoilStrength += Weapon.Default.recoilStrength * WeaponModifier;
		/*if ( Weapon.recoilStrength < 0.00 )
		{
			Weapon.recoilStrength=0.00;
		}*/
		Weapon.ModRecoilStrength += WeaponModifier;
	}
}

simulated function bool CanUpgradeWeapon (DeusExWeapon Weapon)
{
	if ( Weapon != None )
	{
		return Weapon.bCanHaveModRecoilStrength &&  !Weapon.HasMaxRecoilMod();
	}
	else
	{
		return False;
	}
}

defaultproperties
{
     WeaponModifier=-0.25
     Icon=Texture'DeusExUI.Icons.BeltIconWeaponModRecoil'
     largeIcon=Texture'DeusExUI.Icons.LargeIconWeaponModRecoil'
     Skin=Texture'GameMedia.Skins.ModRecoilTex0'
}