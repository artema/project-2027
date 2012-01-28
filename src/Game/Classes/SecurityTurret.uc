//=============================================================================
// �������� ������. �������� Ded'�� ��� ���� 2027
// Security turret. Copyright (C) 2003 Ded
//=============================================================================
class SecurityTurret extends AutoTurret;

function Fire()
{
	local Vector HitLocation, HitNormal, StartTrace, EndTrace, X, Y, Z;
	local Rotator rot;
	local Actor hit;
	local Shell10mmTurret shell;
	local Spark2 spark;
	local Pawn attacker;

	if (!gun.IsAnimating())
		gun.LoopAnim('Fire');

		GetAxes(gun.Rotation, X, Y, Z);
		StartTrace = gun.Location;
		EndTrace = StartTrace + gunAccuracy * (FRand()-0.5)*Y*1000 + gunAccuracy * (FRand()-0.5)*Z*1000 ;
		EndTrace += 10000 * X;
		hit = Trace(HitLocation, HitNormal, EndTrace, StartTrace, True);

      if ((DeusExMPGame(Level.Game) != None) && (!DeusExMPGame(Level.Game).bSpawnEffects))
      {
         shell = None;
      }
      else
      {
         shell = Spawn(class'Shell10mmTurret',,, gun.Location);
      }
		if (shell != None)
			shell.Velocity = Vector(gun.Rotation - rot(0,16384,0)) * 100 + VRand() * 30;

		MakeNoise(1.5);
		PlaySound(sound'PistolFire', SLOT_None);
		AISendEvent('LoudNoise', EAITYPE_Audio);

		gun.LightType = LT_Steady;
		gun.MultiSkins[2] = Texture'GameEffects.Fire.ef_Shot_001';
		SetTimer(0.1, False);

		if (FRand() < 0.5)
		{
			if (VSize(HitLocation - StartTrace) > 250)
			{
				rot = Rotator(EndTrace - StartTrace);
				Spawn(class'Tracer',,, StartTrace + 96 * Vector(rot), rot);
			}
		}

		if (hit != None)
		{
	        /* if ((DeusExMPGame(Level.Game) != None) && (!DeusExMPGame(Level.Game).bSpawnEffects))
	         {
	            spark = None;
	         }
	         else
	         {
	            spark = spawn(class'Spark2',,,HitLocation+HitNormal, Rotator(HitNormal));
	         }

			if (spark != None)
			{
				spark.DrawScale = 0.05;
				PlayHitSound(spark, hit);
			}*/

			attacker = None;
			if ((curTarget == hit) && !curTarget.IsA('PlayerPawn'))
				attacker = GetPlayerPawn();

			if ( hit.IsA('DeusExPlayer') && ( Level.NetMode != NM_Standalone ))
				DeusExPlayer(hit).myTurretKiller = Self;
			hit.TakeDamage(gunDamage, attacker, HitLocation, 1000.0*X, 'Shot');

			if (hit.IsA('Pawn') && !hit.IsA('Robot'))
				SpawnBlood(HitLocation, HitNormal);
			else if ((hit == Level) || hit.IsA('Mover'))
				SpawnEffects(HitLocation, HitNormal, hit);
		}
}

function name WeaponDamageType()
{
	return 'Shot';
}

simulated function SpawnEffects(Vector HitLocation, Vector HitNormal, Actor Other)
{
	local SmokeTrail puff;
	local int i;
	local BulletHole hole;
	local Rotator rot;
        local TraceHitter hitspawner;
	local Name damageType;

	damageType = WeaponDamageType();

         hitspawner = Spawn(class'TraceHitter',Other,,HitLocation,Rotator(HitNormal));

   if (hitSpawner != None)
	{
      hitspawner.HitDamage = gunDamage;
		hitSpawner.damageType = damageType;
	}

   if ((DeusExMPGame(Level.Game) != None) && (!DeusExMPGame(Level.Game).bSpawnEffects))
      return;

		puff = spawn(class'SmokeTrail',,,HitLocation+HitNormal, Rotator(HitNormal));
		if (puff != None)
		{
			puff.DrawScale *= 0.7;
			puff.OrigScale = puff.DrawScale;
			puff.LifeSpan = 0.15;
			puff.OrigLifeSpan = puff.LifeSpan;
		}

	if (!Other.IsA('BreakableGlass'))
		for (i=0; i<2; i++)
			if (FRand() < 0.8)
				spawn(class'Rockchip',,,HitLocation+HitNormal);

	hole = spawn(class'BulletHole', Other,, HitLocation, Rotator(HitNormal));

	if (GetWallMaterial(HitLocation, HitNormal) == 'Glass')
	{
		if (FRand() < 0.5)
			hole.Texture = Texture'FlatFXTex29';
		else
			hole.Texture = Texture'FlatFXTex30';

		hole.DrawScale = 0.1;
		hole.ReattachDecal();
	}
}

function PreBeginPlay()
{
	local Vector v1, v2;
	local class<AutoTurretGun> gunClass;
	local Rotator rot;

	super(DeusExDecoration).PreBeginPlay();

	if (IsA('SecurityTurretSmall'))
		gunClass = class'AutoTurretGunSmall';
	else
		gunClass = class'AutoTurretGun';

	rot = Rotation;
	rot.Pitch = 0;
	rot.Roll = 0;
	origRot = rot;
	gun = Spawn(gunClass, Self,, Location, rot);
	if (gun != None)
	{
		v1.X = 0;
		v1.Y = 0;
		v1.Z = CollisionHeight + gun.Default.CollisionHeight;
		v2 = v1 >> Rotation;
		v2 += Location;
		gun.SetLocation(v2);
		gun.SetBase(Self);
	}

	// set up the alarm listeners
	AISetEventCallback('Alarm', 'AlarmHeard');

	if ( Level.NetMode != NM_Standalone )
	{
		maxRange = mpTurretRange;
		gunDamage = mpTurretDamage;
		bInvincible = True;
      bDisabled = !bActive;
	}
}

defaultproperties
{
     bTrackPlayersOnly=True
     bActive=True
     maxRange=1024
     fireRate=0.2
     gunAccuracy=0.65
     gunDamage=7
     AmmoAmount=100000
     confusionDuration=15.0
}
