//=============================================================================
// ���� ������ (�����). �������� Ded'�� ��� ���� 2027
// Mini rocket (Robot). Copyright (C) 2003 Ded
//=============================================================================
class P_RocketSuper extends Rocket;

var bool bLaunched;

var Actor DesiredTarget;

var ParticleGenerator launchGen;

var float lastZ;
var float lastZTime;

var ParticleGenerator empedSmokeGen;

function SpawnEMPedEffects()
{
}

function SpawnEMPedLandedEffects()
{	
	local rotator rot;
	
	if(FRand() > 0.75)
	{
		if(empedSmokeGen == None)
		{
			empedSmokeGen = Spawn(class'ParticleGenerator', Self);
			
			if (empedSmokeGen != None)
			{
		        empedSmokeGen.LifeSpan = 2 + 2 * FRand();
				empedSmokeGen.particleTexture = Texture'GameMedia.Effects.ef_ExpSmoke007';
				empedSmokeGen.particleDrawScale = 0.03;
				empedSmokeGen.bRandomEject = True;
				empedSmokeGen.ejectSpeed = 10.0;
				empedSmokeGen.bGravity = False;
				empedSmokeGen.bParticlesUnlit = False;
				empedSmokeGen.frequency = 1.95;
				empedSmokeGen.riseRate = 2;
				empedSmokeGen.SetBase(Self);
				
				rot.Pitch = 16384 - 4915 * FRand();
				rot.Roll = 0;
				rot.Yaw = 65536 * FRand();
				empedSmokeGen.SetRotation(rot);
			}
		}
	}
}

simulated function SpawnRocketEffects(){}

simulated function SpawnRocketLaunchEffects()
{
	local ParticleGenerator gen;
	
	PlaySound(SpawnSound, SLOT_None);

	Spawn(class'SFXSmokeAfterLaunch', None);
	
	launchGen = Spawn(class'ParticleGenerator', Self);
	if (launchGen != None)
	{
        launchGen.RemoteRole = ROLE_None;
        launchGen.bScale = True;
		launchGen.particleTexture = Texture'GameMedia.Effects.ef_ExpSmoke005';
		launchGen.particleDrawScale = 0.3;
		launchGen.checkTime = 0.02;
		launchGen.riseRate = 100.0;
		launchGen.ejectSpeed = 150.0;
		launchGen.particleLifeSpan = 1.0;
		launchGen.bRandomEject = True;
		launchGen.SetBase(Self);
		launchGen.LifeSpan = 2.5;
	}
}

simulated function SpawnRocketFlyingEffects()
{
	PlaySound(Sound'GameMedia.Misc.SFXbeep2', SLOT_None);
	
	//Spawn(class'SFXSuperRocketLaunch', None);
	
	fireGen = Spawn(class'ParticleGenerator', Self);
	if (fireGen != None)
	{
        fireGen.RemoteRole = ROLE_None;
		fireGen.particleTexture = Texture'Effects.Fire.Fireball1';
		fireGen.particleDrawScale = 0.1;
		fireGen.checkTime = 0.01;
		fireGen.riseRate = 0.0;
		fireGen.ejectSpeed = 0.0;
		fireGen.particleLifeSpan = 0.1;
		fireGen.bRandomEject = True;
		fireGen.SetBase(Self);
	}
	smokeGen = Spawn(class'ParticleGenerator', Self);
	if (smokeGen != None)
	{
        smokeGen.RemoteRole = ROLE_None;
		smokeGen.particleTexture = Texture'GameMedia.Effects.ef_ExpSmoke009';
		smokeGen.particleDrawScale = 0.2;
		smokeGen.checkTime = 0.005;
		smokeGen.riseRate = 30.0;
		smokeGen.ejectSpeed = 0.0;
		smokeGen.particleLifeSpan = 0.6;
		smokeGen.bRandomEject = True;
		smokeGen.SetBase(Self);
	}
}

simulated function SpawnRocketEjectEffects()
{
	
}

