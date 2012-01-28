//=============================================================================
// ������ LAW. �������� Ded'�� ��� ���� 2027
// LAW rocket. Copyright (C) 2003 Ded
//=============================================================================
class P_RocketLAW extends Rocket;

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

	if(dist < blastRadius * 1.3)
		player.ClientFlash(FClamp(blastRadius/dist, 0.0, 4.0), vect(1000,1000,900));


	rot.Pitch = 16384 + FRand() * 16384 - 8192;
	rot.Yaw = FRand() * 65536;
	rot.Roll = 0;

	if(bStuck)
	{
		gen = spawn(class'ParticleGenerator',,, HitLocation, rot);
		
		if (gen != None)
		{
   			gen.RemoteRole = ROLE_None;   				
			gen.LifeSpan = FRand() * 5 + 40;//+5
			gen.CheckTime = 0.25;
			gen.particleDrawScale = 0.13;
			gen.RiseRate = 20.0;
			gen.bRandomEject = True;
			gen.particleTexture = Texture'GameMedia.Effects.ef_ExpSmoke009';
		}
	}

	for (i=0; i<blastRadius/30; i++)
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
			if (FRand() < 0.3)
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
	
	if(light != None)
		light.size = 18;

	expeffect = spawn(class'SFXExplosionBig',,, HitLocation);
	expeffect.ScaleFactor = 3.0;

	for (i=0; i<6; i++)
		Spawn(class'SFXFireComet', None);

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

defaultproperties
{
     blastRadius=1280.000000
     Damage=1000.000000
     MomentumTransfer=40000
     SpawnSound=Sound'DeusExSounds.Robot.RobotFireRocket'
     Mesh=LodMesh'DeusExItems.RocketLAW'
     DrawScale=1.000000
     AmbientSound=Sound'DeusExSounds.Weapons.LAWApproach'
}
