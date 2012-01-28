//=============================================================================
// ������ �������� ������. ������� Ded'�� ��� ���� 2027
// Big Explosion Effect. Copyright (C) 2003 Ded
//=============================================================================
class BigFuelExplosion extends Effects;

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

	player = DeusExPlayer(GetPlayerPawn());

     for (i=0; i<15; i++)
     {
		Spawn(class'SFXFireComet', None);

        frag = Spawn(class'MetalFragment',None);
		frag.CalcVelocity(vect(40000,0,0), 1024);
		frag.DrawScale = 3.0 + 2.0 * FRand();
		frag.bSmoking = True;
		
		chip = spawn(class'Rockchip', None);
					
		if (chip != None)
			chip.CalcVelocity(VRand(), 1024);
     }

	Spawn(class'SFXExplosionSmoke', None);

    exp = Spawn(class'SFXExplosionLarge', None);
    
    if(exp != None)
   		exp.ScaleFactor = 3.0;

	AISendEvent('LoudNoise', EAITYPE_Audio, , 10000);
	Player.PlaySound(Sound'LargeExplosion2', SLOT_None, 255,, 163840);
	Player.ShakeView(1.5, 2048.0, 20.0);
	
	light = Spawn(class'SFXExplosionLight', None);
	light.size = 12;
}

defaultproperties
{
}
