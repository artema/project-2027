//=============================================================================
// WeaponSpiderBot2.
//=============================================================================
class WeaponSpiderBot2 extends WeaponSpiderBot;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	log("***2027 - Fuck! Another bug found!***");
	Destroy();
}

defaultproperties
{
     shockDamage=8
     ShotTime=1.000000
     HitDamage=5
     maxRange=640
     AccurateRange=320
}
