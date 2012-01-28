class SpyDronePickupImpl extends SpyDronePickupBase
	abstract;

var localized string msgDestroyed;

function Explode(vector HitLocation)
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
    local float blastRadius;
    local Projectile proj;
    local DeusExFragment s;

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
	expeffect.ScaleFactor = 0.75;

	/*player.DoExplosionSilence();*/

	if(HasSpawnGrenade())
	{
		proj = Spawn(GrenadeClass,,, HitLocation);

		if (DeusExProjectile(proj) != None)
		{
			DeusExProjectile(proj).Instigator = Instigator;
			DeusExProjectile(proj).blastRadius *= Max(0.75, 2.0 * DeusExPlayer(GetPlayerPawn()).SkillSystem.GetSkillLevelValue(class'SkillTechnics'));
			DeusExProjectile(proj).Explode(Location, normal);			
		}
	}

	HurtRadius(0.5*blastRadius, 8*blastRadius, 'Exploded', 100*blastRadius, Location);

	Player.ClientMessage(msgDestroyed);
}

state Disabled
{
	ignores bump, reacttoinjury;
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

function Frob(Actor Frobber, Inventory frobWith)
{
	local SpyDroneItem cdc;
	local DeusExPlayer Player;

	Player = DeusExPlayer(GetPlayerPawn());

	cdc = Spawn(PickupClass,,, Location, Rotation);
	
	if (cdc != None)
	{
		cdc.SetPhysics(PHYS_None);
		cdc.BotEMPHealth = EMPHitPoints;
		cdc.SpawnGrenadeClass = SpawnGrenadeClass;
		Player.FrobTarget = cdc;
		Player.ParseRightClick();
		Destroy();
	}		
}

defaultproperties
{
	 DrawType=DT_Mesh
	 Mesh=LodMesh'DeusExCharacters.SpyDrone'
     CollisionRadius=13.000000
     CollisionHeight=2.760000
     Mass=10.000000
     Buoyancy=2.000000
}