//=============================================================================
// WeaponSword.
//=============================================================================
class WeaponChinaSword extends GameWeapon;

defaultproperties
{
	 NonHumanDamageMultiplier=0.5
	 
     bNewSkin=True
     PlayerViewSkins(0)=Texture'GameMedia.Skins.WeaponNewHands'
     PlayerViewSkins(2)=Texture'GameMedia.Skins.WeaponNewHands'
     
     HitDamage=33
     bMeleeDamage=True
     EnemyEffective=ENMEFF_Organic
     EnviroEffective=ENVEFF_All

     BaseAccuracy=1.0

     ShotTime=0.08
     reloadTime=0.0

     shakemag=200

     maxRange=64
     AccurateRange=64

     NoiseLevel=0.05

     AmmoName=Class'DeusEx.AmmoNone'

     ReloadCount=0
     LowAmmoWaterMark=0

	 invSlotsX=3

     bInstantHit=True
     bAutomatic=False
     bOldStyle=True

     FireSound=Sound'DeusExSounds.Weapons.SwordFire'
     
     SelectSound=Sound'DeusExSounds.Weapons.SwordSelect'
     Misc1Sound=Sound'DeusExSounds.Weapons.SwordHitFlesh'
     Misc2Sound=Sound'DeusExSounds.Weapons.SwordHitHard'
     Misc3Sound=Sound'DeusExSounds.Weapons.SwordHitSoft'
     LandSound=Sound'DeusExSounds.Generic.DropLargeWeapon'

     Icon=Texture'DeusExUI.Icons.BeltIconSword'
     largeIcon=Texture'DeusExUI.Icons.LargeIconSword'
     largeIconWidth=130
     largeIconHeight=40
     InventoryGroup=18182

     bPenetrating=False
     bHasMuzzleFlash=False
     bHandToHand=True
     bFallbackWeapon=True
     bEmitWeaponDrawn=False

     GoverningSkill=Class'DeusEx.SkillMedicine'

     FireOffset=(X=-25.000000,Y=10.000000,Z=24.000000)
     PlayerViewOffset=(X=25.000000,Y=-10.000000,Z=-24.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Sword'
     PickupViewMesh=LodMesh'DeusExItems.SwordPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.Sword3rd'
     Mesh=LodMesh'DeusExItems.SwordPickup'
     Texture=Texture'DeusExItems.Skins.ReflectionMapTex1'
     CollisionRadius=26.000000
     CollisionHeight=0.500000
     Mass=20.000000
     RealMass=2.0
}