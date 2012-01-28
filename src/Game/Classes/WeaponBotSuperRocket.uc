//=======================================================
// ������ (NPC) - ���������. �������� Ded'�� ��� ���� 2027
// Weapon (NPC) - Rocket launcher. Copyright (C) 2003 Ded
//=======================================================
class WeaponBotSuperRocket extends WeaponNPC;

var vector activeTargets[100];

var int currentRocket;

var() int numRockets;

var() float launchAngle;

var float initialDirection;

var int launchedLeft;
var int launchedRight;

simulated function Projectile ProjectileFire(class<projectile> ProjClass, float ProjSpeed, bool bWarn)
{
	local Vector Start, X, Y, Z;
	local DeusExProjectile proj;
	local float mult;
	local float volume, radius;
	local int i, numProj;
	local Pawn aPawn;
	local Actor targ;
	local float step;

	GetAIVolume(volume, radius);
	Owner.AISendEvent('WeaponFire', EAITYPE_Audio, volume, radius);
	Owner.AISendEvent('LoudNoise', EAITYPE_Audio, volume, radius);
	
	if (!Owner.IsA('PlayerPawn'))
		Owner.AISendEvent('Distress', EAITYPE_Audio, volume, radius);

	GetAxes(Pawn(owner).ViewRotation,X,Y,Z);
	Start = ComputeProjectileStart(X, Y, Z);

	AdjustedAim = pawn(owner).AdjustAim(ProjSpeed, Start, AimError, True, bWarn);
	
	step = (launchAngle / ((numRockets / 2) - 1));
	
	if(PlayerViewOffset.Y >= 0)
	{
		AdjustedAim.Yaw = Pawn(owner).ViewRotation.Yaw + (step * launchedRight);
		launchedRight++;
	}
	else
	{
		AdjustedAim.Yaw = Pawn(owner).ViewRotation.Yaw - (step * launchedLeft);
		launchedLeft++;
	}
	
	//AdjustedAim.Yaw += currentAccuracy * (Rand(1024) - 512);
	AdjustedAim.Pitch += currentAccuracy * (Rand(1024) - 512);

	proj = DeusExProjectile(Spawn(ProjClass, Owner,, Start, AdjustedAim));
		
	if(proj != None)
	{
		targ = Spawn(Class'RocketTarget', self,, activeTargets[currentRocket]);

		if(proj.IsA('P_RocketSuper'))
		{
			P_RocketSuper(proj).DesiredTarget = targ;
		}
		else
		{
			proj.Target = targ;
			proj.bTracking = True;
		}
	}
	
	PlayerViewOffset.Y = -PlayerViewOffset.Y;
	currentRocket++;

	return proj;
}

function TraceTargetLocation(float Accuracy, out vector HitLocation, out vector HitNormal)
{
	local vector StartTrace, EndTrace, X, Y, Z;
	local Rotator rot;
	local actor Other;
	local float dist, alpha, degrade;
	local int i, numSlugs;
	local float volume, radius;

	GetAxes(Pawn(owner).ViewRotation,X,Y,Z);
	StartTrace = ComputeProjectileStart(X, Y, Z);
	AdjustedAim = pawn(owner).AdjustAim(1000000, StartTrace, 2.75*AimError, False, False);
	
	EndTrace = StartTrace + Accuracy * (FRand()-0.5)*Y*1000 + Accuracy * (FRand()-0.5)*Z*1000 ;
    EndTrace += (FMax(1024.0, MaxRange) * vector(AdjustedAim));
    //EndTrace += (FMax(1024.0, 100000) * vector(AdjustedAim));
      
    Other = Pawn(Owner).TraceShot(HitLocation,HitNormal,EndTrace,StartTrace);
}

function CalculateTargets()
{
	local int i;
	local vector HitNormal;
	local vector HitLocation;
	local vector targetGround;
	local float radius;
	
	if(ScriptedPawn(Owner).Enemy != None)
	{
		radius = 1000 * BaseAccuracy;
		
		for(i=0; i<numRockets; i++)
		{			
			targetGround = ScriptedPawn(Owner).Enemy.Location;
			targetGround.Z = targetGround.Z - (ScriptedPawn(Owner).Enemy.CollisionHeight / 2);
			targetGround.X = targetGround.X - radius + (radius * 2 * FRand());
			targetGround.Y = targetGround.Y - radius + (radius * 2 * FRand());
			activeTargets[i] = targetGround;
		}
	}
	else
	{	
		for(i=0; i<numRockets; i++)
		{
			TraceTargetLocation(BaseAccuracy, HitLocation, HitNormal);
			activeTargets[i] = HitLocation;
		}
	}
}

state LaunchingRockets
{
Begin:
	if (Owner != None && Owner.IsA('ScriptedPawn') && ScriptedPawn(Owner).Health > 0 && bRocketLaunchOn && ClipCount < ReloadCount)
	{
		if((rocketShotCount <= 0))///&& (Owner != None)
		{
			goto('Done');
		}
		else
			rocketShotCount--;
		
		ScriptedPawn(Owner).PlayFiring();
		PlaySelectiveFiring();
		PlayFiringSound();
		GenerateBullet();
		
		ScriptedPawn(Owner).Acceleration = vect(0,0,0);
		ScriptedPawn(Owner).Velocity = vect(0,0,0);
		ScriptedPawn(Owner).DesiredRotation = Owner.Rotation;
		ScriptedPawn(Owner).PlayAnimPivot('Idle1');
		
		Sleep(ShotTime);
		goto('Begin');
	}
Done:
	bRocketLaunchOn = False;
	
	if(ScriptedPawn(Owner) != None) ScriptedPawn(Owner).bRocketLaunchOn = False;
	
	ReloadAmmo();
}

function ReloadAmmo()
{
	Super.ReloadAmmo();
	bRocketLaunchOn = False;
	if(ScriptedPawn(Owner) != None) ScriptedPawn(Owner).bRocketLaunchOn = False;
	bFiring = False;
}

function StartRocketLaunch()
{
	bRocketLaunchOn = True;
	if(ScriptedPawn(Owner) != None) ScriptedPawn(Owner).bRocketLaunchOn = True;
	bFiring = True;

	rocketShotCount = numRockets;
	currentRocket = 0;
	
	launchedLeft = 0;
	launchedRight = 0;
	
	CalculateTargets();
	
	GotoState('LaunchingRockets');
}

function StopRocketLaunch()
{
	bRocketLaunchOn = False;
	if(ScriptedPawn(Owner) != None) ScriptedPawn(Owner).bRocketLaunchOn = False;
}

simulated function PlayFiringSound()
{
	PlaySimSound(FireSound, SLOT_None, TransientSoundVolume, 2048 * NoiseLevel * 2);
}

defaultproperties
{
     HitDamage=100

     BaseAccuracy=0.5

     ShotTime=0.2

     maxRange=24000
     AIMinRange=600.0

     AmmoName=Class'DeusEx.RAmmoRocketRobot'

	 NoiseVolume=8.0

     launchAngle=16384.0
	 numRockets=6
     ReloadCount=6
     PickupAmmoCount=12
     
     reloadTime=5.000000

     bInstantHit=False
     bAutomatic=True
     bOldStyle=False

     bHasMuzzleFlash=False
     ProjectileClass=Class'Game.P_RocketSuper'

     FireSound=Sound'DeusExSounds.Weapons.FlamethrowerFire'

     PlayerViewOffset=(Y=-46.000000,Z=36.000000)
}