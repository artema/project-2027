class SpyDroneImpl extends SpyDrone
	abstract;

var localized string msgDestroyed;
var localized string msgDeactivated;

var float energytime;
var bool bPlayedTick;

var bool bEnteredWater;

function ZoneChange(ZoneInfo NewZone)
{
	Super.ZoneChange(NewZone);

	if (NewZone.bWaterZone && !bEnteredWater)
	{
		bEnteredWater = True;
		BotEMPHealth = 0;
	}
}

state EMPed
{
	simulated function BeginState()
	{
		BotEMPHealth = 0;
	}
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
    local vector normal;
    local float explosionRadius;
    local Projectile proj;
    local DeusExFragment s;
    local float mult;

    blastRadius = (CollisionRadius + CollisionHeight) * 1.5;
    
	PlaySound(Sound'DeusExSounds.Robot.RobotExplode', SLOT_None, 2.0,, blastRadius*20);
	
	AISendEvent('LoudNoise', EAITYPE_Audio, 2.0, blastRadius*20);

	rot.Pitch = 16384 + FRand() * 16384 - 8192;
	rot.Yaw = FRand() * 65536;
	rot.Roll = 0;

	for (i=0; i<blastRadius/15; i++)
	{
		if (FRand() < 0.9)
		{
			Spawn(class'SFXFireComet', None);

			frag = spawn(class'Rockchip',,, HitLocation);
				
			if (frag != None)
				frag.CalcVelocity(VRand(), blastRadius*1.5);
		}
	}
	
	for (i=0; i<FMax(3, blastRadius/12); i++)
	{
		s = Spawn(class'MetalFragment', Owner);
		if (s != None)
		{
			s.Instigator = Instigator;
			s.CalcVelocity(Velocity, blastRadius);
			s.DrawScale = blastRadius*0.04*FRand();
			s.Skin = GetMeshTexture();
			if (FRand() < 0.75)
				s.bSmoking = True;
		}
	}

	light = Spawn(class'SFXExplosionLight',,, HitLocation);
	light.size = 8;

	expeffect = spawn(class'SFXExplosionMini',,, HitLocation);
	expeffect.ScaleFactor = 0.8;

	expeffect = Spawn(class'SFXExplosionSmoke', None);
	expeffect.ScaleFactor = 0.65;

	if(DeusExPlayer(GetPlayerPawn()).PerkSystem.CheckPerkState(class'PerkBotexplode'))
	{
		mult = FMax(0.5, 3.0 * DeusExPlayer(GetPlayerPawn()).SkillSystem.GetSkillLevelValue(class'SkillTechnics'));
		HurtRadius(450*mult, 450*mult, 'Exploded', 60000, Location);		
		SpawnEmpEffects(HitLocation, HitNormal, Other, 500*mult);
	}
	else
	{
		HurtRadius(0.5*blastRadius, 8*blastRadius, 'Exploded', 100*blastRadius, Location);
	}

	Player.ClientMessage(msgDestroyed);
}

