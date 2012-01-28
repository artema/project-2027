//=============================================================================
// Система погоды. Сделанно Ded'ом для мода 2027
// Weather system. Copyright (C) 2005 Smoke39 - bomberman49@hotmail.com
// (Modified by Ded (C) 2005)
//=============================================================================
class WeatherDropRain extends WeatherDrop;

defaultproperties
{
	FallingSpeed=1100
    LifeSpan=3.00
    Skin=Texture'Game.Skins.WeatherRainDrop'
    Mesh=LodMesh'DeusExItems.Tracer'
    DrawScale=0.25
    CollisionHeight=20.00
}
