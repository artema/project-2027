//=======================================================
// ������ - ����������. �������� Ded'�� ��� ���� 2027
// Weapon - Prod. Copyright (C) 2003 Ded
//=======================================================
class WeaponRiotProd extends GameWeapon;

simulated function PlaySelectiveFiring()
{
	LoopAnim('Shoot', ShootAnimRate, 0.1);
}

function Name GetMeleeAttackAnim()
{
	return ShootAnim;
}

function name WeaponDamageType()
{
	return 'Stunned';
}

defaultproperties
{
	 NonHumanDamageMultiplier=0.0
	 
	 bNewSkin=True
     PlayerViewSkins(0)=Texture'GameMedia.Skins.WeaponNewHands'
     PlayerViewSkins(3)=Texture'GameMedia.Skins.WeaponNewHands'
     
     HitDamage=40
     bMeleeDamage=True

	 recoilStrength=0.0
	 ShotRecoil(0)=0.0

     BaseAccuracy=1.0
     MinWeaponAcc=1.0

     ShotTime=1.0
     reloadTime=3.0

     shakemag=0

     maxRange=80
     AccurateRange=80

     NoiseLevel=0.05

	 ProjectileClass=Class'Game.P_Prod'
	 
     AmmoName=Class'DeusEx.RAmmoBattery'

     ReloadCount=4
     PickupAmmoCount=4
     LowAmmoWaterMark=4

     FireSound=Sound'DeusExSounds.Weapons.ProdFire'

     AltFireSound=Sound'DeusExSounds.Weapons.ProdReloadEnd'
     CockingSound=Sound'DeusExSounds.Weapons.ProdReload'
     SelectSound=Sound'DeusExSounds.Weapons.ProdSelect'
     LandSound=Sound'DeusExSounds.Generic.DropMediumWeapon'

     Icon=Texture'DeusExUI.Icons.BeltIconProd'
     largeIcon=Texture'DeusExUI.Icons.LargeIconProd'
     largeIconWidth=49
     largeIconHeight=48
     InventoryGroup=124

     bInstantHit=True
     bAutomatic=False
     bOldStyle=False
     
     bPenetrating=False
     bHasMuzzleFlash=False
     bHandToHand=False
     bFallbackWeapon=True
     bEmitWeaponDrawn=False
     StunDuration=10.000000

     GoverningSkill=Class'DeusEx.SkillMedicine'

     FireOffset=(X=-21.000000,Y=12.000000,Z=19.000000)
     PlayerViewOffset=(X=21.000000,Y=-12.000000,Z=-19.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Prod'
     PickupViewMesh=LodMesh'DeusExItems.ProdPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.Prod3rd'
     Mesh=LodMesh'DeusExItems.ProdPickup'
     CollisionRadius=8.750000
     CollisionHeight=1.350000
     Mass=5.000000
     RealMass=0.4
     
     bHideInfo=True
}