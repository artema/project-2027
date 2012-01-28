//=============================================================================
// Robot.
//=============================================================================
class Robot extends ScriptedPawn
	abstract;

var(Sounds) sound SearchingSound;
var(Sounds) sound SpeechTargetAcquired;
var(Sounds) sound SpeechTargetLost;
var(Sounds) sound SpeechOutOfAmmo;
var(Sounds) sound SpeechCriticalDamage;
var(Sounds) sound SpeechScanning;
var(Sounds) sound SpeechAreaSecure;
var sound MetalHitSound;

var() int EMPHitPoints;
var ParticleGenerator sparkGen;
var float crazedTimer;

var(Sounds) sound explosionSound;
var bool bNoEnergy;

var() class<DeusExAmmo> SpawnAmmo;
var() float SpawnAmmoRadius, SpawnAmmoHeight;
var() mesh SpawnAmmoMesh;
var() int SpawnAmmoCount;

function float GetDamageModifier(Name damageType)
{
	switch(damageType)
	{
		case 'Shot':
			return 0.05;
			
		case 'Sabot':
			return 1.0;
			
		case 'Stunned':
		case 'KnockedOut':
		case 'Flamed':
		case 'Burned':
			return 0.15;
	}
	
	return 1.0;
}

function InitGenerator()
{
	local Vector loc;

	if ((sparkGen == None) || (sparkGen.bDeleteMe))
	{
		loc = Location;
		loc.z += CollisionHeight/2;
		sparkGen = Spawn(class'ParticleGenerator', Self,, loc, rot(16384,0,0));
		if (sparkGen != None)
			sparkGen.SetBase(Self);
	}
}

function DestroyGenerator()
{
	if (sparkGen != None)
	{
		sparkGen.DelayedDestroy();
		sparkGen = None;
	}
}

//
// Special tick for robots to show effects of EMP damage
//
function Tick(float deltaTime)
{
	local float pct, mod;

	Super.Tick(deltaTime);

   // DEUS_EX AMSD All the MP robots have massive numbers of EMP hitpoints, not equal to the default.  In multiplayer, at least, only do this if
   // they are DAMAGED.
	if ((Default.EMPHitPoints != EMPHitPoints) && (EMPHitPoints != 0) && ((Level.Netmode == NM_Standalone) || (EMPHitPoints < Default.EMPHitPoints)))
	{
		pct = (Default.EMPHitPoints - EMPHitPoints) / Default.EMPHitPoints;
		mod = pct * (1.0 - (2.0 * FRand()));
		DesiredSpeed = MaxDesiredSpeed + (mod * MaxDesiredSpeed * 0.5);
		SoundPitch = Default.SoundPitch + (mod * 8.0);
	}

	if (CrazedTimer > 0)
	{
		CrazedTimer -= deltaTime;
		if (CrazedTimer < 0)
			CrazedTimer = 0;
	}

	if (CrazedTimer > 0)
		bReverseAlliances = true;
	else
		bReverseAlliances = false;
}


function ImpartMomentum(Vector momentum, Pawn instigatedBy)
{
	// nil
}

function bool ShouldFlee()
{
	return (Health <= MinHealth);
}

function bool ShouldDropWeapon()
{
	return false;
}

//
// Called when the robot is destroyed
//
simulated event Destroyed()
{
	Super.Destroyed();

	DestroyGenerator();
}

function Carcass SpawnCarcass()
{
	Explode(Location);

	return None;
}

function Died(pawn Killer, name damageType, vector HitLocation)
{
	local DeusExPlayer player;
	
	super.Died(Killer, damageType, HitLocation);
	
	player = DeusExPlayer(GetPlayerPawn());
	if (player != None)
	{
		if(player.PerkSystem.CheckPerkState(class'PerkBotsammo') && SpawnAmmo != None && Killer == player)
		{
			SpawnBotsAmmo(200);
		}
	}
}

function bool IgnoreDamageType(Name damageType)
{
	if ((damageType == 'TearGas') || (damageType == 'HalonGas') || (damageType == 'PoisonGas') || (damageType == 'Radiation'))
		return True;
	else if ((damageType == 'Poison') || (damageType == 'PoisonEffect'))
		return True;
	else if (damageType == 'KnockedOut')
		return True;
	else
		return False;
}

function SetOrders(Name orderName, optional Name newOrderTag, optional bool bImmediate)
{
	if (EMPHitPoints > 0)
		Super.SetOrders(orderName, newOrderTag, bImmediate);
}

