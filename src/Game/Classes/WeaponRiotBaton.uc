//=======================================================
// ������ - �������. �������� Ded'�� ��� ���� 2027
// Weapon - Baton. Copyright (C) 2003 Ded
//=======================================================
class WeaponRiotBaton extends GameWeapon;

function name WeaponDamageType()
{
	return 'KnockedOut';
}

defaultproperties
{
	 NonHumanDamageMultiplier=0.2
	 
	 bNewSkin=True
     PlayerViewSkins(1)=Texture'GameMedia.Skins.WeaponNewHands'
     PlayerViewSkins(2)=Texture'GameMedia.Skins.WeaponNewHands'
     
     HitDamage=30
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

     FireSound=Sound'DeusExSounds.Weapons.BatonFire'

     SelectSound=Sound'DeusExSounds.Weapons.CombatKnifeSelect'
     SelectSound=Sound'DeusExSounds.Weapons.BatonSelect'
     Misc1Sound=Sound'DeusExSounds.Weapons.BatonHitFlesh'
     Misc2Sound=Sound'DeusExSounds.Weapons.BatonHitHard'
     Misc3Sound=Sound'DeusExSounds.Weapons.BatonHitSoft'
     LandSound=Sound'DeusExSounds.Generic.DropMediumWeapon'

     Icon=Texture'DeusExUI.Icons.BeltIconBaton'
     largeIcon=Texture'DeusExUI.Icons.LargeIconBaton'
     largeIconWidth=46
     largeIconHeight=47
     InventoryGroup=122

     bPenetrating=False
     bHasMuzzleFlash=False
     bHandToHand=True
     bFallbackWeapon=True
     bEmitWeaponDrawn=False

     GoverningSkill=Class'DeusEx.SkillMedicine'

     FireOffset=(X=-24.000000,Y=14.000000,Z=17.000000)
     PlayerViewOffset=(X=24.000000,Y=-14.000000,Z=-17.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Baton'
     PickupViewMesh=LodMesh'DeusExItems.BatonPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.Baton3rd'
     Mesh=LodMesh'DeusExItems.BatonPickup'
     CollisionRadius=14.000000
     CollisionHeight=1.000000
     Mass=5.000000
     RealMass=0.7
}