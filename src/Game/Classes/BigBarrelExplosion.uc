//=============================================================================
// ������ �������� ������. ������� Ded'�� ��� ���� 2027
// Big Explosion Effect. Copyright (C) 2003 Ded
//=============================================================================
class BigBarrelExplosion extends Effects;

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
    local SFXExplosionFragmented exp;
    local SFXExplosionLight light;
	local Rockchip chip;

	player = DeusExPlayer(GetPlayerPawn());

     for (i=0; i<15; i++)
     {
		Spawn(class'SFXFireComet', None);

        frag = Spawn(class'MetalFragment',None);
		frag.CalcVelocity(vect(10000,0,0), 512);
		frag.DrawScale = 1.0 + 1.0 * FRand();
		frag.bSmoking = True;
		
		chip = spawn(class'Rockchip', None);
					
		if (chip != None)
			chip.CalcVelocity(VRand(), 512);
     }

	Spawn(class'SFXExplosionSmoke', None);

    exp = Spawn(class'SFXExplosionFragmented', None);
    
    if(exp != None)
   		exp.ScaleFactor = 4.5;

	//AISendEvent('LoudNoise', EAITYPE_Audio, , 1000);
	Player.PlaySound(Sound'LargeExplosion2', SLOT_None, 255,, 163840);
	Player.ShakeView(1.5, 2048.0, 20.0);
	
	light = Spawn(class'SFXExplosionLight', None);
	light.size = 12;
}

defaultproperties
{
}
