//=======================================================
// ������ - ����������� ���. �������� Ded'�� ��� ���� 2027
// Weapon - Throwing knife. Copyright (C) 2003 Ded
//=======================================================
class WeaponThrowingKnife extends GameWeapon;

defaultproperties
{
	 bNewSkin=True
     PlayerViewSkins(0)=Texture'GameMedia.Skins.WeaponNewHands'
     PlayerViewSkins(1)=Texture'GameMedia.Skins.WeaponNewHands'
     
	 bHasSpecialAmmo=True
	 
     HitDamage=45
	
     BaseAccuracy=0.9
	
     ShotTime=0.85
     reloadTime=0.2
	
     shakemag=5.0
     
     maxRange=1280
     AccurateRange=640     
     
     NoiseLevel=0.05   
     
     AmmoName=Class'DeusEx.RAmmoShuriken'

     
     ReloadCount=1
     PickupAmmoCount=5    
     LowAmmoWaterMark=5     
     
     Icon=Texture'DeusExUI.Icons.BeltIconShuriken'
     largeIcon=Texture'DeusExUI.Icons.LargeIconShuriken'
     largeIconWidth=36
     largeIconHeight=45     
     InventoryGroup=131     

     ProjectileClass=Class'Game.P_ThrowingKnife'

     bInstantHit=False     
     bAutomatic=False
     bOldStyle=True     
     bHasMuzzleFlash=False
     bHandToHand=True     

     GoverningSkill=Class'DeusEx.SkillMedicine'

     FireOffset=(X=-10.000000,Y=14.000000,Z=22.000000)
     PlayerViewOffset=(X=24.000000,Y=-12.000000,Z=-21.000000)
     PlayerViewMesh=LodMesh'DeusExItems.Shuriken'
     PickupViewMesh=LodMesh'DeusExItems.ShurikenPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.Shuriken3rd'
     Texture=Texture'DeusExItems.Skins.ReflectionMapTex1'
     Mesh=LodMesh'DeusExItems.ShurikenPickup'
     CollisionRadius=7.500000
     CollisionHeight=0.300000
     RealMass=0.1
}