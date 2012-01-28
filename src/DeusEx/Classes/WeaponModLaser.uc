//================================================================================
// WeaponModLaser.
//================================================================================
class WeaponModLaser extends WeaponMod;

function ApplyMod (DeusExWeapon Weapon)
{
	if ( Weapon != None )
	{
		Weapon.bHasLaser=True;
	}
}

simulated function bool CanUpgradeWeapon (DeusExWeapon Weapon)
{
	if ( Weapon != None )
	{
		return Weapon.bCanHaveLaser &&  !Weapon.bHasLaser;
	}
	else
	{
		return False;
	}
}

defaultproperties
{
	 Mesh=LodMesh'DeusExItems.TestBox'
     Icon=Texture'DeusExUI.Icons.BeltIconWeaponModLaser'
     largeIcon=Texture'DeusExUI.Icons.LargeIconWeaponModLaser'
     Skin=Texture'GameMedia.Skins.ModLaserTex0'
}