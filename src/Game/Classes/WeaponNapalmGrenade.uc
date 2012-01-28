//=======================================================
// ������ - ����������� �������. �������� Ded'�� ��� ���� 2027
// Weapon - Flame grenade. Copyright (C) 2003 Ded
//=======================================================
class WeaponNapalmGrenade extends GameWeapon;

function Fire(float Value)
{
	if (Pawn(Owner) != None)
	{
		if (bNearWall)
		{
			bReadyToFire = False;
			GotoState('NormalFire');
			bPointing = True;
			PlayAnim('Place',, 0.1);
			return;
		}
	}
	Super.Fire(Value);
}

function Projectile ProjectileFire(class<projectile> ProjClass, float ProjSpeed, bool bWarn)
{
	local Projectile proj;

	proj = Super.ProjectileFire(ProjClass, ProjSpeed, bWarn);

	if (proj != None)
		proj.PlayAnim('Open');
}

defaultproperties
{
	 bNewSkin=True
     PlayerViewSkins(0)=Texture'GameMedia.Skins.WeaponNewHands'
     PlayerViewSkins(1)=Texture'GameMedia.Skins.WeaponNewHands'
     PlayerViewSkins(2)=Texture'GameMedia.Skins.NapalmGrenadeTex0'
     PickupViewSkins(0)=Texture'GameMedia.Skins.NapalmGrenadeTex0'
     MultiSkins(0)=Texture'GameMedia.Skins.NapalmGrenadeTex0'
     
     HitDamage=0

     BaseAccuracy=1.0

     ShotTime=0.3
     reloadTime=0.1

     maxRange=4800
     AccurateRange=2400

     shakemag=50.000000

     AmmoName=Class'DeusEx.RAmmoNapalmGrenade'

     ProjectileClass=Class'Game.P_NapalmGrenade'

     ReloadCount=1
     PickupAmmoCount=1
     LowAmmoWaterMark=1

     SelectSound=Sound'DeusExSounds.Weapons.GasGrenadeSelect'

     Icon=Texture'Game.Icons.BeltIconNapalmGrenade'
     largeIcon=Texture'Game.Icons.LargeIconNapalmGrenade'
     largeIconWidth=23
     largeIconHeight=46
     InventoryGroup=118

     bInstantHit=False
     bAutomatic=False
     bOldStyle=True
     bIsGrenade=True
     bHasMuzzleFlash=False
     bHandToHand=True
     bUseAsDrawnWeapon=False
     bNeedToSetMPPickupAmmo=False
     GrenadeNum=1
     AITimeLimit=3.500000
     AIFireDelay=5.000000

     GoverningSkill=Class'DeusEx.SkillWeaponHeavy'
     
     FireOffset=(Y=10.000000,Z=20.000000)
     PlayerViewOffset=(Y=-13.000000,Z=-19.000000)
     PlayerViewMesh=LodMesh'DeusExItems.GasGrenade'
     PickupViewMesh=LodMesh'DeusExItems.GasGrenadePickup'
     ThirdPersonMesh=LodMesh'DeusExItems.GasGrenade3rd'
     Mesh=LodMesh'DeusExItems.GasGrenadePickup'
     CollisionRadius=2.300000
     CollisionHeight=3.300000
     Mass=5.000000
     Buoyancy=2.000000
     RealMass=0.3
     
     bHideInfo=True
}