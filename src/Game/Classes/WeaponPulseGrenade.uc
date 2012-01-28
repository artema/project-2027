//=======================================================
// ������ - ���������� �������. �������� Ded'�� ��� ���� 2027
// Weapon - Pulse grenade. Copyright (C) 2003 Ded
//=======================================================
class WeaponPulseGrenade extends GameWeapon;

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
     PlayerViewSkins(3)=Texture'GameMedia.Skins.WeaponNewHands'
     MultiSkins(1)=Texture'DeusExItems.Skins.EMPGrenadeTex1'
     PickupViewSkins(1)=Texture'DeusExItems.Skins.EMPGrenadeTex1'
     
     HitDamage=0

     BaseAccuracy=1.0

     ShotTime=0.3
     reloadTime=0.1

     maxRange=4800
     AccurateRange=2400

     shakemag=50

     AmmoName=Class'DeusEx.RAmmoPulseGrenade'

     ProjectileClass=Class'Game.P_EMP'

     ReloadCount=1
     PickupAmmoCount=1
     LowAmmoWaterMark=1

     SelectSound=Sound'DeusExSounds.Weapons.EMPGrenadeSelect'

     Icon=Texture'DeusExUI.Icons.BeltIconEMPGrenade'
     largeIcon=Texture'DeusExUI.Icons.LargeIconEMPGrenade'
     largeIconWidth=31
     largeIconHeight=49
     InventoryGroup=120

     bInstantHit=False
     bAutomatic=False
     bOldStyle=True
     bIsGrenade=True
     bHasMuzzleFlash=False
     bHandToHand=True
     bUseAsDrawnWeapon=False
     bNeedToSetMPPickupAmmo=False
     bPenetrating=False
     GrenadeNum=2
     AITimeLimit=3.500000
     AIFireDelay=5.000000
     StunDuration=60.000000

     GoverningSkill=Class'DeusEx.SkillWeaponHeavy'
     
     FireOffset=(Y=10.000000,Z=20.000000)
     PlayerViewOffset=(X=24.000000,Y=-15.000000,Z=-19.000000)
     PlayerViewMesh=LodMesh'DeusExItems.EMPGrenade'
     PickupViewMesh=LodMesh'DeusExItems.EMPGrenadePickup'
     ThirdPersonMesh=LodMesh'DeusExItems.EMPGrenade3rd'

     Mesh=LodMesh'DeusExItems.EMPGrenadePickup'
     CollisionRadius=3.000000
     CollisionHeight=2.430000
     Mass=5.000000
     Buoyancy=2.000000
     RealMass=0.3
     
     bHideInfo=True
}