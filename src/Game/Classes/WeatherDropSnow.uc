//=============================================================================
// Система погоды. Сделанно Ded'ом для мода 2027
// Weather system. Copyright (C) 2005 Smoke39 - bomberman49@hotmail.com
// (Modified by Ded (C) 2005)
//=============================================================================
class WeatherDropSnow extends WeatherDrop;

function PostBeginPlay()
{
    super.PostBeginPlay();

	if ((FRand() > 0.0) && (FRand() < 0.2))
	   Texture = Texture'Game.Skins.SnowFlake1';
	else if ((FRand() > 0.2) && (FRand() < 0.4))
	   Texture = Texture'Game.Skins.SnowFlake2';
	else if ((FRand() > 0.4) && (FRand() < 0.6))
	   Texture = Texture'Game.Skins.SnowFlake3';
	else if ((FRand() > 0.6) && (FRand() < 0.7))
	   Texture = Texture'Game.Skins.SnowFlake1';
        else if ((FRand() > 0.7) && (FRand() < 0.9))
	   Texture = Texture'Game.Skins.SnowFlake2';
        else
	  Texture = Texture'Game.Skins.SnowFlake3';
}

function Randomize()
{
	Velocity.Z = -FallingSpeed - FRand()*800;
	//DrawScale = Default.DrawScale * (1 + FRand()*2);
	ScaleGlow = 0.3 + FRand()*0.6;
}

defaultproperties
{
    FallingSpeed=210
    LifeSpan=5.00
    Skin=Texture'Game.Skins.SnowFlake1'
    Texture=Texture'Game.Skins.SnowFlake1'
    DrawType=DT_Sprite
    Style=STY_Translucent
    DrawScale=0.2
    CollisionHeight=20.00
}
