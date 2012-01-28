//=============================================================================
// LAM. �������� Ded'�� ��� ���� 2027
// LAM. Copyright (C) 2003 Ded
//=============================================================================
class P_LAM extends LAM;

simulated function Tick(float deltaTime)
{
	local float blinkRate;

	Super.Tick(deltaTime);

	if (bDisabled)
	{
		Skin = Texture'BlackMaskTex';
		return;
	}

	if (fuseLength - time <= 0.75)
		blinkRate = 0.1;
	else if (fuseLength - time <= fuseLength * 0.5)
		blinkRate = 0.3;
	else
		blinkRate = 0.5;

   if ((Level.NetMode == NM_Standalone) || (Role < ROLE_Authority) || (Level.NetMode == NM_ListenServer))
   {
      if (Abs((fuseLength - time)) % blinkRate > blinkRate * 0.5)
         Skin = Texture'BlackMaskTex';
      else
         Skin = Texture'LAM3rdTex1';
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

	Super.SpawnEffects(HitLocation, HitNormal, Other);

	player = DeusExPlayer(GetPlayerPawn());
	dist = Abs(VSize(player.Location - Location));
	
	if (dist ~= 0)
		dist = 10.0;

	if(dist < blastRadius * 2)
		player.ClientFlash(FClamp(blastRadius/dist, 0.0, 4.0), vect(1000,1000,900));

	PlaySound(Sound'DeusExSounds.Weapons.LAMExplode', SLOT_None, 2.0,, blastRadius*20);
	
	AISendEvent('LoudNoise', EAITYPE_Audio, 2.0, blastRadius*20);
	
	if(bEmitWeaponShot)
    	AISendEvent('WeaponFire', EAITYPE_Audio, 2.0, blastRadius*10);

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

defaultproperties
{
	 ExplosionDecal=Class'DeusEx.ScorchMark'
     blastRadius=700.0
     Damage=500.0
     spawnWeaponClass=Class'Game.WeaponLAMGrenade'
     Mesh=LodMesh'DeusExItems.LAMPickup'
     CollisionRadius=4.3
     CollisionHeight=3.8
}