simulated function SpawnEffects(Vector HitLocation, Vector HitNormal, Actor Other)
{
	local int i;
	local Effects puff;
	local Fragment frag;
	local ParticleGenerator gen;
	local vector loc;
	local rotator rot;
	local SFXExplosionLight light;
	local DeusExDecal mark;
    local AnimatedSprite expeffect;
    local float dist;
    local DeusExPlayer player;
    local SFXShockRing ring;

	Super.SpawnEffects(HitLocation, HitNormal, Other);

	player = DeusExPlayer(GetPlayerPawn());
	dist = Abs(VSize(player.Location - Location));
	
	if (dist ~= 0)
		dist = 10.0;

	//if(dist < blastRadius * 1.3)
	//	player.ClientFlash(FClamp(blastRadius/dist, 0.0, 4.0), vect(1000,1000,900));


	rot.Pitch = 16384 + FRand() * 16384 - 8192;
	rot.Yaw = FRand() * 65536;
	rot.Roll = 0;

	if(bStuck)
	{
		gen = spawn(class'ParticleGenerator',,, HitLocation, rot);
		
		if (gen != None)
		{
   			gen.RemoteRole = ROLE_None;   				
			gen.LifeSpan = FRand() * 5 + 20;//+5
			gen.CheckTime = 0.25;
			gen.particleDrawScale = 0.13;
			gen.RiseRate = 20.0;
			gen.bRandomEject = True;
			gen.particleTexture = Texture'GameMedia.Effects.ef_ExpSmoke009';
		}
	}

	/*for (i=0; i<blastRadius/50; i++)
	{
		if (FRand() < 0.9)
		{
			loc = Location;
			loc.X += FRand() * blastRadius - blastRadius * 0.5;
			loc.Y += FRand() * blastRadius - blastRadius * 0.5;

			puff = spawn(class'SFXSmokeAfterExplosion',,, loc);
		}
	}*/
	
	for (i=0; i<blastRadius/64; i++)
	{
		if (FRand() < 0.9)
		{
			if (FRand() < 0.5)
				Spawn(class'SFXFireComet', None);
			
			if (bDebris && bStuck)
			{
				frag = spawn(class'Rockchip',,, HitLocation);
					
				if (frag != None)
					frag.CalcVelocity(VRand(), blastRadius*1.5);
			}
		}
	}

	Spawn(class'SFXExplosionLight',,, HitLocation);

	expeffect = spawn(class'SFXExplosionMini',,, HitLocation);
	expeffect.ScaleFactor = 2.0;

	Spawn(class'SFXExplosionSmoke', None);

	/*player.DoExplosionSilence();*/
		
	ring = Spawn(class'SFXShockRing',,, HitLocation, rot(16384,0,0));
	  if (ring != None)
	  {
	     ring.RemoteRole = ROLE_None;
	     ring.size = blastRadius / 50.0;
	  }
	  ring = Spawn(class'SFXShockRing',,, HitLocation, rot(0,0,0));
	  if (ring != None)
	  {
	     ring.RemoteRole = ROLE_None;
	     ring.size = blastRadius / 50.0;
	  }
	  ring = Spawn(class'SFXShockRing',,, HitLocation, rot(0,16384,0));
	  if (ring != None)
	  {
	     ring.RemoteRole = ROLE_None;
	     ring.size = blastRadius / 50.0;
	  }
}