// ----------------------------------------------------------------------
// TakeDamageBase()
// ----------------------------------------------------------------------

function TakeDamageBase(int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, name damageType, bool bPlayAnim)
{
	local float actualDamage;
	local int oldEMPHitPoints;
	local int i;

	if ((Level.NetMode != NM_Standalone) && (damageType == 'EMP') && (Self.IsA('MedicalBot') || Self.IsA('RepairBot')))
		return;

	if (bInvincible)
		return;

	if (IgnoreDamageType(damageType))
		return;

	if (damageType == 'EMP')
	{
		oldEMPHitPoints = EMPHitPoints;
		EMPHitPoints   -= Damage;

		if (EMPHitPoints <= 0)
		{
			EMPHitPoints = 0;
			if (oldEMPHitPoints > 0)
			{
				PlaySound(sound'EMPZap', SLOT_None,,, (CollisionRadius+CollisionHeight)*8, 2.0*DeusExPlayer(GetPlayerPawn()).GetSoundPitchMultiplier());
				InitGenerator();
				if (sparkGen != None)
				{
					sparkGen.LifeSpan = 6;
					sparkGen.particleTexture = Texture'GameMedia.Effects.ef_ExpSmoke007';
					sparkGen.particleDrawScale = 0.08;
					sparkGen.bRandomEject = False;
					sparkGen.ejectSpeed = 10.0;
					sparkGen.bGravity = False;
					sparkGen.bParticlesUnlit = True;
					sparkGen.frequency = 0.3;
					sparkGen.riseRate = 3;
					sparkGen.spawnSound = Sound'Spark2';
				}
			}
			AmbientSound = None;
			if (GetStateName() != 'Disabled')
				GotoState('Disabled');
		}
		else if (sparkGen == None)
		{
			InitGenerator();
			if (sparkGen != None)
			{
				sparkGen.particleTexture = Texture'GameMedia.Effects.ef_HitMuzzle001';
				sparkGen.particleDrawScale = 0.04;
				sparkGen.bRandomEject = True;
				sparkGen.ejectSpeed = 100.0;
				sparkGen.bGravity = True;
				sparkGen.bParticlesUnlit = True;
				sparkGen.frequency = 0.2;
				sparkGen.riseRate = 1;
				sparkGen.spawnSound = Sound'Spark2';
			}
		}

		return;
	}
	else if (damageType == 'NanoVirus')
	{
		CrazedTimer += 0.5*Damage;
		return;
	}

	PlayTakeHitSound(Damage, damageType, 1);

	if (SoundPitch == Default.SoundPitch)
		SoundPitch += 16;

	actualDamage = Level.Game.ReduceDamage(Damage, DamageType, self, instigatedBy);
	
	actualDamage *= GetDamageModifier(damageType);

	if (damageType == 'Shot')
	{
		for (i=0; i<2; i++)
			if(FRand() < 0.4)
				Spawn(class'SparkFlying', None,'',hitlocation);
	}
	else if (damageType == 'Sabot')
	{
		for (i=0; i<10; i++)
			if(FRand() < 0.4)
				Spawn(class'FireComet', None,'',hitlocation);
				
		for (i=0; i<10; i++)
			if(FRand() < 0.4)
				Spawn(class'SparkFlying', None,'',hitlocation);
	}
	else if ((damageType == 'Stunned') || (damageType == 'KnockedOut') || (damageType == 'Flamed') || (damageType == 'Burned'))
	{
	}

	if ((actualDamage > 0.01) && (actualDamage < 1))
		actualDamage = 1;

	actualDamage = int(actualDamage+0.5);
	
	if (ReducedDamageType == 'All')
		actualDamage = 0;
	else if (Inventory != None)
		actualDamage = Inventory.ReduceDamage(int(actualDamage), DamageType, HitLocation);

	if(damageType == 'Shot' && FRand() < 0.5) actualDamage = 0;

	if(actualDamage > 0)
	{
		if (!bInvincible)
			Health -= int(actualDamage);
	
		if (Health <= Default.Health*0.3)
		{
			InitGenerator();
			if (sparkGen != None)
			{
				//sparkGen.LifeSpan = 6;
				sparkGen.particleTexture = Texture'GameMedia.Effects.ef_ExpSmoke008';
				sparkGen.particleDrawScale = 0.1;
				sparkGen.particleLifeSpan = 3.0;
				sparkGen.bRandomEject = True;
				sparkGen.ejectSpeed = 15.0;
				sparkGen.bGravity = False;
				sparkGen.bParticlesUnlit = True;
				sparkGen.frequency = 0.8;
				sparkGen.checkTime = 0.15;
				sparkGen.riseRate = 10;
				sparkGen.numPerSpawn = 2;
				sparkGen.bScale = True;
				sparkGen.bFade = True;
				//sparkGen.spawnSound = Sound'Spark2';
			}
		}
	}

	if (Health <= 0)
	{
		ClearNextState();

		if ( actualDamage > mass )
			Health = -1 * actualDamage;

		Enemy = instigatedBy;
		Died(instigatedBy, damageType, HitLocation);
	}

	MakeNoise(1.0);

	ReactToInjury(instigatedBy, damageType, HITLOC_None);
}

