//=============================================================================
// ������ �������� ������. ������� Ded'�� ��� ���� 2027
// Big Explosion Effect. Copyright (C) 2003 Ded
//=============================================================================
class SFXCargoExplosion extends Effects;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

        ExplEffects();
        Destroy();
}

function ExplEffects()
{
	local int i;
	local MetalFragment frag;
    local DeusExPlayer player;
    local SFXExplosionLarge exp;
    local SFXExplosionLight light;
	local Rockchip chip;
	local Vector loc;
	local SFXShockRing ring;
	local float blastRadius;
	local PoisonGas gas;
	
	blastRadius = 650;

	 player = DeusExPlayer(GetPlayerPawn());

	 for (i=0; i<blastRadius/15; i++)
     {
		Spawn(class'SFXFireComet', None);
     }

     for (i=0; i<blastRadius/15; i++)
     {
        frag = Spawn(class'MetalFragment',None);
		frag.CalcVelocity(vect(40000,0,0), blastRadius);
		frag.DrawScale = 2.0 + 2.0 * FRand();
		frag.bSmoking = True;
		
		chip = spawn(class'Rockchip', None);
					
		if (chip != None)
			chip.CalcVelocity(VRand(), 1024);
     }

	for (i=0; i<blastRadius/30; i++)
	{
		if (FRand() < 0.9)
		{
			loc = Location;
			loc.X += FRand() * blastRadius - blastRadius * 0.5;
			loc.Y += FRand() * blastRadius - blastRadius * 0.5;

			spawn(class'SFXSmokeAfterExplosion',,, loc);
		}
	}

	Spawn(class'SFXExplosionSmoke', None);

    exp = Spawn(class'SFXExplosionLarge', None);
    
    if(exp != None)
   		exp.ScaleFactor = 3.5;

	AISendEvent('LoudNoise', EAITYPE_Audio, , 10000);
	Player.PlaySound(Sound'LargeExplosion2', SLOT_None, 255,, 163840);
	Player.ShakeView(1.5, 2048.0, 20.0);
	
	light = Spawn(class'SFXExplosionLight', None);
	light.size = 20;
	
	ring = Spawn(class'SFXShockRing',,, Location, rot(16384,0,0));
	  if (ring != None)
	  {
	     ring.RemoteRole = ROLE_None;
	     ring.size = blastRadius / 50.0;
	  }
	  ring = Spawn(class'SFXShockRing',,, Location, rot(0,0,0));
	  if (ring != None)
	  {
	     ring.RemoteRole = ROLE_None;
	     ring.size = blastRadius / 50.0;
	  }
	  ring = Spawn(class'SFXShockRing',,, Location, rot(0,16384,0));
	  if (ring != None)
	  {
	     ring.RemoteRole = ROLE_None;
	     ring.size = blastRadius / 50.0;
	  }
	  
	  HurtRadius
		(
			200,
			blastRadius*1.5,
			'Exploded',
			10000,
			Location
		);
		
				for (i=0; i<blastRadius/16; i++)
				{
					loc = Location;
					loc.X += FRand() * blastRadius - blastRadius * 0.5;
					loc.Y += FRand() * blastRadius - blastRadius * 0.5;
					//loc.Z += 32;
					gas = spawn(class'PoisonGas', None,, loc);
					if (gas != None)
					{
						gas.Velocity = vect(0,0,0);
						gas.Acceleration = vect(0,0,0);
						gas.DrawScale = FRand() * 0.5 + 2.0;
						gas.LifeSpan = FRand() * 10 + 40;
						gas.bFloating = True;
						gas.Instigator = player;
					}
				}
}

defaultproperties
{
}
