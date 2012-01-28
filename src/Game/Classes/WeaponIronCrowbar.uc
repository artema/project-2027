//=======================================================
// ������ - ���. �������� Ded'�� ��� ���� 2027
// Weapon - Crowbar. Copyright (C) 2003 Ded
//=======================================================
class WeaponIronCrowbar extends GameWeapon;

defaultproperties
{
	 NonHumanDamageMultiplier=0.85
	 
	 bNewSkin=True
     PlayerViewSkins(1)=Texture'GameMedia.Skins.WeaponNewHands'
     PlayerViewSkins(2)=Texture'GameMedia.Skins.WeaponNewHands'
     
     HitDamage=25
     bMeleeDamage=True
     EnviroEffective=ENVEFF_All

     BaseAccuracy=1.0

     ShotTime=0.08
     reloadTime=0.0

     ShotDeaccuracy=0.0

     recoilStrength=0.0

     shakemag=200

     maxRange=80
     AccurateRange=80

     NoiseLevel=0.05

     AmmoName=Class'DeusEx.AmmoNone'

     ReloadCount=0
     LowAmmoWaterMark=0

     bInstantHit=True
     bAutomatic=False
     bOldStyle=True

     FireSound=Sound'DeusExSounds.Weapons.CrowbarFire'

     SelectSound=Sound'DeusExSounds.Weapons.CrowbarSelect'
     Misc1Sound=Sound'DeusExSounds.Weapons.CrowbarHitFlesh'
     Misc2Sound=Sound'DeusExSounds.Weapons.CrowbarHitHard'
     Misc3Sound=Sound'DeusExSounds.Weapons.CrowbarHitSoft'
     LandSound=Sound'DeusExSounds.Generic.DropMediumWeapon'

     Icon=Texture'DeusExUI.Icons.BeltIconCrowbar'
     largeIcon=Texture'DeusExUI.Icons.LargeIconCrowbar'
     largeIconWidth=101
     largeIconHeight=43
     invSlotsX=2
     InventoryGroup=111

     bPenetrating=False
     bHasMuzzleFlash=False
     bHandToHand=True
     bFallbackWeapon=True
     bEmitWeaponDrawn=False
     bOldStyle=True

     GoverningSkill=Class'DeusEx.SkillMedicine'

     FireOffset=(X=-40.000000,Y=15.000000,Z=8.000000)
     PlayerViewOffset=(X=40.000000,Y=-15.000000,Z=-8.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Crowbar'
     PickupViewMesh=LodMesh'DeusExItems.CrowbarPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.Crowbar3rd'
     Mesh=LodMesh'DeusExItems.CrowbarPickup'
     CollisionRadius=19.000000
     CollisionHeight=1.050000
     Mass=15.000000
     RealMass=1.0
}