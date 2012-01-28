//=======================================================
// ������ - ���. �������� Ded'�� ��� ���� 2027
// Weapon - Knife. Copyright (C) 2003 Ded
//=======================================================
class WeaponKnife extends GameWeapon;

defaultproperties
{
	 NonHumanDamageMultiplier=0.4
	 
	 bNewSkin=True
     PlayerViewSkins(1)=Texture'GameMedia.Skins.WeaponNewHands'
     
     HitDamage=19
     bMeleeDamage=True
     EnviroEffective=ENVEFF_All

     BaseAccuracy=1.0

     ShotTime=0.08
     reloadTime=0.0

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

     FireSound=Sound'GameMedia.Weapons.KnifeFire'

     SelectSound=Sound'DeusExSounds.Weapons.CombatKnifeSelect'
     Misc1Sound=Sound'DeusExSounds.Weapons.CombatKnifeHitFlesh'
     Misc2Sound=Sound'DeusExSounds.Weapons.CombatKnifeHitHard'
     Misc3Sound=Sound'DeusExSounds.Weapons.CombatKnifeHitSoft'
     LandSound=Sound'DeusExSounds.Generic.DropMediumWeapon'

     Icon=Texture'DeusExUI.Icons.BeltIconCombatKnife'
     largeIcon=Texture'DeusExUI.Icons.LargeIconCombatKnife'
     largeIconWidth=49
     largeIconHeight=45
     InventoryGroup=112

     bPenetrating=False
     bHasMuzzleFlash=False
     bHandToHand=True
     bFallbackWeapon=True
     bEmitWeaponDrawn=False

     GoverningSkill=Class'DeusEx.SkillMedicine'

     FireOffset=(X=-5.000000,Y=8.000000,Z=14.000000)
     PlayerViewOffset=(X=5.000000,Y=-8.000000,Z=-14.000000)
     PlayerViewMesh=LodMesh'DeusExItems.CombatKnife'
     PickupViewMesh=LodMesh'DeusExItems.CombatKnifePickup'
     ThirdPersonMesh=LodMesh'DeusExItems.CombatKnife3rd'
     Mesh=LodMesh'DeusExItems.CombatKnifePickup'
     Texture=Texture'DeusExItems.Skins.ReflectionMapTex1'
     CollisionRadius=12.650000
     CollisionHeight=0.800000
     Mass=5.000000
     RealMass=0.4
}