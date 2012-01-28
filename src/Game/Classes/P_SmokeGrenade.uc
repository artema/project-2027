//=============================================================================
// ������� �������. �������� Ded'�� ��� ���� 2027
// Smoke grenade. Copyright (C) 2003 Ded
//=============================================================================
class P_SmokeGrenade extends GasGrenade;

var bool bFallen;
var() float realBlastRadius;

event SupportActor( actor StandingActor )
{
	if (!bFallen)
	{
		if (StandingActor.Isa('TruePlayer'))
			SetPhysics(PHYS_Falling);
		bFallen=true;
	}
}

function Frob(Actor Frobber, Inventory frobWith)
{
	bFallen=false;
	Super.Frob(Frobber, frobWith);
}

simulated function Tick(float deltaTime)
{
      Super.Tick(deltaTime);

     MultiSkins[0]=Texture'DeusExItems.Skins.GasGrenadeTex1';
}

simulated function SpawnEffects(Vector HitLocation, Vector HitNormal, Actor Other)
{
	local ExplosionLight light;
    local SFXExplosionFragmented expeffect;
    local float dist;
    local DeusExPlayer player;

	player = DeusExPlayer(GetPlayerPawn());
	dist = Abs(VSize(player.Location - Location));
	
	if (dist ~= 0)
		dist = 10.0;

	if(dist < realBlastRadius)
		player.ClientFlash(FClamp(realBlastRadius/dist, 0.0, 4.0), vect(500,500,500));

	PlaySound(Sound'DeusExSounds.Weapons.GasGrenadeExplode', SLOT_None, 2.0,, realBlastRadius*10);
	AISendEvent('LoudNoise', EAITYPE_Audio, 2.0, realBlastRadius*10);

	SpawnTearGas();

	expeffect = Spawn(class'SFXExplosionFragmented',,, HitLocation);
	
	if(expeffect != None)
		expeffect.ScaleFactor = 0.6;

	light = Spawn(class'ExplosionLight',,, HitLocation);

	if (light != None)
	{
		if (!bDamaged)
			light.RemoteRole = ROLE_None;

		light.size = 8;
		light.LightHue = 80;
		light.LightSaturation = 255;
		light.LightEffect = LE_Shell;
	}
}

function SpawnTearGas()
{
	local vector loc;
	local int i;
	
	for (i=0; i<realBlastRadius/30; i++)
	{
		if (FRand() < 0.9)
		{
			loc = Location;
			loc.X += FRand() * realBlastRadius * 0.5 - FRand() * realBlastRadius;
			loc.Y += FRand() * realBlastRadius * 0.5 - FRand() * realBlastRadius;

			spawn(class'SFXSmokeGrenade',,, loc);
		}
	}
}

function PostBeginPlay()
{
	local ParticleGenerator launchGen;
	
	Super.PostBeginPlay();
	
	launchGen = Spawn(class'ParticleGenerator', Self);
	
	if (launchGen != None)
	{
        launchGen.RemoteRole = ROLE_None;
        launchGen.bScale = True;
		launchGen.particleTexture = Texture'GameMedia.Effects.ef_ExpSmoke005';
		launchGen.particleDrawScale = 0.35;
		launchGen.checkTime = 0.01;
		launchGen.riseRate = 200.0;
		launchGen.ejectSpeed = 150.0;
		launchGen.particleLifeSpan = 1.0;
		launchGen.bRandomEject = True;
		launchGen.SetBase(Self);
		launchGen.LifeSpan = fuseLength + 1;
	}
}

defaultproperties
{
	 realBlastRadius=512.0
	 blastRadius=1.0
	 bHighlight=False
     MultiSkins(0)=Texture'DeusExItems.Skins.GasGrenadeTex1'
     fuseLength=3.0
     proxRadius=128.0
     AISoundLevel=0.0
     bBlood=False
     bDebris=False
     DamageType=TearGas
     spawnWeaponClass=None
     speed=1000.0
     MaxSpeed=1000.0
     Damage=0.0
     MomentumTransfer=50000
     Mesh=LodMesh'DeusExItems.GasGrenadePickup'
     CollisionRadius=4.3
     CollisionHeight=1.4
     Mass=5.0
     Buoyancy=2.0
     LifeSpan=10
}
