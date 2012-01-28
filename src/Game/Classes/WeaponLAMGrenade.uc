//=======================================================
// ������ - LAM. �������� Ded'�� ��� ���� 2027
// Weapon - LAM. Copyright (C) 2003 Ded
//=======================================================
class WeaponLAMGrenade extends GameWeapon;

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
     PlayerViewSkins(2)=Texture'GameMedia.Skins.WeaponNewHands'
     
     HitDamage=50

     BaseAccuracy=1.0

     ShotTime=0.3
     reloadTime=0.1

     maxRange=4800
     AccurateRange=2400

     shakemag=50

     AmmoName=Class'DeusEx.RAmmoLAMGrenade'

     ProjectileClass=Class'Game.P_LAM'

     ReloadCount=1
     PickupAmmoCount=1
     LowAmmoWaterMark=1

     SelectSound=Sound'DeusExSounds.Weapons.LAMSelect'

     Icon=Texture'DeusExUI.Icons.BeltIconLAM'
     largeIcon=Texture'DeusExUI.Icons.LargeIconLAM'
     largeIconWidth=35
     largeIconHeight=45
     InventoryGroup=113

     bInstantHit=False
     bAutomatic=False
     bOldStyle=True
     bIsGrenade=True
     bHasMuzzleFlash=False
     bHandToHand=True
     bUseAsDrawnWeapon=False
     bNeedToSetMPPickupAmmo=False
     GrenadeNum=0
     AITimeLimit=3.500000
     AIFireDelay=5.000000

     GoverningSkill=Class'DeusEx.SkillWeaponHeavy'

     FireOffset=(Y=10.000000,Z=20.000000)
     PlayerViewOffset=(X=24.000000,Y=-15.000000,Z=-17.000000)
     PlayerViewMesh=LodMesh'DeusExItems.LAM'
     PickupViewMesh=LodMesh'DeusExItems.LAMPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.LAM3rd'
     Mesh=LodMesh'DeusExItems.LAMPickup'
     CollisionRadius=3.800000
     CollisionHeight=3.500000
     Mass=5.000000
     Buoyancy=2.000000
     RealMass=0.3
     
     bHideInfo=True
}