auto simulated state Flying
{
	simulated function ProcessTouch (Actor Other, Vector HitLocation)
	{
		if (bStuck || bRicocheted)
			return;

		if ((Other != instigator) && (DeusExProjectile(Other) == None) &&
			(Other != Owner))
		{
			damagee = Other;
			Explode(HitLocation, Normal(HitLocation-damagee.Location));

         // DEUS_EX AMSD Spawn blood server side only
         if (Role == ROLE_Authority)
			{
            if (damagee.IsA('Pawn') && !damagee.IsA('Robot') && bBlood)
               SpawnBlood(HitLocation, Normal(HitLocation-damagee.Location));
			}
		}
	}
	simulated function HitWall(vector HitNormal, actor Wall)
	{
		if (bStickToWall)
		{
			Velocity = vect(0,0,0);
			Acceleration = vect(0,0,0);
			SetPhysics(PHYS_None);
			bStuck = True;

			// MBCODE: Do this only on server side
			if ( Role == ROLE_Authority )
			{
            	if (Level.NetMode != NM_Standalone)
            		SetTimer(5.0,False);

				if (Wall.IsA('Mover'))
				{
					SetBase(Wall);
					
					if(Wall.IsA('DeusExMover') && DeusExMover(Wall).FragmentClass == Class'DeusEx.GlassFragment')
						Wall.TakeDamage(Damage, Pawn(Owner), Wall.Location, MomentumTransfer*Normal(Velocity), damageType);
				}
			}
		}

		if (Wall.IsA('BreakableGlass'))
			bDebris = False;

		SpawnEffects(Location, HitNormal, Wall);

		Super.HitWall(HitNormal, Wall);
	}
	simulated function Explode(vector HitLocation, vector HitNormal)
	{
		local bool bDestroy;
		local float rad;

      // Reduce damage on nano exploded projectiles
      if ((bAggressiveExploded) && (Level.NetMode != NM_Standalone))
         Damage = Damage/6;

		bDestroy = false;

		if (bExplodes)
		{
         //DEUS_EX AMSD Don't draw effects on dedicated server
         if ((Level.NetMode != NM_DedicatedServer) || (Role < ROLE_Authority))	
         	SpawnEffects(HitLocation, HitNormal, None);		
            //DrawExplosionEffects(HitLocation, HitNormal);

			GotoState('Exploding');
		}
		else
		{
			// Server side only
			if ( Role == ROLE_Authority )
			{
				if ((damagee != None)/* && (Tracer(Self) == None)*/) // Don't even attempt damage with a tracer
				{
					if ( Level.NetMode != NM_Standalone )
					{
						if ( damagee.IsA('DeusExPlayer') )
							DeusExPlayer(damagee).myProjKiller = Self;
					}
					
					if(bMeleeDamage && 
						(damagee.IsA('ScriptedPawn') && ScriptedPawn(damagee).MeleeDamageThreshold > Damage) || 
						(damagee.IsA('DeusExDecoration') && DeusExDecoration(damagee).MeleeDamageThreshold > Damage)
					)
					{
						GotoState('Ricocheted');
						PlayRicochet(HitNormal);
						return;
					}
					else
						damagee.TakeDamage(Damage, Pawn(Owner), HitLocation, MomentumTransfer*Normal(Velocity), damageType);
				}
			}
			if (!bStuck)
				bDestroy = true;
		}

		rad = Max(blastRadius*24, 1024);

		// This needs to be outside the simulated call chain
		PlayImpactSound();

        AISendEvent('LoudNoise', EAITYPE_Audio, 4.0, blastRadius*24);
        AISendEvent('WeaponFire', EAITYPE_Audio, 4.0, blastRadius*10);

		if (bDestroy)
			Destroy();
	}
	simulated function BeginState()
	{
		local Rotator newRot;
		
		initLoc = Location;
		initDir = vector(Rotation);	
		Velocity = speed*initDir;
		SpawnRocketLaunchEffects();

		if(!bLaunched)
		{			
			newRot = Rotation;
    		newRot.Pitch = 16384 * 0.6;
   			SetRotation(newRot);
			Velocity = 400*vector(Rotation);
		}
	}
	
Begin:
	if(!bLaunched)
	{
		Sleep(1); //Launch time	
	}
Done:
	if(!bLaunched)
	{
		bLaunched = True;
		bTracking = True;
		Target = DesiredTarget;
		Velocity = speed*initDir;
		SpawnRocketFlyingEffects();
		SetTimer(8.0, False);
	}
}

function timer()
{
	local vector normal;
	
	Explode(Location, normal);
}

simulated function Destroyed()
{
	Super.Destroyed();
	
	if (launchGen != None)
		launchGen.DelayedDestroy();
}

simulated function Tick(float deltaTime)
{
	Super.Tick(deltaTime);
	
	if(bTracking)
	{
		if(lastZTime >= 0.35)
		{
			if(Abs(lastZ - Location.Z) < 1.0)
			{
				Velocity.Z = -500;
				bTracking = False;
			}
			
			lastZTime = 0;
			lastZ = Location.Z;
		}
		
		lastZTime += deltaTime;
	}
}

defaultproperties
{
     blastRadius=800.0
     bTracking=True
     speed=1400.0
     MaxSpeed=1400.0
     Damage=130.0
     SpawnSound=Sound'DeusExSounds.Robot.RobotFireRocket'
     Mesh=LodMesh'DeusExItems.RocketLAW'
     DrawScale=0.600000
}
