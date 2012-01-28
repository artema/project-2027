//=============================================================================
// SpyDrone.
//=============================================================================
class SpyDronePickupBase extends Robot
	abstract;

var class<SpyDroneItem> PickupClass;

var int BotEMPHealth;
var() travel class<Projectile> GrenadeClass;
var() travel int SpawnGrenadeClass;

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

simulated function DeactivateBot()
{
	EMPHitPoints = 0;
	ResetReactions();
	GotoState('BotDeactivated');
	BlockReactions(False);
	bCanConverse = False;
	SeekPawn = None;
	EnableCheckDestLoc(False);
	Acceleration=vect(0,0,0);
	DesiredRotation=Rotation;
	PlayAnimPivot('Still');
}

state BotDeactivated
{
	ignores bump, reacttoinjury;
	function BeginState()
	{
		StandUp();
		BlockReactions(true);
		bCanConverse = False;
		SeekPawn = None;
		EnableCheckDestLoc(false);
	}
	function EndState()
	{
		ResetReactions();
		bCanConverse = True;
	}

Begin:
	Acceleration=vect(0,0,0);
	DesiredRotation=Rotation;
	PlayAnimPivot('Still');

Idle:
}

defaultproperties
{
	 Alliance=Player
	 SpawnGrenadeClass=88
}