function ReactToInjury(Pawn instigatedBy, Name damageType, EHitLocation hitPos)
{
	local Pawn oldEnemy;

	if (IgnoreDamageType(damageType))
		return;

	if (EMPHitPoints > 0)
	{
		if (damageType == 'NanoVirus')
		{
			oldEnemy = Enemy;
			FindBestEnemy(false);
			if (oldEnemy != Enemy)
				PlayNewTargetSound();
			instigatedBy = Enemy;
		}
		Super.ReactToInjury(instigatedBy, damageType, hitPos);
	}
}

function GotoDisabledState(name damageType, EHitLocation hitPos)
{
	if (!bCollideActors && !bBlockActors && !bBlockPlayers)
		return;
	else if (!IgnoreDamageType(damageType) && CanShowPain())
		TakeHit(hitPos);
	else
		GotoNextState();
}


function ComputeFallDirection(float totalTime, int numFrames,
                              out vector moveDir, out float stopTime)
{
}


function Explode(vector HitLocation)
{
	local int i, num;
	local float explosionRadius;
	local Vector loc;
	local DeusExFragment s;
	local ExplosionLight light;
	local DeusExAmmo a;
	local DeusExPlayer player;

	explosionRadius = (CollisionRadius + CollisionHeight) / 2;
	PlaySound(explosionSound, SLOT_None, 2.0,, explosionRadius*32, DeusExPlayer(GetPlayerPawn()).GetSoundPitchMultiplier());

	if (explosionRadius < 48.0)
		PlaySound(sound'LargeExplosion1', SLOT_None,,, explosionRadius*32, DeusExPlayer(GetPlayerPawn()).GetSoundPitchMultiplier());
	else
		PlaySound(sound'LargeExplosion2', SLOT_None,,, explosionRadius*32, DeusExPlayer(GetPlayerPawn()).GetSoundPitchMultiplier());

	//AISendEvent('LoudNoise', EAITYPE_Audio, , explosionRadius*16);
	AISendEvent('LoudNoise', EAITYPE_Audio, , explosionRadius*24);

	// draw a pretty explosion
	light = Spawn(class'ExplosionLight',,, HitLocation);
	for (i=0; i<explosionRadius/20+1; i++)
	{
		loc = Location + VRand() * CollisionRadius;
		if (explosionRadius <= 9)
		{
			Spawn(class'ExplosionSmall',,, loc);
			light.size = 2;
		}
		else if ((explosionRadius > 9) && (explosionRadius <= 32))
		{
			Spawn(class'ExplosionMedium',,, loc);
			light.size = 4;
		}
		else
		{
			Spawn(class'ExplosionLarge',,, loc);
			light.size = 8;
		}
	}

	// spawn some metal fragments
	num = FMax(3, explosionRadius/6);
	for (i=0; i<num; i++)
	{
		s = Spawn(class'MetalFragment', Owner);
		if (s != None)
		{
			s.Instigator = Instigator;
			s.CalcVelocity(Velocity, explosionRadius);
			s.DrawScale = explosionRadius*0.075*FRand();
			s.Skin = GetMeshTexture();
			if (FRand() < 0.75)
				s.bSmoking = True;
		}
	}

	// cause the damage
	HurtRadius(0.5*explosionRadius, 8*explosionRadius, 'Exploded', 100*explosionRadius, Location);
}

simulated function SpawnBotsAmmo(float explosionRadius)
{
	local DeusExAmmo a;

	a = Spawn(SpawnAmmo, Owner);			
	if (a != None)
	{
		a.Instigator = Instigator;
		a.CalcVelocity(Velocity, explosionRadius);
		
		if(SpawnAmmoMesh != None)
		{
			a.Mesh = SpawnAmmoMesh;			
			a.PickupViewMesh = SpawnAmmoMesh;
		}
		
		if(SpawnAmmoRadius != 0 && SpawnAmmoHeight != 0)
			a.SetCollisionSize(SpawnAmmoRadius, SpawnAmmoHeight);
		
		if(SpawnAmmoCount != 0)	
			a.AmmoAmount = int(SpawnAmmoCount + SpawnAmmoCount*0.5*FRand());
	}
}

