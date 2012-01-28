//=============================================================================
// Система погоды. Сделанно Ded'ом для мода 2027
// Weather system. Copyright (C) 2005 Smoke39 - bomberman49@hotmail.com
// (Modified by Ded (C) 2005)
//=============================================================================
class WeatherZoneRain extends WeatherZone;

defaultproperties
{
    PrecipRad=650.00
    PrecipFreq=0.01
    PrecipDensity=7
    PrecipAmp=135
    PrecipClass=Class'WeatherDropRain'
    bSlanty=false
    bHasSplash=True
    WaterImpactClass=Class'WeatherDropRing'
    GroundImpactClass=Class'WeatherRainSplash'
    WaterImpactSpawnProb=1.00
    GroundImpactSpawnProb=0.6
    Texture=Texture'Game.Icons.RainMaker_Icon'
}
