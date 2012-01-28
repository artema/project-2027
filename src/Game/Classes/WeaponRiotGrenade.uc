//=======================================================
// ������ - ������� �������. �������� Ded'�� ��� ���� 2027
// Weapon - Gas grenade. Copyright (C) 2003 Ded
//=======================================================
class WeaponRiotGrenade extends GameWeapon;

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

defaultproperties
{
	 bNewSkin=True
     PlayerViewSkins(0)=Texture'GameMedia.Skins.WeaponNewHands'
     PlayerViewSkins(1)=Texture'GameMedia.Skins.WeaponNewHands'
     MultiSkins(0)=Texture'DeusExItems.Skins.GasGrenadeTex1'
     PickupViewSkins(0)=Texture'DeusExItems.Skins.GasGrenadeTex1'
     
     HitDamage=0

     BaseAccuracy=1.0

     ShotTime=0.3
     reloadTime=0.1

     maxRange=4800
     AccurateRange=2400

     shakemag=50

     AmmoName=Class'DeusEx.RAmmoRiotGrenade'

     ProjectileClass=Class'Game.P_RiotGrenade'

     ReloadCount=1
     PickupAmmoCount=1
     LowAmmoWaterMark=1

     SelectSound=Sound'DeusExSounds.Weapons.GasGrenadeSelect'

     Icon=Texture'DeusExUI.Icons.BeltIconGasGrenade'
     largeIcon=Texture'DeusExUI.Icons.LargeIconGasGrenade'
     largeIconWidth=23
     largeIconHeight=46
     InventoryGroup=129

     bInstantHit=False
     bAutomatic=False
     bOldStyle=True
     bIsGrenade=True
     bHasMuzzleFlash=False
     bHandToHand=True
     bUseAsDrawnWeapon=False
     bPenetrating=False
     bNeedToSetMPPickupAmmo=False
     GrenadeNum=4
     AITimeLimit=3.500000
     AIFireDelay=5.000000
     StunDuration=60.000000

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