function TweenToRunningAndFiring(float tweentime)
{
	bIsWalking = FALSE;
	TweenAnimPivot('Run', tweentime);
}

function PlayRunningAndFiring()
{
	bIsWalking = FALSE;
	LoopAnimPivot('Run');
}

function TweenToShoot(float tweentime)
{
	TweenAnimPivot('Still', tweentime);
}

function PlayShoot()
{
	PlayAnimPivot('Still');
}

function TweenToAttack(float tweentime)
{
	TweenAnimPivot('Still', tweentime);
}

function PlayAttack()
{
	PlayAnimPivot('Still');
}

function PlayTurning()
{
	LoopAnimPivot('Walk');
}

function PlayFalling()
{
}

function TweenToWalking(float tweentime)
{
	bIsWalking = True;
	TweenAnimPivot('Walk', tweentime);
}

function PlayWalking()
{
	bIsWalking = True;
	LoopAnimPivot('Walk');
}

function TweenToRunning(float tweentime)
{
	bIsWalking = False;
	PlayAnimPivot('Run',, tweentime);
}

function PlayRunning()
{
	bIsWalking = False;
	LoopAnimPivot('Run');
}

function TweenToWaiting(float tweentime)
{
	TweenAnimPivot('Idle', tweentime);
}

function PlayWaiting()
{
	PlayAnimPivot('Idle');
}

function PlaySwimming()
{
	LoopAnimPivot('Still');
}

function TweenToSwimming(float tweentime)
{
	TweenAnimPivot('Still', tweentime);
}

function PlayLanded(float impactVel)
{
	bIsWalking = True;
}

function PlayDuck()
{
	TweenAnimPivot('Still', 0.25);
}

function PlayRising()
{
	PlayAnimPivot('Still');
}

function PlayCrawling()
{
	LoopAnimPivot('Still');
}

function PlayFiring()
{
	LoopAnimPivot('Still',,0.1);
}

function PlayReloadBegin()
{
	PlayAnimPivot('Still',, 0.1);
}

function PlayReload()
{
	PlayAnimPivot('Still');
}

function PlayReloadEnd()
{
	PlayAnimPivot('Still',, 0.1);
}

function PlayCowerBegin() {}
function PlayCowering() {}
function PlayCowerEnd() {}

function PlayDisabled()
{
	TweenAnimPivot('Still', 0.2);
}

function PlayWeaponSwitch(Weapon newWeapon)
{
}

function PlayIdleSound()
{
}

function PlayScanningSound()
{
	PlaySound(SearchingSound, SLOT_None,,, 2048, DeusExPlayer(GetPlayerPawn()).GetSoundPitchMultiplier());
	PlaySound(SpeechScanning, SLOT_None,,, 2048, DeusExPlayer(GetPlayerPawn()).GetSoundPitchMultiplier());
}

function PlaySearchingSound()
{
	PlaySound(SearchingSound, SLOT_None,,, 2048, DeusExPlayer(GetPlayerPawn()).GetSoundPitchMultiplier());
	PlaySound(SpeechScanning, SLOT_None,,, 2048, DeusExPlayer(GetPlayerPawn()).GetSoundPitchMultiplier());
}

function PlayTargetAcquiredSound()
{
	PlaySound(SpeechTargetAcquired, SLOT_None,,, 2048, DeusExPlayer(GetPlayerPawn()).GetSoundPitchMultiplier());
}

function PlayTargetLostSound()
{
	PlaySound(SpeechTargetLost, SLOT_None,,, 2048, DeusExPlayer(GetPlayerPawn()).GetSoundPitchMultiplier());
}

function PlayGoingForAlarmSound()
{
}

function PlayOutOfAmmoSound()
{
	PlaySound(SpeechOutOfAmmo, SLOT_None,,, 2048, DeusExPlayer(GetPlayerPawn()).GetSoundPitchMultiplier());
}

function PlayCriticalDamageSound()
{
	PlaySound(SpeechCriticalDamage, SLOT_None,,, 2048, DeusExPlayer(GetPlayerPawn()).GetSoundPitchMultiplier());
}

function PlayAreaSecureSound()
{
	PlaySound(SpeechAreaSecure, SLOT_None,,, 2048, DeusExPlayer(GetPlayerPawn()).GetSoundPitchMultiplier());
}



