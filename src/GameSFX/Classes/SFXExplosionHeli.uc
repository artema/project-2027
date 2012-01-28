class SFXExplosionHeli extends Effects;

function PostBeginPlay()
{
	local DeusExPlayer player;
    local int i;
    local float blastRadius;
    local Vector loc;
    local SFXExplosionLight light;
    local AnimatedSprite expeffect;
    local MetalFragment frag;
    local Rockchip chip;
    
    player = DeusExPlayer(GetPlayerPawn());
    blastRadius = 1000;

	Super.PostBeginPlay();
	
	PlaySound(Sound'DeusExSounds.Generic.LargeExplosion2', SLOT_None, 5.0,, blastRadius*60);
	
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
	
	light = Spawn(class'SFXExplosionLight',,, Location);
	
	if(light != None)
		light.size = 28;

	expeffect = spawn(class'SFXExplosionLarge',,, Location);
	expeffect.ScaleFactor = 12.0;

	for (i=0; i<30; i++)
     {
		Spawn(class'SFXFireComet', None);

        frag = Spawn(class'MetalFragment',None);
		frag.CalcVelocity(vect(40000,0,0), 300);
		frag.DrawScale = 2.0 + 2.0 * FRand();
		frag.bSmoking = True;
		
		chip = spawn(class'Rockchip', None);
					
		if (chip != None)
			chip.CalcVelocity(VRand(), 1024);
     }

	Spawn(class'SFXExplosionSmoke', None);
	
	player.ShakeView(1.5, 2048.0, 20.0);
}

defaultproperties
{
}