simulated function SpawnEmpEffects(Vector HitLocation, Vector HitNormal, Actor Other, float blastRadius)
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

	if(dist < blastRadius * 2)
		player.ClientFlash(FClamp(blastRadius/dist, 0.0, 4.0), vect(1000,1000,900));

	PlaySound(Sound'DeusExSounds.Weapons.LAMExplode', SLOT_None, 2.0,, blastRadius*20);
	
	AISendEvent('LoudNoise', EAITYPE_Audio, 2.0, blastRadius*20);

    //AISendEvent('WeaponFire', EAITYPE_Audio, 2.0, blastRadius*10);

	rot.Pitch = 16384 + FRand() * 16384 - 8192;
	rot.Yaw = FRand() * 65536;
	rot.Roll = 0;

	if(bStuck)
	{
		gen = spawn(class'ParticleGenerator',,, HitLocation, rot);
		
		if (gen != None)
		{
        	if (bDamaged)
            	gen.RemoteRole = ROLE_SimulatedProxy;
         	else
   				gen.RemoteRole = ROLE_None;
   				
			gen.LifeSpan = FRand() * 5 + 20;//+5
			gen.CheckTime = 0.25;
			gen.particleDrawScale = 0.13;
			gen.RiseRate = 20.0;
			gen.bRandomEject = True;
			gen.particleTexture = Texture'GameMedia.Effects.ef_ExpSmoke009';
		}
	}

	for (i=0; i<blastRadius/50; i++)
	{
		if (FRand() < 0.9)
		{
			loc = Location;
			loc.X += FRand() * blastRadius - blastRadius * 0.5;
			loc.Y += FRand() * blastRadius - blastRadius * 0.5;

			puff = spawn(class'SFXSmokeAfterExplosion',,, loc);
		}
	}
	
	for (i=0; i<blastRadius/25; i++)
	{
		if (FRand() < 0.9)
		{
			Spawn(class'SFXFireComet', None);
			
			if (bDebris && bStuck)
			{
				frag = spawn(class'Rockchip',,, HitLocation);
					
				if (frag != None)
					frag.CalcVelocity(VRand(), blastRadius*1.5);
			}
		}
	}

	light = Spawn(class'SFXExplosionLight',,, HitLocation);
	light.size = 12;

	expeffect = spawn(class'SFXExplosionLarge',,, HitLocation);
	expeffect.ScaleFactor = blastRadius / 500;

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

function Tick(float deltaTime)
{
	local float rate;
	local DeusExPlayer Player;

	Player = DeusExPlayer(GetPlayerPawn());

	energytime += deltaTime;

	if (BotEMPHealth>0)
	{
		if(energytime >= (60 / GetEnergyRate())){
			energytime=0;
			BotEMPHealth--;
		}
	}

	if(BotEMPHealth<=0 && !bPlayedTick)
	{
		bPlayedTick=true;
		Deactivated();
	}
	
	if(bEMPed)
   {
   		if(!IsInState('EMPed'))		
			GotoState('EMPed');
   }
}

function int GetEnergyRate()
{
	local float mult;
	
	mult = FMin(DeusExPlayer(GetPlayerPawn()).SkillSystem.GetAltSkillLevelValue(class'SkillTechnics'), 1.0);
	
	return Max(1, normalrate * mult);
}

function Deactivated()
{
	local SpyDronePickupBase bot;
	local DeusExPlayer Player;

	Player = DeusExPlayer(GetPlayerPawn());
	
	bot = Spawn(PickupClass,,, Location, Rotation);
	
	if(bot != None)
	{
		bot.GrenadeClass = GrenadeClass;
		bot.SetSpawnGrenade(SpawnGrenadeClass);
		bot.BotEMPHealth = BotEMPHealth;
		bot.EMPHitPoints = BotEMPHealth;
		bot.Health = HitPoints;
		bot.DeactivateBot();
	}

	Player.ClientMessage(msgDeactivated);
	
	Destroy();
}

function DoExplode()
{
	//if(HasSpawnGrenade())
	//{		
		Explode(Location, vect(0,0,1));
		
	//}
}

defaultproperties
{
	 elasticity=0.200000
     fuseLength=0.000000
     proxRadius=128.000000
     bHighlight=False
     bBlood=False
     bDebris=False
     blastRadius=128.000000
     DamageType=Exploded
     bEmitDanger=False
     ItemName="Remote Spy Drone"
     MaxSpeed=0.000000
     Damage=20.000000
     ImpactSound=Sound'DeusExSounds.Generic.SmallExplosion2'
     Physics=PHYS_Projectile
     RemoteRole=ROLE_DumbProxy
     LifeSpan=0.000000
     Mesh=LodMesh'DeusExCharacters.SpyDrone'
     SoundRadius=24
     SoundVolume=192
     AmbientSound=Sound'DeusExSounds.Augmentation.AugDroneLoop'
     CollisionRadius=13.000000
     CollisionHeight=2.760000
     Mass=10.000000
     Buoyancy=2.000000
}