state Disabled
{
	ignores bump, frob, reacttoinjury;
	function BeginState()
	{
		StandUp();
		BlockReactions(true);
		bCanConverse = False;
		SeekPawn = None;
	}
	function EndState()
	{
		ResetReactions();
		bCanConverse = True;
	}

Begin:
	Acceleration=vect(0,0,0);
	DesiredRotation=Rotation;
	PlayDisabled();

Disabled:
}

state Fleeing
{
	function PickDestination()
	{
		local int     iterations;
		local float   magnitude;
		local rotator rot1;

		iterations = 4;
		magnitude  = 400*(FRand()*0.4+0.8);  // 400, +/-20%
		rot1       = Rotator(Location-Enemy.Location);
		if (!AIPickRandomDestination(40, magnitude, rot1.Yaw, 0.6, rot1.Pitch, 0.6, iterations,
		                             FRand()*0.4+0.35, destLoc))
			destLoc = Location;  // we give up
	}
}

// ------------------------------------------------------------
// IsImmobile
// If the bots are immobile, then we can make them always relevant
// ------------------------------------------------------------
function bool IsImmobile()
{
   local bool bHasReactions;
   local bool bHasFears;
   local bool bHasHates;

   if (Orders != 'Standing')
      return false;

   bHasReactions = bReactFutz || bReactPresence || bReactLoudNoise || bReactAlarm || bReactShot || bReactCarcass || bReactDistress || bReactProjectiles;

   bHasFears = bFearHacking || bFearWeapon || bFearShot || bFearInjury || bFearIndirectInjury || bFearCarcass || bFearDistress || bFearAlarm || bFearProjectiles;

   bHasHates = bHateHacking || bHateWeapon || bHateShot || bHateInjury || bHateIndirectInjury || bHateCarcass || bHateDistress;

   return (!bHasReactions && !bHasFears && !bHasHates);
}

// ----------------------------------------------------------------------
// PlayTakeHitSound()
// ----------------------------------------------------------------------
function PlayTakeHitSound(int Damage, name damageType, int Mult)
{
	local Sound hitSound;
	local Sound metalSound;
	local float volume;

	if (Level.TimeSeconds - LastPainSound < 0.1)
		return;
	if (Damage <= 0)
		return;

	LastPainSound = Level.TimeSeconds;

	if (Damage <= 30)
		hitSound = HitSound1;
	else
		hitSound = HitSound2;

	volume = FMax(Mult*TransientSoundVolume, Mult*2.0);

	SetDistressTimer();

	PlaySound(hitSound, SLOT_Pain, volume,,, RandomPitch()*DeusExPlayer(GetPlayerPawn()).GetSoundPitchMultiplier());

       if ((damageType == 'Shot') || (damageType == 'Sabot') || (damageType == 'Autoshot'))
       {
		metalSound = MetalHitSound;
	        PlaySound(metalSound, SLOT_Pain, volume,,, RandomPitch()* DeusExPlayer(GetPlayerPawn()).GetSoundPitchMultiplier());
       }

	if ((hitSound != None) && bEmitDistress)
		AISendEvent('Distress', EAITYPE_Audio, volume);
}

function PlayDyingSound(){}

defaultproperties
{
     MeleeDamageThreshold=9000
     SpawnAmmo=None
     MetalHitSound=Sound'DeusExSounds.Generic.ArmorRicochet'
     EMPHitPoints=50
     explosionSound=Sound'DeusExSounds.Robot.RobotExplode'
     maxRange=512.000000
     MinHealth=0.000000
     RandomWandering=0.150000
     bCanBleed=False
     bShowPain=False
     bCanSit=False
     bAvoidAim=False
     bAvoidHarm=False
     bHateShot=False
     bReactAlarm=True
     bReactProjectiles=False
     bEmitDistress=False
     RaiseAlarm=RAISEALARM_Never
     bMustFaceTarget=False
     FireAngle=60.000000
     MaxProvocations=0
     SurprisePeriod=0.000000
     EnemyTimeout=7.000000
     walkAnimMult=1.000000
     bCanStrafe=False
     bCanSwim=False
     bIsHuman=False
     JumpZ=0.000000
     MaxStepHeight=4.000000
     Health=50
     HitSound1=Sound'DeusExSounds.Generic.Spark1'
     HitSound2=Sound'DeusExSounds.Generic.Spark1'
     Die=Sound'DeusExSounds.Generic.Spark1'
     VisibilityThreshold=0.006000
     BindName="Robot"
}
