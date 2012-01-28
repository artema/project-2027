//=======================================================
// ������ - ���� �������. �������� Ded'�� ��� ���� 2027
// Weapon - Mini crossbow. Copyright (C) 2003 Ded
//=======================================================
class WeaponCrossbow extends GameWeapon;

state NormalFire
{
	function BeginState()
	{
		if (ClipCount >= ReloadCount)
			MultiSkins[3] = Texture'PinkMaskTex';

		if ((AmmoType != None) && (AmmoType.AmmoAmount <= 0))
			MultiSkins[3] = Texture'PinkMaskTex';
	
		Super.BeginState();
	}
}

function Tick(float deltaTime)
{
	if (MultiSkins[3] != None)
		if ((AmmoType != None) && (AmmoType.AmmoAmount > 0) && (ClipCount < ReloadCount))
			MultiSkins[3] = None;

	Super.Tick(deltaTime);
}

defaultproperties
{
	 bNewSkin=True
     PlayerViewSkins(0)=Texture'GameMedia.Skins.WeaponCrossbowHands'
     
     ShotDamage(0)=20
     ShotDamage(1)=50
     ShotDamage(2)=20

     BaseAccuracy=0.7
     MinWeaponAcc=0.1

     ShotTime=0.8
     reloadTime=1.3

     ShotUntargeting(0)=0.15
     ShotUntargeting(1)=0.15
     ShotUntargeting(2)=0.15

     ShotRecoil(0)=0.0
     ShotRecoil(1)=0.0
     ShotRecoil(2)=0.0

     ShotShake(0)=0
     ShotShake(1)=0
     ShotShake(2)=0

     maxRange=1500
     AccurateRange=800

     NoiseVolume(0)=0.05
     NoiseVolume(1)=0.05
     NoiseVolume(2)=0.05


     bCanHaveModBaseAccuracy=True
     bCanHaveModAccurateRange=True
     bCanHaveModReloadTime=True

     AmmoName=Class'DeusEx.RAmmoDartPoison'
     AmmoNames(0)=Class'DeusEx.RAmmoDartPoison'
     AmmoNames(1)=Class'DeusEx.RAmmoDart'
     AmmoNames(2)=Class'DeusEx.RAmmoDartFlare'

     ProjectileClass=Class'Game.P_DartPoison'
     ProjectileNames(0)=Class'Game.P_DartPoison'
     ProjectileNames(1)=Class'Game.P_Dart'
     ProjectileNames(2)=Class'Game.P_DartFlare'

     StunDuration=10.000000
     bHasMuzzleFlash=False
     bInstantHit=False
     bAutomatic=False
     bOldStyle=True
     
     EnviroEffective=ENVEFF_All

     ReloadCount=1
     PickupAmmoCount=4
     LowAmmoWaterMark=4

     ShotSound(0)=Sound'DeusExSounds.Weapons.MiniCrossbowFire'
     ShotSound(1)=Sound'DeusExSounds.Weapons.MiniCrossbowFire'
     ShotSound(2)=Sound'DeusExSounds.Weapons.MiniCrossbowFire'

     AltFireSound=Sound'DeusExSounds.Weapons.MiniCrossbowReloadEnd'
     CockingSound=Sound'DeusExSounds.Weapons.MiniCrossbowReload'
     SelectSound=Sound'DeusExSounds.Weapons.MiniCrossbowSelect'

     Icon=Texture'DeusExUI.Icons.BeltIconCrossbow'
     largeIcon=Texture'DeusExUI.Icons.LargeIconCrossbow'
     largeIconWidth=47
     largeIconHeight=46
     InventoryGroup=107

     GoverningSkill=Class'DeusEx.SkillWeaponPistol'

     FireOffset=(X=-25.000000,Y=8.000000,Z=14.000000)
     PlayerViewOffset=(X=25.000000,Y=-8.000000,Z=-14.000000)
     PlayerViewMesh=LodMesh'DeusExItems.MiniCrossbow'
     PickupViewMesh=LodMesh'DeusExItems.MiniCrossbowPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.MiniCrossbow3rd'
     Mesh=LodMesh'DeusExItems.MiniCrossbowPickup'
     CollisionRadius=8.000000
     CollisionHeight=1.000000
     Mass=15.000000
     RealMass=0.6
}