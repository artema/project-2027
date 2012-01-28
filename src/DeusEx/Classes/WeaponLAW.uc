//=============================================================================
// WeaponLAW.
//=============================================================================
class WeaponLAW extends DeusExWeapon;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	log("***2027 - Fuck! Another bug found!***");
	Destroy();
}

defaultproperties
{
     LowAmmoWaterMark=0
     GoverningSkill=Class'DeusEx.SkillWeaponHeavy'
     NoiseLevel=2.000000
     EnviroEffective=ENVEFF_Air
     ShotTime=0.300000
     reloadTime=0.000000
     HitDamage=100
     maxRange=24000
     AccurateRange=14400
     BaseAccuracy=0.600000
     bHasMuzzleFlash=False
     recoilStrength=1.000000
     mpHitDamage=100
     mpBaseAccuracy=0.600000
     mpAccurateRange=14400
     mpMaxRange=14400
     AmmoName=Class'DeusEx.AmmoNone'
     ReloadCount=0
     FireOffset=(X=28.000000,Y=12.000000,Z=4.000000)
     ProjectileClass=Class'DeusEx.RocketLAW'
     shakemag=500.000000
     FireSound=Sound'DeusExSounds.Weapons.LAWFire'
     SelectSound=Sound'DeusExSounds.Weapons.LAWSelect'
     InventoryGroup=16
     ItemName="Light Anti-Tank Weapon (LAW)"
     PlayerViewOffset=(X=18.000000,Y=-18.000000,Z=-7.000000)
     PlayerViewMesh=LodMesh'DeusExItems.LAW'
     PickupViewMesh=LodMesh'DeusExItems.LAWPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.LAW3rd'
     LandSound=Sound'DeusExSounds.Generic.DropLargeWeapon'
     Icon=Texture'DeusExUI.Icons.BeltIconLAW'
     largeIcon=Texture'DeusExUI.Icons.LargeIconLAW'
     largeIconWidth=166
     largeIconHeight=47
     invSlotsX=4
     Description="The LAW provides cheap, dependable anti-armor capability in the form of an integrated one-shot rocket and delivery system, though at the expense of any laser guidance. Like other heavy weapons, the LAW can slow agents who have not trained with it extensively."
     beltDescription="LAW"
     Mesh=LodMesh'DeusExItems.LAWPickup'
     CollisionRadius=25.000000
     CollisionHeight=6.800000
     Mass=50.000000
}
