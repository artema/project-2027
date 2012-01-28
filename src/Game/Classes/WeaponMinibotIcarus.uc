class WeaponMinibotIcarus extends WeaponNPCMelee;

var() int NumGrenades;
var() float FlashRadius;
var() float DamageRadius;
var() float ExplosionDamage;

function name WeaponDamageType()
{
	return 'Exploded';
}

function Fire(float Value)
{
	SpawnProjectiles();
	
	Super.Fire(Value);
}

function SpawnProjectiles()
{
	local int i;
	local P_Icarus grenade;
	local P_IcarusProxy damageProxy;
	local Vector loc, initLoc;
	local Rotator rot, initRot, facingRot;
	local float step, radius;
	local SFXIcarusSphereEffect sphere;
	
	step = 65536 / NumGrenades;
	
	if(DeusExPlayer(Owner) != None)
	{
		initRot = DeusExPlayer(Owner).Rotation;
		initLoc = DeusExPlayer(Owner).Location;
		initLoc.Z += DeusExPlayer(Owner).CollisionHeight / 2;
		radius = DeusExPlayer(Owner).CollisionRadius;
	}
	else if(ScriptedPawn(Owner) != None)
	{
		initRot = ScriptedPawn(Owner).Rotation;
		initLoc = ScriptedPawn(Owner).Location;	
		initLoc.Z += ScriptedPawn(Owner).CollisionHeight / 2;
		radius = ScriptedPawn(Owner).CollisionRadius;
	}
	
	facingRot.Yaw = initRot.Yaw;	
	initLoc.Z += 5;
	
	for(i=0; i<NumGrenades; i++)
	{
		rot.Yaw = initRot.Yaw + (step * i) + (step * FRand() * 0.75);
		loc = initLoc + vector(rot) * (20);		
		
		grenade = spawn(class'P_Icarus',,, loc, rot);
		grenade.bPlaySound = (i == 0 || Frand() < 0.1);
	}

	if(ScriptedPawn(Owner) != None)
	{
		damageProxy = spawn(class'P_IcarusProxy',,, initLoc);
		damageProxy.shooter = ScriptedPawn(Owner);
		
		sphere = Spawn(class'SFXIcarusSphereEffect',,, ScriptedPawn(Owner).Location);
	
		if (sphere != None)
		{
			sphere.size = maxRange / 40.0;
		}
	}
}

defaultproperties
{
	 NumGrenades=33
	 
	 HitDamage=20
	 ExplosionDamage=70
	
     ShotTime=1.5
     reloadTime=5.0

	 FlashRadius=500.0
	 DamageRadius=300.0
     maxRange=250
     AccurateRange=250
     AIMinRange=50
     AIMaxRange=250

	 FireSound=Sound'DeusExSounds.Weapons.LAWFire'

     AmmoName=Class'DeusEx.RAmmoLamGrenade'

     ReloadCount=1
     PickupAmmoCount=2
     
     bHandToHand=True
     bInstantHit=True
     //bFallbackWeapon=True

     //AITimeLimit=10.0
     AIFireDelay=5.0
}