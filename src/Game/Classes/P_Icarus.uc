class P_Icarus extends ThrownProjectile;

#exec OBJ LOAD FILE=GameEffects

var bool bPlaySound;

auto simulated state Flying
{
	simulated function ProcessTouch (Actor Other, Vector HitLocation)
	{
		if (bStuck || bRicocheted)
			return;

		if ((Other != instigator) && (DeusExProjectile(Other) == None) && (Other != Owner))
		{
			damagee = Other;
			Explode(HitLocation, Normal(HitLocation-damagee.Location));

         	if (Role == ROLE_Authority)
			{
            	if (damagee.IsA('Pawn') && !damagee.IsA('Robot') && bBlood)
            		SpawnBlood(HitLocation, Normal(HitLocation-damagee.Location));
			}
		}
	}
	
	simulated function Explode(vector HitLocation, vector HitNormal)
	{
		local ShockRing ring;
		local DeusExPlayer player;
		local float dist;

		player = DeusExPlayer(Owner);

		if ((Level.NetMode != NM_DedicatedServer) || (Role < ROLE_Authority) || bDamaged)
			SpawnEffects(HitLocation, HitNormal, None);

		if(bPlaySound)
			PlayImpactSound();

		if ( AISoundLevel > 0.0 )
			AISendEvent('LoudNoise', EAITYPE_Audio, 2.0, AISoundLevel*class'WeaponMinibotIcarus'.Default.FlashRadius*16);

		GotoState('Exploding');
	}
	
	simulated function HitWall (vector HitNormal, actor HitWall)
	{
		Explode(Location, HitNormal);
	}
	
	simulated function BeginState()
	{
		local Rotator newRot;

		DrawScale = 0.5;

		initLoc = Location;
		initDir = vector(Rotation);	

		newRot = Rotation;
    	newRot.Pitch = (16384 * 0.4) + (16384 * 0.4 * FRand());
   		SetRotation(newRot);
		Velocity = speed*vector(Rotation);
	}
}

function PlayImpactSound()
{
	PlaySound(ImpactSound, SLOT_None, 4.0,, Max(class'WeaponMinibotIcarus'.Default.FlashRadius*12, 1024), FClamp(DeusExPlayer(GetPlayerPawn()).GetSoundPitchMultiplier(), 1.0, 1.5));
}

simulated function BeginPlay()
{
	speed = (Default.speed * 0.6) + (Default.speed * 0.4 *FRand());
	fuseLength = Default.fuseLength + (Default.fuseLength * FRand() * 2);	

	Super.BeginPlay();
	
	DrawScale = 0.25;	
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
    local SFXExplosionSmoke smoke;
    local ScriptedPawn pawn;
    local Vector offset;
    local float flashRadius;

	Super.SpawnEffects(HitLocation, HitNormal, Other);

	flashRadius = class'WeaponMinibotIcarus'.Default.FlashRadius;

	player = DeusExPlayer(GetPlayerPawn());
	dist = Abs(VSize(player.Location - Location));
	
	if (dist ~= 0)
		dist = 10.0;

	if(dist < flashRadius * 0.5)
		player.ClientFlash(FClamp(FlashRadius/dist, 0.0, 4.0), vect(1000,1000,900));

	light = Spawn(class'SFXExplosionLight',,, HitLocation);
	light.size = 2;

	expeffect = spawn(class'SFXExplosionMini',,, HitLocation);
	expeffect.ScaleFactor = 0.35;
	
	if(FRand() < 0.3)
	{
		smoke = Spawn(class'SFXExplosionSmoke',,, HitLocation);
		smoke.ScaleFactor = 0.4;
	}
	
	if(FRand() < 0.15)
	{
		puff = spawn(class'SFXSmokeAfterExplosion',,, HitLocation);
	}
}

defaultproperties
{
	 fuseLength=0.35
	 blastRadius=0.1
     DamageType=Exploded
     Damage=1.0
     
     AccurateRange=400
     maxRange=800
     speed=700.0
     MaxSpeed=900.0
     MomentumTransfer=40000
     
	 bHighlight=False
     bExplodes=True
     bBlood=False
     bDebris=False

     ImpactSound=Sound'DeusExSounds.Generic.MediumExplosion1'
     ExplosionDecal=Class'DeusEx.ScorchMark'
     
     bUnlit=True
     DrawScale=0.25
	 Mesh=LodMesh'GameMedia.BallPool'
	 MultiSkins(0)=FireTexture'GameEffect.FirePalette'
     CollisionRadius=0.42
     CollisionHeight=0.42
     Mass=0.2
     Buoyancy=2.0
}