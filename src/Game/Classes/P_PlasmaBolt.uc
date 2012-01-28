//=============================================================================
// ������. �������� Ded'�� ��� ���� 2027
// Plasma. Copyright (C) 2003 Ded
//=============================================================================
class P_PlasmaBolt extends DeusExProjectile;

var ParticleGenerator pGen1;
var ParticleGenerator pGen2;

#exec OBJ LOAD FILE=Effects

simulated function DrawExplosionEffects(vector HitLocation, vector HitNormal)
{
	local ParticleGenerator gen;

	gen = Spawn(class'ParticleGenerator',,, HitLocation, Rotator(HitNormal));
	if (gen != None)
	{
                gen.RemoteRole = ROLE_None;
		gen.particleDrawScale = 1.0;
		gen.checkTime = 0.10;
		gen.frequency = 1.0;
		gen.ejectSpeed = 200.0;
		gen.bGravity = True;
		gen.bRandomEject = True;
		gen.particleLifeSpan = 0.75;
		gen.particleTexture = Texture'Effects.Fire.Proj_PRifle';
		gen.LifeSpan = 1.3;
	}
}

function PostBeginPlay()
{
	Super.PostBeginPlay();

   if ((Level.NetMode == NM_Standalone) || (Level.NetMode == NM_ListenServer))
      SpawnPlasmaEffects();
}

simulated function PostNetBeginPlay()
{
   if (Role < ROLE_Authority)
      SpawnPlasmaEffects();
}

simulated function SpawnPlasmaEffects()
{
	local Rotator rot;
   rot = Rotation;
	rot.Yaw -= 32768;

   pGen2 = Spawn(class'ParticleGenerator', Self,, Location, rot);
	if (pGen2 != None)
	{
                pGen2.RemoteRole = ROLE_None;
		pGen2.particleTexture = Texture'Effects.Fire.Proj_PRifle';
		pGen2.particleDrawScale = 0.1;
		pGen2.checkTime = 0.04;
		pGen2.riseRate = 0.0;
		pGen2.ejectSpeed = 100.0;
		pGen2.particleLifeSpan = 0.5;
		pGen2.bRandomEject = True;
		pGen2.SetBase(Self);
	}
   
}

simulated function Destroyed()
{
	if (pGen1 != None)
		pGen1.DelayedDestroy();
	if (pGen2 != None)
		pGen2.DelayedDestroy();

	Super.Destroyed();
}

defaultproperties
{
     bExplodes=True
     blastRadius=128.000000
     DamageType=Burned
     AccurateRange=14400
     maxRange=24000
     bIgnoresNanoDefense=True
     speed=1500.000000
     MaxSpeed=1500.000000
     Damage=55.000000
     MomentumTransfer=5000
     ImpactSound=Sound'DeusExSounds.Weapons.PlasmaRifleHit'
     ExplosionDecal=Class'DeusEx.ScorchMark'
     Mesh=LodMesh'DeusExItems.PlasmaBolt'
     DrawScale=3.000000
     bUnlit=True
     LightType=LT_Steady
     LightEffect=LE_NonIncidence
     LightBrightness=200
     LightHue=80
     LightSaturation=128
     LightRadius=5
     bFixedRotationDir=True
}
