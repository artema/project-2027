//=============================================================================
// SpyDrone.
//=============================================================================
class SpyDrone extends ThrownProjectile;

var() travel class<SpyDronePickupBase> PickupClass;

var() travel class<GrenadeProjectile> GrenadeClass;
var() travel int SpawnGrenadeClass;
var int HitPoints;
var int BotEMPHealth;
var int normalrate;
var int BotEMPHealthDefault;

function Deactivated()
{
}

function DoExplode()
{
}

auto state Flying
{
	function ProcessTouch (Actor Other, Vector HitLocation)
	{
		// do nothing
	}
	simulated function HitWall (vector HitNormal, actor HitWall)
	{
		// do nothing
	}
}

function Tick(float deltaTime)
{
	// do nothing
}

function TakeDamage(int Damage, Pawn instigatedBy, Vector HitLocation, Vector Momentum, name damageType)
{
	// fall to the ground if EMP'ed
	/*if ((DamageType == 'EMP') && !bDisabled)
	{
		SetPhysics(PHYS_Falling);
		bBounce = True;
		LifeSpan = 10.0;
	}*/

	Super.TakeDamage(Damage, instigatedBy, HitLocation, Momentum, damageType);
}

function BeginPlay()
{
	// do nothing
}

function Destroyed()
{
	if ( DeusExPlayer(Owner) != None )
		DeusExPlayer(Owner).aDrone = None;

	Super.Destroyed();
}

simulated function bool HasSpawnGrenade()
{
	if(SpawnGrenadeClass == 88)
		return false;
	else
		return true;
}

simulated function SetSpawnGrenade(int cl)
{
	SpawnGrenadeClass = cl;
}

defaultproperties
{
	 SpawnGrenadeClass=88
}