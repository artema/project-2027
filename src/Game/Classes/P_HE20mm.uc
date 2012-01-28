//=============================================================================
// 20�� �������. �������� Ded'�� ��� ���� 2027
// HE Grenade. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class P_HE20mm extends DeusExProjectile;

var ParticleGenerator smokeGen;

function PostBeginPlay()
{
	Super.PostBeginPlay();

   SpawnSmokeEffects();
}

simulated function PostNetBeginPlay()
{
   Super.PostNetBeginPlay();
   
   if (Role != ROLE_Authority)
      SpawnSmokeEffects();
}

simulated function SpawnSmokeEffects()
{
	smokeGen = Spawn(class'ParticleGenerator', Self);
	if (smokeGen != None)
	{
		smokeGen.particleTexture = Texture'Effects.Smoke.SmokePuff1';
		smokeGen.particleDrawScale = 0.3;
		smokeGen.checkTime = 0.02;
		smokeGen.riseRate = 8.0;
		smokeGen.ejectSpeed = 0.0;
		smokeGen.particleLifeSpan = 2.0;
		smokeGen.bRandomEject = True;
		smokeGen.SetBase(Self);
                smokeGen.RemoteRole = ROLE_None;
	}
}

simulated function Destroyed()
{
	if (smokeGen != None)
		smokeGen.DelayedDestroy();

	Super.Destroyed();
}

defaultproperties
{
     bExplodes=True
     bBlood=True
     bDebris=True
     blastRadius=350.000000
     DamageType=exploded
     AccurateRange=400
     maxRange=800
     speed=1000.000000
     MaxSpeed=1000.000000
     Damage=150.000000
     MomentumTransfer=40000
     SpawnSound=Sound'Game.Weapons.M23FireHE'
     ImpactSound=Sound'DeusExSounds.Generic.MediumExplosion2'
     ExplosionDecal=Class'DeusEx.ScorchMark'
     Mesh=LodMesh'GameMedia.HEGrenade'
}
